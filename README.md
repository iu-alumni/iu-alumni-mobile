# IU Alumni — Mobile / Web MiniApp

Flutter application for the IU Alumni platform, targeting web (Telegram MiniApp) and mobile (Android/iOS).

## Tech Stack

- **Flutter** (SDK ^3.32) · **Dart** (SDK ^3.8)
- **Bloc/Cubit** (state management) · **AutoRoute** (navigation) · **Dio** (HTTP)
- **Freezed** (immutable models) · **fpdart** (typed error handling)
- **flutter_map** (interactive maps) · **flutter_secure_storage** (credential storage)
- **AppMetrica** (analytics)

## Architecture

**Layers:**
- `data/` — network (Dio), local storage (sqflite), models (freezed). Uses `fpdart` for failable results.
- `application/` — business logic, cross-layer models, runtime cache.
- `presentation/` — Blocs/Cubits + UI. Keep it dumb; move logic to `application/`.

## Branches

| Branch | Target |
|--------|--------|
| `main` / `develop` | Web (Flutter web — deployed as Telegram MiniApp) |
| `mobile-main` | Android / iOS |

Cherry-pick shared features between branches.

## Local Development

```bash
# Web
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8080

# Android
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080 \
            --dart-define=APP_METRICA_KEY=your_key
```

## Deployment

The web target deploys automatically on push to `develop` (testing) or `main` (production).  
`API_BASE_URL` is baked into the binary at build time from the `API_BASE_URL` GitHub environment secret.  
A separate Docker image is built per environment (testing tag: `sha-test`, production tag: `sha`).  
See [iu-alumni-infra](https://github.com/iu-alumni/iu-alumni-infra) for the full deployment guide.
