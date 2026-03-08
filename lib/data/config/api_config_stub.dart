/// Stub implementation for non-web platforms (Android, iOS, desktop).
/// Reads the API base URL from the compile-time --dart-define value.
String getApiBaseUrl() => const String.fromEnvironment('API_BASE_URL');
