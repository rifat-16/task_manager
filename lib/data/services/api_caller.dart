import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await get(uri);
      _logResponse(response);
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        // Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          statusCode: statusCode,
          responseData: decodedData,
        );
      } else {
        // Failed
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          statusCode: statusCode,
          responseData: decodedData,
          errorMessage: decodedData['message'],
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        statusCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  static void _logRequest(String url) {
    _logger.i('Request URL: $url');
  }

  static void _logResponse(Response response) {
    _logger.i('Response Status Code: ${response.statusCode}');
    _logger.i('Response Body: ${response.body}');
  }

  static Future<ApiResponse> postRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);
      Response response = await post(uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
      );
      _logResponse(response);
      int statusCode = response.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        // Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: true,
          statusCode: statusCode,
          responseData: decodedData,
        );
      } else {
        // Failed
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          isSuccess: false,
          statusCode: statusCode,
          responseData: decodedData,
          errorMessage: decodedData['data'],
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        statusCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }
}

class ApiResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseData;
  final String? errorMessage;
  ApiResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.responseData,
    this.errorMessage = 'Something went wrong',
  });
}
