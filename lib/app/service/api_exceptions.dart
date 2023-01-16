import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  String message = "";
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response!.statusCode!.toInt(), dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['error'] ?? error["message"] ?? 'Bad request';
      case 404:
        return error['error'] ?? error["message"] ?? "Api Url Incorrect";
      case 500:
        return error['error'] ?? error["message"] ?? "Internal Server Error";
      default:
        return error['error'] ??
            error["message"] ??
            'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
