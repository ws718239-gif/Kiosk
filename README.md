# Visitor Check-in Kiosk

Flutter application for Android tablets and web. The project includes a searchable host directory, visitor check-in with camera photo and consent, QR badge, today's visitor list, and admin settings for theme, brand colour, and English/Hindi/Gujarati.

## Requirements

- Flutter SDK compatible with the Dart constraint in `pubspec.yaml`
- Node.js 18 or later for the supplied mock API
- The provided `mock-api.zip` (Node.js 18+; no npm install is needed)

## Run locally

Start the extracted mock API in its directory with `node server.js`. It listens on port `4000` and enables CORS. It deliberately adds 300–1500 ms latency and returns simulated 500 errors about 5% of the time.

```bash
flutter pub get
flutter run -d emulator-5554 --dart-define=API_BASE_URL=http://10.0.2.2:4000
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:4000
```

For a physical Android tablet, set `API_BASE_URL` to the development computer's reachable LAN address, for example `http://192.168.1.25:4000`. The tablet and computer must share a network, and the mock server must listen on an interface reachable from the tablet. Debug/profile builds permit local HTTP for the mock; release builds keep cleartext traffic disabled by default.

## Build

Web release build (use an HTTPS API endpoint for a deployed build):

```bash
flutter build web --release --dart-define=API_BASE_URL=https://your-api-host
```

Android release APK (requires an HTTPS API endpoint for normal release builds):

```bash
flutter build apk --release --dart-define=API_BASE_URL=https://your-api-host
```

For a local assessment mock only, a release build can opt in to HTTP with `-PallowCleartextTraffic=true`, `--dart-define=ALLOW_INSECURE_API=true`, and a reachable `API_BASE_URL`. Do not use those options with real visitor data. The Android Gradle release variant currently uses the debug signing key, so it is suitable only for assessment/review and must be configured with a private release keystore before distribution.

## Generate model code

Edit the source files under `lib/**/domain/models/`, then regenerate Freezed and JSON files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

See [SUBMISSION.md](SUBMISSION.md), [DIAGNOSTICS.md](DIAGNOSTICS.md), and [ARCHITECTURE.md](ARCHITECTURE.md) for assessment notes and known limitations.
