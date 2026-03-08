import 'dart:js_interop';

/// Web implementation: reads the API base URL injected at runtime by the
/// nginx entrypoint into window.apiBaseUrl (see web/index.html placeholder).
/// Falls back to the compile-time --dart-define value if not set.
@JS('apiBaseUrl')
external JSString? get _jsApiBaseUrl;

String getApiBaseUrl() {
  try {
    final url = _jsApiBaseUrl?.toDart;
    if (url != null && url.startsWith('http')) return url;
  } catch (_) {}
  return const String.fromEnvironment('API_BASE_URL');
}
