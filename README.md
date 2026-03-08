# IU Alumni — Mobile (WebView Shell)

Flutter Android/iOS app that opens the IU Alumni web application in a WebView.
The full-featured web app lives in [iu-alumni-bot](https://github.com/iu-alumni/iu-alumni-bot).

## Tech Stack

- **Flutter** (SDK ^3.32) · **Dart** (SDK ^3.8)
- **webview_flutter** — embeds the Nuxt web app

## Development

```bash
flutter pub get
flutter run --dart-define=MOBILE_URL=http://localhost:3000
```

The `MOBILE_URL` dart-define sets the URL loaded in the WebView.
Defaults to `https://mobile.alumap.escalopa.com` if not provided.

## Deployment

CI builds an Android APK on every push to `main`.
The web app is deployed separately from [iu-alumni-bot](https://github.com/iu-alumni/iu-alumni-bot).

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
