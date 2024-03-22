import 'dart:convert';
import 'package:provider/provider.dart';

import '../model/users_model.dart';
import '../providers/user_provider.dart';
import 'api_controller.dart';


class AuthService {
  final ApiService _apiService = ApiService();


  Future<dynamic> register(String fullName,
      String username,
      String email,
      String country,
      String password,
      String deviceName,
      context,) async {
    Map<String, dynamic> body = {};

    body = {
      "full_name": fullName,
      "username": username,
      "email": email,
      "country": country,
      "password": password,
      "device_name": deviceName
    };
    String url = "auth/register";
    print('na the body be thuis ooo ${body}');
    var response = await _apiService.postReq(url, body, context);
    print('this is the response we are tryna print out ${response}');
    await Provider.of<UserProvider>(context, listen: false).setBearerToken(
        response['data']['token']);
    var responseJson = response['data']['user'];
    return UsersModel.fromJson(responseJson);
  }


  // login
  Future<dynamic> login(String email,
      String password,
      String deviceName,
      context,) async {
    Map<String, dynamic> body = {};
    body = {
      "email": email,
      "password": password,
      "device_name": deviceName,
    };

    String url = "auth/login";
    var response = await _apiService.postReq(url, body, context);
    var responseJson = response['data']['user'];
    await Provider.of<UserProvider>(context, listen: false).setBearerToken(
        response['data']['token']);
    return UsersModel.fromJson(responseJson);
  }

  // logout
  Future<dynamic> logout(context) async {
    String url = "auth/logout";
    var response = await _apiService.postReq(url, {}, context);
    print(
        '>>>>>>>>> response: this is rhe response we are tryna print out ${response}');
    return response;
  }

  // get dashboard
  Future<dynamic> getDashboard(context) async {
    String url = "dashboard";
    var response = await _apiService.getReq(url, context);
    var responseJson = response['data']['secret'];

    print(
        '>>>>>>>>> response: this is rhe response we are tryna print out ${response}');
    print('this is the responseJson we are tryna print out ${responseJson}');
    await Provider.of<UserProvider>(context, listen: false).setSecret(
        responseJson);
    return responseJson;
  }

  // email sign up
  Future<dynamic> signUpWithEmail(String email,
      context,) async {
    Map<String, dynamic> body = {};
    body = {
      "email": email,
    };
    String url = "auth/email";
    var response = await _apiService.postReq(url, body, context);
    var token = response['data']['token'];
    return token;
  }

  // verify email
  Future<dynamic> verifyEmail(String email,
      String token,
      context,) async {
    Map<String, dynamic> body = {};
    body = {
      "email": email,
      "token": token,
    };
    String url = "auth/email/verify";
    var response = await _apiService.postReq(url, body, context);
    var emailVerified = response['data']['email'];
    return emailVerified;
  }

  // phone number sign up
  Future<dynamic> signUpWithPhoneNumber(String phoneNumber,
      context,) async {
    Map<String, dynamic> body = {};
    body = {
      "phone_number": phoneNumber,
    };
    String url = "auth/register";
    var response = await _apiService.postReq(url, body, context);
    var responseJson = response.data['data']['user'];
    return responseJson.map<UsersModel>((json) => UsersModel.fromJson(json))
        .toList();
  }
}