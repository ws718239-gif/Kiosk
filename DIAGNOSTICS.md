# Diagnostics

The assessment overview mentions six written diagnostic questions but does not include their exact wording. These six short answers document the main diagnostic decisions visible in this implementation; they should be mapped to the supplied question sheet before final submission if it contains different prompts.

## 1. The app reports `Connection refused` for `/hosts`. What should be checked?

`Connection refused` usually means no server is listening at that host/port. Start the supplied API with `node server.js`; its default port is `4000`. Use `http://localhost:4000` on web, `http://10.0.2.2:4000` on the Android emulator, or the development computer's LAN IP on a physical tablet. Set other addresses with `--dart-define=API_BASE_URL=...`. The server intentionally simulates 300–1500 ms latency and a 5% error rate, so occasional 500 responses are expected and should lead to a retryable error state.

## 2. API calls work on Android but fail in the browser. Why?

The supplied mock API already enables CORS for web. Verify the web build's `API_BASE_URL` and confirm the browser is reaching this server rather than another service. A browser's `localhost` points to the computer running the browser, not an Android emulator. A different API server must allow the web origin and JSON request headers.

## 3. Camera permission was denied and the prompt no longer appears. What is the recovery path?

The camera controller distinguishes denied from permanently denied/restricted permission. The UI offers the OS app settings page when permission is blocked, then checks permission again when the app resumes. On web, camera access requires a secure context (HTTPS, with localhost normally treated as secure) and browser permission.

## 4. What is the difference between an empty host list and a failed request?

An empty successful response renders `No Data Found`. A failed request renders a localized error and retry action. This prevents network failures from being mistaken for a valid empty result.

## 5. The badge has no usable QR code after check-in. What should be inspected?

The QR payload uses the API response's `badgeCode`, falling back to its `id`. The supplied `POST /visitors` response includes both, so verify the actual response and check that neither value is empty. A response without either field cannot produce a usable badge.

## 6. A model's generated JSON code is stale or no longer compiles. What should be done?

Edit the Freezed source model, not the generated `.freezed.dart` or `.g.dart` output, then run `dart run build_runner build --delete-conflicting-outputs`. Review the generated diff and run analyzer/tests before submitting.
