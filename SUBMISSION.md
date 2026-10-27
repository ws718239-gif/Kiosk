# Assessment Submission

**Applicant:** [Add your name]
**Project:** Visitor Check-in Kiosk
**Repository:** https://github.com/ws718239-gif/Kiosk

## Implemented

- One Flutter application codebase with Android and web targets.
- Host directory with API-backed search and client-side incremental display.
- Visitor form with name/email/Indian mobile validation, host details, camera photo, and required consent.
- QR visitor badge after successful API submission.
- Today's visitors list with status filters, refresh, and cursor-based loading.
- Admin controls for brand colour, light/dark theme, and English/Hindi/Gujarati. Theme and language preferences use SharedPreferences.
- Empty, loading, and error states for the API-driven screens.

## Assessment files

- [DIAGNOSTICS.md](DIAGNOSTICS.md): six implementation diagnostics and responses.
- [ARCHITECTURE.md](ARCHITECTURE.md): architecture, decisions, trade-offs, and scope limits.

## Build commands

Start the supplied mock API from its extracted directory with `node server.js` (Node.js 18+; no npm install). The API listens on port `4000`, enables CORS, and deliberately simulates latency and occasional server failures. The archive's `server.js` and README were reviewed against the app's routes and data models.

Android emulator debug:

```bash
flutter run -d emulator-5554 --dart-define=API_BASE_URL=http://10.0.2.2:4000
```

Web debug:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:4000
```

Web release build command:

```bash
flutter build web --release --dart-define=API_BASE_URL=https://your-api-host
```

Android release APK command:

```bash
flutter build apk --release --dart-define=API_BASE_URL=https://your-api-host
```

For an assessment-only release APK using the local HTTP mock, pass a reachable LAN URL and `--dart-define=ALLOW_INSECURE_API=true`. The Android release build also needs `-PallowCleartextTraffic=true`. Do not use HTTP with real visitor information.

Example for a physical tablet on the same Wi-Fi (replace the address with the development computer's current LAN IP):

```bash
flutter build apk --release -PallowCleartextTraffic=true --dart-define=ALLOW_INSECURE_API=true --dart-define=API_BASE_URL=http://192.168.1.25:4000
```

## Release artifact and publication status

The requested public repository is [github.com/ws718239-gif/Kiosk](https://github.com/ws718239-gif/Kiosk), with the submission intended for its `main` branch. The web release build completed. An Android arm64 release APK was built and signature-verified at `build/app/outputs/flutter-apk/app-release.apk` (21.6 MB). It uses the debug signing certificate and assessment-only HTTP opt-in, with its API URL set to this development computer's LAN address, `http://192.168.31.105:4000`; the tablet must be on the same network and the mock API must be running. This APK is not production-signed and its LAN API address is specific to this setup. Use a private release keystore and HTTPS API for production. Do not commit signing credentials.

The assessment brief gives the total time limit as five hours. An exact elapsed time was not recorded, so this submission does not claim a verified completion time.
