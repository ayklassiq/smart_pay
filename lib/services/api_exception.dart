import 'package:dio/dio.dart';

class ApiException  {
 List<String> getExceptionMessage (DioException exception){
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
      return ["Connection Timeout", "Please check your internet connection and try again"];
    case DioExceptionType.sendTimeout:
      return ["Send Timeout", "Please check your internet connection and try again"];
    case DioExceptionType.receiveTimeout:
      return ["Receive Timeout", "Check API url, Network connectivity or parameter are invalid"];
    case DioExceptionType.badResponse:
      return ["Bad Response Error", "Check API url, parameter are invalid"];
    case DioExceptionType.cancel:
      return ["Request Cancelled", "Check API url, parameter are invalid"];
    case DioExceptionType.connectionError:
      return ["connection Error", "Please check your internet connection and try again!"];
    default:
      return ["Network Error", "Check Network connectivity!"];
  }
 }
}

// Compare this snippet from lib/services/api_exception.dart:
// class ApiException 