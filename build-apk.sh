#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# build-apk.sh — Build a signed release APK for RuStore distribution
#
# USAGE
#   ./build-apk.sh [options]
#
# OPTIONS
#   --api-url URL          Backend API base URL (default: https://api.alumap.ru)
#   --version-name VER     App version name, e.g. 1.2.0  (default: from pubspec)
#   --version-code CODE    App version code, e.g. 5      (default: from pubspec)
#   --output-dir DIR       Where to copy the final APK   (default: ./release)
#   --generate-keystore    Generate a NEW keystore and exit (first-time setup)
#   --help                 Show this help
#
# REQUIRED ENVIRONMENT VARIABLES (for signing)
#   KEYSTORE_PATH   Absolute path to the .jks keystore file
#   KEYSTORE_PASS   Keystore password
#   KEY_ALIAS       Key alias inside the keystore   (default: upload)
#   KEY_PASS        Key password                    (default: same as KEYSTORE_PASS)
#
# OPTIONAL ENVIRONMENT VARIABLES
#   APP_METRICA_KEY     AppMetrica analytics key
#   IU_ALUMNI_WEB_SALT  Web salt for encryption
#
# FIRST-TIME SETUP — generate a keystore
#   ./build-apk.sh --generate-keystore
#   Then set KEYSTORE_PATH, KEYSTORE_PASS, KEY_ALIAS, KEY_PASS and run again.
#
# EXAMPLE
#   export KEYSTORE_PATH="$HOME/iu-alumni-release.jks"
#   export KEYSTORE_PASS="s3cr3t"
#   export KEY_ALIAS="upload"
#   export KEY_PASS="s3cr3t"
#   ./build-apk.sh --api-url https://api.alumap.ru --version-name 1.0.0 --version-code 1
# ---------------------------------------------------------------------------
set -euo pipefail

# ── Defaults ────────────────────────────────────────────────────────────────
API_URL="${API_URL:-https://api.alumap.ru}"
OUTPUT_DIR="./release"
VERSION_NAME=""
VERSION_CODE=""
GENERATE_KEYSTORE=false

# ── Argument parsing ─────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case "$1" in
    --api-url)         API_URL="$2";        shift 2 ;;
    --version-name)    VERSION_NAME="$2";   shift 2 ;;
    --version-code)    VERSION_CODE="$2";   shift 2 ;;
    --output-dir)      OUTPUT_DIR="$2";     shift 2 ;;
    --generate-keystore) GENERATE_KEYSTORE=true; shift ;;
    --help)
      sed -n '/^# USAGE/,/^# ---/p' "$0" | sed 's/^# \?//'
      exit 0 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# ── Generate keystore (first-time setup) ─────────────────────────────────────
if [[ "$GENERATE_KEYSTORE" == true ]]; then
  KEYSTORE_OUT="$HOME/iu-alumni-release.jks"
  echo "Generating release keystore at: $KEYSTORE_OUT"
  echo "You will be prompted for details. Remember the passwords you enter."
  keytool -genkey -v \
    -keystore "$KEYSTORE_OUT" \
    -alias upload \
    -keyalg RSA \
    -keysize 2048 \
    -validity 10000
  echo ""
  echo "Keystore created: $KEYSTORE_OUT"
  echo ""
  echo "Set these environment variables before building:"
  echo "  export KEYSTORE_PATH=\"$KEYSTORE_OUT\""
  echo "  export KEYSTORE_PASS=\"<your-keystore-password>\""
  echo "  export KEY_ALIAS=\"upload\""
  echo "  export KEY_PASS=\"<your-key-password>\""
  exit 0
fi

# ── Validate signing env vars ────────────────────────────────────────────────
: "${KEYSTORE_PATH:?KEYSTORE_PATH is required. Run './build-apk.sh --generate-keystore' to create one.}"
: "${KEYSTORE_PASS:?KEYSTORE_PASS is required.}"
KEY_ALIAS="${KEY_ALIAS:-upload}"
KEY_PASS="${KEY_PASS:-$KEYSTORE_PASS}"

if [[ ! -f "$KEYSTORE_PATH" ]]; then
  echo "Error: keystore file not found at: $KEYSTORE_PATH"
  exit 1
fi

# ── Resolve script directory (always run from repo root) ─────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ── Detect Flutter ────────────────────────────────────────────────────────────
if command -v flutter &>/dev/null; then
  FLUTTER="flutter"
elif command -v fvm &>/dev/null; then
  FLUTTER="fvm flutter"
else
  echo "Error: flutter (or fvm) not found in PATH."
  echo "Install Flutter: https://docs.flutter.dev/get-started/install"
  exit 1
fi

echo "Using Flutter: $($FLUTTER --version --machine 2>/dev/null | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d[\"frameworkVersion"])' 2>/dev/null || $FLUTTER --version 2>&1 | head -1)"

# ── Version override (optional) ───────────────────────────────────────────────
EXTRA_FLAGS=""
if [[ -n "$VERSION_NAME" && -n "$VERSION_CODE" ]]; then
  EXTRA_FLAGS="--build-name=$VERSION_NAME --build-number=$VERSION_CODE"
  echo "Version: $VERSION_NAME+$VERSION_CODE"
fi

# ── Install dependencies ──────────────────────────────────────────────────────
echo ""
echo "▶ flutter pub get"
$FLUTTER pub get

# ── Generate freezed / json_serializable code ─────────────────────────────────
echo ""
echo "▶ build_runner (code generation)"
dart run build_runner build --delete-conflicting-outputs

# ── Build release APK ─────────────────────────────────────────────────────────
echo ""
echo "▶ flutter build apk --release"
export KEYSTORE_PATH KEYSTORE_PASS KEY_ALIAS KEY_PASS

$FLUTTER build apk --release \
  --dart-define=API_BASE_URL="$API_URL" \
  --dart-define=APP_METRICA_KEY="${APP_METRICA_KEY:-}" \
  --dart-define=IU_ALUMNI_WEB_SALT="${IU_ALUMNI_WEB_SALT:-}" \
  $EXTRA_FLAGS

# ── Copy output ───────────────────────────────────────────────────────────────
APK_SRC="build/app/outputs/flutter-apk/app-release.apk"

if [[ ! -f "$APK_SRC" ]]; then
  echo "Error: expected APK not found at $APK_SRC"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# Include version in filename if provided
if [[ -n "$VERSION_NAME" ]]; then
  APK_DEST="$OUTPUT_DIR/iu-alumni-${VERSION_NAME}.apk"
else
  APK_DEST="$OUTPUT_DIR/iu-alumni-release.apk"
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
