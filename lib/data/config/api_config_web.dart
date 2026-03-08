import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// Web implementation: reads the API base URL injected at runtime by the
/// nginx entrypoint into window.apiBaseUrl (see web/index.html placeholder).
/// Falls back to the compile-time --dart-define value if not set.
String getApiBaseUrl() {
  try {
    final jsValue = globalContext['apiBaseUrl'];
    if (jsValue != null && jsValue.typeofEquals('string')) {
      final url = (jsValue as JSString).toDart;
      if (url.startsWith('http')) return url;
    }
  } catch (_) {}
  return const String.fromEnvironment('API_BASE_URL');
}
