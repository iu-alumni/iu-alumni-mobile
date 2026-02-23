# IU Alumni — Mobile / Web MiniApp

Flutter application targeting web (MiniApp) and mobile (Android/iOS).

## Architecture

State management: Bloc/Cubit. Navigation: AutoRoute. DI: injectable.

**Layers:**
- `data/` — network (Dio), local storage, models (freezed). Use `fpdart` for failable results.
- `application/` — business logic, cross-layer models, runtime cache.
- `presentation/` — Blocs/Cubits + UI. Keep it dumb; move logic to `application/`.

## Branches

| Branch | Target |
|--------|--------|
| `main` / `develop` | Web (Flutter web — deployed as MiniApp) |
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
See [iu-alumni-infra](../iu-alumni-infra/README.md) for full deployment guide.
