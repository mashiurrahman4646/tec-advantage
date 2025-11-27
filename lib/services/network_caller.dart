import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../config_service.dart';
import '../token_service/token_service.dart';
import 'logger_service.dart';
import 'package:get/get.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse(
      {required this.statusCode,
      this.responseData,
      required this.isSuccess,
      this.errorMessage = 'error'});
}

class NetworkCaller {
  final Duration timeout;

  NetworkCaller({this.timeout = const Duration(seconds: 20)});

  Future<NetworkResponse> get(String endpoint,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    return _request('GET', endpoint, params: params, headers: headers);
  }

  Future<NetworkResponse> post(String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    return _request('POST', endpoint, body: body, headers: headers);
  }

  Future<NetworkResponse> put(String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    return _request('PUT', endpoint, body: body, headers: headers);
  }

  Future<NetworkResponse> patch(String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    return _request('PATCH', endpoint, body: body, headers: headers);
  }

  Future<NetworkResponse> delete(String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    return _request('DELETE', endpoint, body: body, headers: headers);
  }

  Future<Uint8List?> getBinary(String endpoint,
      {Map<String, dynamic>? params, Map<String, String>? headers}) async {
    try {
      final uri = _buildUri(endpoint, params);
      final mergedHeaders = await _buildHeaders(headers);
      LoggerService.request('GET (Binary)', uri, mergedHeaders, null);

      final response =
          await http.get(uri, headers: mergedHeaders).timeout(timeout);

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        LoggerService.error(
            'GET (Binary)', uri, 'Status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      LoggerService.error('GET (Binary)', Uri.parse(''), e);
      return null;
    }
  }

  Future<NetworkResponse> _request(String method, String endpoint,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    try {
      final uri = _buildUri(endpoint, params);
      final mergedHeaders = await _buildHeaders(headers);
      final encodedBody = body != null ? jsonEncode(body) : null;
      LoggerService.request(method, uri, mergedHeaders, encodedBody);
      http.Response response;
      if (method == 'GET') {
        final started = DateTime.now();
        response = await http.get(uri, headers: mergedHeaders).timeout(timeout);
        LoggerService.response(method, uri, response.statusCode, response.body,
            DateTime.now().difference(started));
      } else if (method == 'POST') {
        final started = DateTime.now();
        response = await http
            .post(uri, headers: mergedHeaders, body: encodedBody)
            .timeout(timeout);
        LoggerService.response(method, uri, response.statusCode, response.body,
            DateTime.now().difference(started));
      } else if (method == 'PUT') {
        final started = DateTime.now();
        response = await http
            .put(uri, headers: mergedHeaders, body: encodedBody)
            .timeout(timeout);
        LoggerService.response(method, uri, response.statusCode, response.body,
            DateTime.now().difference(started));
      } else if (method == 'PATCH') {
        final started = DateTime.now();
        response = await http
            .patch(uri, headers: mergedHeaders, body: encodedBody)
            .timeout(timeout);
        LoggerService.response(method, uri, response.statusCode, response.body,
            DateTime.now().difference(started));
      } else if (method == 'DELETE') {
        final started = DateTime.now();
        response = await http
            .delete(uri, headers: mergedHeaders, body: encodedBody)
            .timeout(timeout);
        LoggerService.response(method, uri, response.statusCode, response.body,
            DateTime.now().difference(started));
      } else {
        return NetworkResponse(
            statusCode: -1, isSuccess: false, errorMessage: 'unsupported');
      }
      final decoded = _decode(response.body);
      final sc = response.statusCode;
      final success = sc == 200 || sc == 201 || sc == 204;
      if (sc == 401) {
        await TokenService.clearToken();
        if (Get.currentRoute != '/login') {
          Get.offAllNamed('/login');
        }
      }
      if (success) {
        return NetworkResponse(
            statusCode: sc, isSuccess: true, responseData: decoded);
      }
      final msg = _extractMessage(decoded) ?? 'error';
      return NetworkResponse(
          statusCode: sc,
          isSuccess: false,
          responseData: decoded,
          errorMessage: msg);
    } on TimeoutException catch (_) {
      try {
        final uri = _buildUri(endpoint, params);
        LoggerService.error(method, uri, 'timeout');
      } catch (_) {}
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: 'timeout');
    } catch (e) {
      try {
        final uri = _buildUri(endpoint, params);
        LoggerService.error(method, uri, e);
      } catch (_) {}
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? params) {
    final isAbsolute =
        endpoint.startsWith('http://') || endpoint.startsWith('https://');
    final base = isAbsolute ? '' : ApiConfig.baseUrl;
    final full = isAbsolute ? endpoint : '$base$endpoint';
    if (params == null || params.isEmpty) {
      return Uri.parse(full);
    }
    final qp = params.map((k, v) => MapEntry(k, v?.toString() ?? ''));
    return Uri.parse(full).replace(queryParameters: qp);
  }

  Future<Map<String, String>> _buildHeaders(
      Map<String, String>? headers) async {
    final defaultHeaders = {'Content-Type': 'application/json'};
    final auth = await TokenService.authHeaders();
    final merged = <String, String>{};
    merged.addAll(defaultHeaders);
    merged.addAll(auth);
    if (headers != null) merged.addAll(headers);
    return merged;
  }

  Map<String, dynamic>? _decode(String body) {
    if (body.isEmpty) return {};
    try {
      final d = jsonDecode(body);
      if (d is Map<String, dynamic>) return d;
      return {'data': d};
    } catch (_) {
      return {};
    }
  }

  String? _extractMessage(Map<String, dynamic>? decoded) {
    if (decoded == null) return null;
    final m = decoded['message'] ?? decoded['msg'] ?? decoded['error'];
    return m is String ? m : null;
  }
}
