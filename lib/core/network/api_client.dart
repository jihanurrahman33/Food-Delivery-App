import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';
import '../services/storage_service.dart';

class ApiClient extends GetxService {
  final http.Client _client = http.Client();
  final String baseUrl;

  ApiClient({this.baseUrl = AppConstants.apiBaseUrl});

  StorageService get _storageService => Get.find<StorageService>();

  Map<String, String> _buildHeaders() {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final token = _storageService.userToken;
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Uri _buildUri(String path, [Map<String, dynamic>? queryParams]) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final fullUrl = '$baseUrl$normalizedPath';
    final uri = Uri.parse(fullUrl);
    if (queryParams != null && queryParams.isNotEmpty) {
      final stringParams = queryParams.map(
        (key, value) => MapEntry(key, value?.toString() ?? ''),
      )..removeWhere((key, value) => value.isEmpty);
      return uri.replace(queryParameters: stringParams);
    }
    return uri;
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final uri = _buildUri(path, queryParams);
      if (kDebugMode) {
        debugPrint('[API GET] $uri');
      }
      final response = await _client.get(uri, headers: _buildHeaders());
      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException('Network connection failed: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is AuthException || e is NetworkException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }

  Future<dynamic> post(String path, {dynamic body}) async {
    try {
      final uri = _buildUri(path);
      if (kDebugMode) {
        debugPrint('[API POST] $uri');
      }
      final response = await _client.post(
        uri,
        headers: _buildHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException('Network connection failed: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is AuthException || e is NetworkException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }

  Future<dynamic> put(String path, {dynamic body}) async {
    try {
      final uri = _buildUri(path);
      if (kDebugMode) {
        debugPrint('[API PUT] $uri');
      }
      final response = await _client.put(
        uri,
        headers: _buildHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException('Network connection failed: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is AuthException || e is NetworkException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final uri = _buildUri(path);
      if (kDebugMode) {
        debugPrint('[API DELETE] $uri');
      }
      final response = await _client.delete(uri, headers: _buildHeaders());
      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException('Network connection failed: ${e.message}');
    } catch (e) {
      if (e is ServerException || e is AuthException || e is NetworkException) {
        rethrow;
      }
      throw ServerException(e.toString());
    }
  }

  dynamic _handleResponse(http.Response response) {
    dynamic jsonBody;
    try {
      jsonBody = jsonDecode(response.body);
    } catch (_) {
      jsonBody = null;
    }

    final message = (jsonBody is Map<String, dynamic>)
        ? (jsonBody['message'] as String? ?? 'Request failed')
        : 'HTTP ${response.statusCode}';

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (jsonBody is Map<String, dynamic> && jsonBody.containsKey('data')) {
        return jsonBody['data'];
      }
      return jsonBody;
    }

    if (response.statusCode == 401) {
      throw AuthException(message);
    }

    if (response.statusCode == 403) {
      throw AuthException('Access forbidden: $message');
    }

    throw ServerException(message);
  }
}
