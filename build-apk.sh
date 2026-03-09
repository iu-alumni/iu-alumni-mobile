#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# build-apk.sh — Build a signed release APK for RuStore using Docker
#
# No Flutter installation required — everything runs inside a Docker container.
#
# USAGE
#   ./build-apk.sh [options]
#
# OPTIONS
#   --api-url URL          Backend API base URL (default: https://api.alumap.ru)
#   --version-name VER     App version name, e.g. 1.2.0  (default: from pubspec)
#   --version-code CODE    App version code, e.g. 5      (default: from pubspec)
#   --output-dir DIR       Where to copy the final APK   (default: ./release)
#   --flutter-version VER  Flutter version to use        (default: stable)
#   --generate-keystore    Generate a NEW keystore and exit (first-time setup)
#   --help                 Show this help
#
# REQUIRED ENVIRONMENT VARIABLES (for signing)
#   KEYSTORE_PATH   Absolute path to the .jks / .keystore file
#   KEYSTORE_PASS   Keystore password
#   KEY_ALIAS       Key alias inside the keystore   (default: upload)
#   KEY_PASS        Key password                    (default: same as KEYSTORE_PASS)
#
# OPTIONAL ENVIRONMENT VARIABLES
#   APP_METRICA_KEY     AppMetrica analytics key
#   IU_ALUMNI_WEB_SALT  Web salt for encryption
#
# FIRST-TIME SETUP — generate a keystore (requires keytool, part of any JDK)
#   ./build-apk.sh --generate-keystore
#   Then export KEYSTORE_PATH, KEYSTORE_PASS, KEY_ALIAS, KEY_PASS and run again.
#
# EXAMPLE
#   export KEYSTORE_PATH="$HOME/iu-alumni-release.jks"
#   export KEYSTORE_PASS="s3cr3t"
#   export KEY_ALIAS="upload"
#   export KEY_PASS="s3cr3t"
#   ./build-apk.sh --api-url https://api.alumap.ru --version-name 1.0.0 --version-code 1
# ---------------------------------------------------------------------------
set -euo pipefail

# ── Defaults ─────────────────────────────────────────────────────────────────
API_URL="${API_URL:-https://api.alumap.ru}"
OUTPUT_DIR="./release"
VERSION_NAME=""
VERSION_CODE=""
FLUTTER_VERSION="stable"
GENERATE_KEYSTORE=false

# ── Argument parsing ──────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case "$1" in
    --api-url)           API_URL="$2";          shift 2 ;;
    --version-name)      VERSION_NAME="$2";     shift 2 ;;
    --version-code)      VERSION_CODE="$2";     shift 2 ;;
    --output-dir)        OUTPUT_DIR="$2";       shift 2 ;;
    --flutter-version)   FLUTTER_VERSION="$2";  shift 2 ;;
    --generate-keystore) GENERATE_KEYSTORE=true; shift ;;
    --help)
      grep '^#' "$0" | sed 's/^# \?//' | sed -n '/^USAGE/,/^---/p'
      exit 0 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# ── Generate keystore (first-time setup) ──────────────────────────────────────
if [[ "$GENERATE_KEYSTORE" == true ]]; then
  KEYSTORE_OUT="$HOME/iu-alumni-release.jks"
  echo "Generating release keystore at: $KEYSTORE_OUT"
  echo "You will be prompted for certificate details. Remember the passwords you enter."
  echo ""

  # Use keytool from host if available, otherwise run it in Docker
  if command -v keytool &>/dev/null; then
    keytool -genkey -v \
      -keystore "$KEYSTORE_OUT" \
      -alias upload \
      -keyalg RSA -keysize 2048 -validity 10000
  else
    echo "(keytool not found locally — running inside Docker)"
    docker run --rm -it \
      -v "$(dirname "$KEYSTORE_OUT"):/keystore" \
      eclipse-temurin:17-jdk \
      keytool -genkey -v \
        -keystore "/keystore/$(basename "$KEYSTORE_OUT")" \
        -alias upload \
        -keyalg RSA -keysize 2048 -validity 10000
  fi

  echo ""
  echo "✅ Keystore created: $KEYSTORE_OUT"
  echo ""
  echo "Export these before building:"
  echo "  export KEYSTORE_PATH=\"$KEYSTORE_OUT\""
  echo "  export KEYSTORE_PASS=\"<your-keystore-password>\""
  echo "  export KEY_ALIAS=\"upload\""
  echo "  export KEY_PASS=\"<your-key-password>\""
  exit 0
