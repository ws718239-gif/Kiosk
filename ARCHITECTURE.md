# Architecture and Design Decisions

## Scope

The application is a Flutter kiosk client for Android tablets and web. It covers the visitor journey from host selection through check-in and badge display, plus an administrative settings screen and a same-day visitor list. A separate Node mock API is expected to provide data; no backend is implemented in this repository.

## Structure and request flow

Code is grouped by feature under `lib/features/`. Each API-backed feature has a repository for HTTP and JSON handling, a Riverpod controller/provider for state, and a presentation screen. Shared concerns live under `lib/core/` (routing, localization, theme, networking, and responsive constraints).

The host screen watches a `FutureProvider` that requests `/hosts` with an optional `q` search term. The screen displays the returned records in a lazy `ListView`; the current page-size behavior is client-side, so the repository still fetches the matching host collection in one request. Selecting a host passes its model through `go_router` to the check-in route.

The check-in screen validates visitor details, requires consent, and asks the camera feature to capture a photo. The camera provider owns and disposes the `CameraController`; captured images are resized and JPEG-compressed before being encoded as a data URL for the API. The check-in repository posts a JSON visitor object to `/visitors`. On success, the route receives the returned visitor and displays a QR payload based on `badgeCode` or `id`.

Today's visitors are loaded from `/visitors`, with status and cursor query parameters. The notifier owns refresh, filtering, cancellation, and pagination state. Settings are stored in `SharedPreferences`; the app applies theme and locale at the root so a setting change updates the full UI.

## State and models

Riverpod is used for dependency injection and feature state. Providers scope API clients and repositories, while auto-dispose is used for temporary screen state. Request cancellation and mounted/generation checks prevent stale responses from updating disposed or superseded screens.

Host and visitor data use Freezed with JSON serialization. The source model files define the contract; generated `.freezed.dart` and `.g.dart` files provide immutable model implementations, value equality, `copyWith`, and JSON conversion. Generated files are committed to make builds reproducible without running code generation on every checkout.

## Network and platform configuration

Dio centralizes the API base URL, JSON headers, and connection/response timeouts. `API_BASE_URL` can override the defaults. Defaults target the supplied mock server on port `4000`: web uses `localhost`; Android uses the emulator's `10.0.2.2` host mapping. A physical tablet must be built/run with the development computer's reachable LAN address. The supplied API enables CORS. Its deliberate latency and 5% simulated failure rate exercise the app's loading/error/retry states.

Normal release mode rejects non-HTTPS API URLs. `ALLOW_INSECURE_API=true` is a deliberate build-time escape hatch for a local assessment mock and must not be used with real visitor information. The supplied mock contract was checked: hosts are returned as `{items,total}`, check-in returns the created visitor with `id` and `badgeCode`, and today's visitors use `items`, `nextCursor`, and optional `status`, `limit`, and `cursor` query parameters.

## UI and failure behavior

Screens use Material widgets, a global text scale, SafeArea, bounded form layouts, and lazy lists. API screens distinguish loading, empty, and error states and provide retry/refresh paths. Image decoding and camera failures have fallbacks. The app has top-level Flutter and platform error hooks; detailed logs are limited to debug mode. These hooks improve reporting but are not a substitute for feature-level recovery or crash reporting in a deployed product.

Manual translation lookup supports English source strings plus Hindi and Gujarati values, with English fallback for missing keys. Visitor/host names supplied by the server remain user data and are not translated. Shared preferences persist the selected theme mode, brand colour, and language.

## Trade-offs and out of scope

This is a kiosk assessment client rather than a production visitor management system. Authentication, authorization, durable offline submission, duplicate check-in handling, audit retention, and a production API are not implemented. Host pagination is currently in-memory after a collection fetch, which is adequate for the supplied 500-host dataset but should move to server pagination for a larger directory. Base64 photos make the mock API integration easy but increase JSON payload size; production should upload media separately or use a bounded binary upload flow. The today list currently displays a fallback avatar because the list response only provides `hasPhoto`; per-visitor photo fetching is not implemented.

The project currently has no configured public Git remote. Android's release build type still uses the debug signing key, so it is not suitable for public production distribution. The brief describes six diagnostic questions but does not include their exact wording; `DIAGNOSTICS.md` records six project-specific diagnostic responses that should be mapped to the supplied question sheet. No completion-time estimate is claimed because the five-hour work window was not measured.
