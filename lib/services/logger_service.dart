class LoggerService {
  static bool enabled = true;
  static void request(String method, Uri uri, Map<String, String> headers, String? body) {
    if (!enabled) return;
    final h = headers.map((k, v) => MapEntry(k, k.toLowerCase() == 'authorization' ? '***' : v));
    final b = body == null ? '' : body.length > 1000 ? body.substring(0, 1000) + '…' : body;
    final line = '[HTTP] --> $method ${uri.toString()}';
    final hs = '[HTTP] headers: $h';
    final bd = b.isEmpty ? null : '[HTTP] body: $b';
    print(line);
    print(hs);
    if (bd != null) print(bd);
  }
  static void response(String method, Uri uri, int statusCode, String body, Duration duration) {
    if (!enabled) return;
    final b = body.isEmpty ? '' : body.length > 2000 ? body.substring(0, 2000) + '…' : body;
    final line = '[HTTP] <-- $method ${uri.toString()} [$statusCode] ${duration.inMilliseconds}ms';
    final bd = b.isEmpty ? null : '[HTTP] body: $b';
    print(line);
    if (bd != null) print(bd);
  }
  static void error(String method, Uri uri, Object error) {
    if (!enabled) return;
    print('[HTTP] xx  $method ${uri.toString()} ERROR: $error');
  }
}