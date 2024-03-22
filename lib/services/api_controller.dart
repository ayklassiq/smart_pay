import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/alert_dialog.dart' as Alert;
import '../providers/user_provider.dart';
import 'api_exception.dart';

class ApiService {
  // final String _baseUrl = Environment().config!.apiHost;
  final String _baseUrl =
      "https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1/";
  var prefs;
  final String _refreshToken = '';
  final Dio dio = Dio();
  Alert.AlertDialog alertDialog = Alert.AlertDialog();

  void checkException(DioException e, BuildContext context) {
    ApiException exception = ApiException();
    List<String> errorMessage = exception.getExceptionMessage(e);
    alertDialog.showAlert(
      context: context,
      title: errorMessage[0],
      message: errorMessage[1],
    );
  }

  Future getReq(url, context) async {
    // access token from userprovider
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    final token = authProvider.bearerToken;

    var responseJson;
    Response response;
    try {
      response = await dio.get(
        _baseUrl + url,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      responseJson = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseJson;
      }
      if (response.statusCode != 200) {
        if (response.data["status"] == false) {
          if (response.data["token"] == "TokenExpiredError") {
            // await refreshToken(context);
            return getReq(url, context);
          } else {
            return responseJson;
          }
        } else {
          return responseJson;
        }
      } else {
        return responseJson;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
      } else {
        print(e.message);
      }
      return null;
    }
  }

  Future postReq(url, dynamic body, [context]) async {
    print(_baseUrl + url);
    var responseJson;
    Response response;
    try {
      response = await dio.post(
        _baseUrl + url,
        data: body,
      );

      responseJson = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response from POST request: ${response.data}');
        return responseJson;
      }
      if (response.statusCode != 200) {
        if (response.data["status"] == false) {
          if (responseJson["data"]["token"] == "TokenExpiredError") {
            // await refreshToken(context);
            return postReq(url, body, [context]);
          } else {
            print(
                'printing ERRORRRRRR -->>> response of login from post request ${responseJson}');
            return responseJson;
          }
        } else {
          return responseJson;
        }
      } else {
        print('printing response of login from post request ${responseJson}');
        throw DioException(
            requestOptions: RequestOptions(path: _baseUrl + url),
            response: responseJson,
            type: DioExceptionType.connectionError);
      }
    } on DioException catch (error) {
      checkException(error, context);
    } catch (error) {
      // LoadingOverlay.of(context).hide();
      alertDialog.showAlert(
        context: context,
        title: "Error",
        message: error.toString(),
      );
    }
  }

  Future putReq(url, dynamic body, [context]) async {
    var responseJson;
    Response response;
    try {
      response = await dio
          .put(
        _baseUrl + url,
        data: body,
      )
          .catchError((e) {
        log(e.toString());
      });

      responseJson = response.data;
      if (response.statusCode != 200) {
        if (response.data["success"] == false) {
          if (response.data["content"] == "TokenExpiredError") {
            // await refreshToken(context);
            return putReq(url, body, [context]);
          } else {
            return responseJson;
          }
        } else {
          return responseJson;
        }
      } else {
        return responseJson;
      }
    } on DioException catch (err) {
      return err;
    }
  }

  Future deleteReq(url, [context]) async {
    var responseJson;
    Response response;
    try {
      response = await dio.delete(
        _baseUrl + url,
      );
      responseJson = response.data;
      if (response.statusCode != 200) {
        if (response.data["success"] == false) {
          if (response.data["content"] == "TokenExpiredError") {
            // await refreshToken(context);
            return deleteReq(url, [context]);
          } else {
            return responseJson;
          }
        } else {
          return responseJson;
        }
      } else {
        return responseJson;
      }
    } on DioException catch (err) {
      return err;
    }
  }

  Future refreshToken(context) async {
    var responseJson;
    Response response;
    try {
      response = await dio.post(
        "$_baseUrl/auth/refresh-token",
        data: {"refreshToken": _refreshToken},
      );
      responseJson = response.data;
      if (response.statusCode != 200) {
        if (response.data["success"] == false) {
          if (response.data["content"] == "TokenExpiredError") {
            // await refreshToken(context);
            return refreshToken(context);
          } else {
            return responseJson;
          }
        } else {
          return responseJson;
        }
      } else {
        return responseJson;
      }
    } on DioException catch (err) {
      return err;
    }
  }

  Future checkUsername(context, String username) {
    return getReq("users/username/${username}", context);
  }

  Future userLogin(context, String email, String password, device_name) {
    return postReq(
        "accounts/login/", {"email": email, "password": password}, context);
  }
}