fi

# ── Validate signing env vars ─────────────────────────────────────────────────
: "${KEYSTORE_PATH:?KEYSTORE_PATH is required. Run './build-apk.sh --generate-keystore' first.}"
: "${KEYSTORE_PASS:?KEYSTORE_PASS is required.}"
KEY_ALIAS="${KEY_ALIAS:-upload}"
KEY_PASS="${KEY_PASS:-$KEYSTORE_PASS}"

KEYSTORE_PATH="$(cd "$(dirname "$KEYSTORE_PATH")" && pwd)/$(basename "$KEYSTORE_PATH")"
if [[ ! -f "$KEYSTORE_PATH" ]]; then
  echo "Error: keystore not found at: $KEYSTORE_PATH"
  exit 1
fi

# ── Check Docker ───────────────────────────────────────────────────────────────
if ! command -v docker &>/dev/null; then
  echo "Error: Docker is not installed or not in PATH."
  echo "Install Docker: https://docs.docker.com/get-docker/"
  exit 1
fi

# ── Resolve repo root ─────────────────────────────────────────────────────────
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Flutter Docker image ──────────────────────────────────────────────────────
# ghcr.io/cirruslabs/flutter includes Flutter + Dart + Android SDK + build tools
FLUTTER_IMAGE="ghcr.io/cirruslabs/flutter:${FLUTTER_VERSION}"

echo "Flutter image : $FLUTTER_IMAGE"
echo "API URL       : $API_URL"
echo "Keystore      : $KEYSTORE_PATH"
[[ -n "$VERSION_NAME" ]] && echo "Version       : $VERSION_NAME+$VERSION_CODE"
echo ""

# ── Build the flutter build command ───────────────────────────────────────────
BUILD_CMD="flutter pub get \
  && dart run build_runner build --delete-conflicting-outputs \
  && flutter build apk --release \
       --dart-define=API_BASE_URL=\"${API_URL}\" \
       --dart-define=APP_METRICA_KEY=\"${APP_METRICA_KEY:-}\" \
       --dart-define=IU_ALUMNI_WEB_SALT=\"${IU_ALUMNI_WEB_SALT:-}\""

if [[ -n "$VERSION_NAME" && -n "$VERSION_CODE" ]]; then
  BUILD_CMD="${BUILD_CMD} --build-name=\"${VERSION_NAME}\" --build-number=\"${VERSION_CODE}\""
fi

# ── Run build inside Docker ────────────────────────────────────────────────────
echo "▶ Running Flutter build in Docker..."
docker run --rm \
  -v "${REPO_DIR}:/app" \
  -v "${KEYSTORE_PATH}:/keystore/release.jks:ro" \
  -e KEYSTORE_PATH=/keystore/release.jks \
  -e KEYSTORE_PASS="${KEYSTORE_PASS}" \
  -e KEY_ALIAS="${KEY_ALIAS}" \
  -e KEY_PASS="${KEY_PASS}" \
  -w /app \
  "${FLUTTER_IMAGE}" \
  bash -c "${BUILD_CMD}"

# ── Copy APK to output dir ────────────────────────────────────────────────────
APK_SRC="${REPO_DIR}/build/app/outputs/flutter-apk/app-release.apk"

if [[ ! -f "$APK_SRC" ]]; then
  echo "Error: expected APK not found at $APK_SRC"
  exit 1
fi

mkdir -p "${REPO_DIR}/${OUTPUT_DIR}"

if [[ -n "$VERSION_NAME" ]]; then
  APK_DEST="${REPO_DIR}/${OUTPUT_DIR}/iu-alumni-${VERSION_NAME}.apk"
else
  APK_DEST="${REPO_DIR}/${OUTPUT_DIR}/iu-alumni-release.apk"
fi

cp "$APK_SRC" "$APK_DEST"

echo ""
echo "✅ APK ready: $APK_DEST"
echo "   Size: $(du -sh "$APK_DEST" | cut -f1)"
echo ""
echo "Next steps for RuStore upload:"
echo "  1. Go to https://developer.rustore.ru and open your app"
echo "  2. Create a new release → upload $APK_DEST"
echo "  3. Fill in release notes (Russian required)"
echo "  4. Submit for review"
