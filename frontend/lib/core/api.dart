import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// 192.168.227.163
// 2409:40c2:105e:d000:66f7:d955:71b4:fef1
// http://192.168.1.200:5000/api

const String BASE_URL = "http://192.168.227.163:5000/api";
const Map<String, dynamic> DEFAULT_HEADERS = {
  "Content-Type": "application/json"
};

class Api {

  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers = DEFAULT_HEADERS;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true, 
      responseBody: true,
      responseHeader: true
    ));
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({
    required this.success,
    this.data,
    this.message
  });

  factory ApiResponse.fromResponse(Response response) {
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
      success: data["success"],
      data: data["data"],
      message: data["message"] ?? "Unexpected error"
    );
  }
}