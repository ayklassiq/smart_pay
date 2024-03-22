
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_pay/model/users_model.dart';
import 'package:smart_pay/services/api_controller.dart';
import 'package:smart_pay/services/auth_service.dart';


class UserProvider with ChangeNotifier {
  final AuthService _authService=   AuthService();
  UsersModel? _user;
  String? _phoneNumber;
  String? _userName;
  String? _id;
  String? _token;
  String? _email;
  String? _fullName;
  String? _password;
  String? _deviceName;
  String? _bearerToken;
  String? _secret;
  bool _isloading = false;
  Map<String, dynamic>? _fullData;
  UsersModel? _userModel;


  UserProvider() {
    loadData();
  }

  UsersModel? get user => _user;
  get fullName => _fullName;
  get email => _email;
  get phoneNumber => _phoneNumber;
  get userName => _userName;
  get id => _id;
  get token => _token;
  get password => _password;
  get fullData => _fullData;
  get deviceName => _deviceName;
  get usermodel => _userModel;
  get bearerToken => _bearerToken;
  get isloading => _isloading;
  get secret => _secret;




// signup with email
  Future<bool> signUpWithEmail(
      String email,
      context,
      ) async {
    final token = await _authService.signUpWithEmail(email, context);
    if (token != null) {
      _token = token;
      notifyListeners();
      return true;
    }
    return false;
  }

// verify email
  Future<bool> verifyEmail(
      String email,
      String token,
      context,
      ) async {
    final emailVerified = await _authService.verifyEmail(email, token, context);

    if (emailVerified == email) {
      notifyListeners();
      return true;
    }
    return false;
  }

  // register
  Future<bool> register (
      String fullName,
      String userName,
      // String email,
      String country,
      String password,
      // String deviceName,
      context
      ) async {
    final registeredUser = await _authService.register(fullName, userName, email, country, password, deviceName, context);
    _userModel = registeredUser;

    if (registeredUser.email == email) {
      notifyListeners();
      return true;
    }
    return false;
  }

  // login
  Future<bool> login(
      String email,
      String password,
      // String deviceName,
      context,
      ) async {
    final loggedInUser = await _authService.login(email, password, deviceName, context);
    _userModel = loggedInUser;
    if (loggedInUser.email == email) {
      notifyListeners();
      return true;
    }
    return false;
  }

  // logout
  Future<bool> logout(context) async {
    final loggedOut = await _authService.logout(context);
    if (loggedOut != null) {
      _token = null;
      notifyListeners();
      return true;
    }
    return false;
  }

  // get dashboard
  Future<bool> getDashboard(context) async {
    final secretMessage = await _authService.getDashboard(context);
    if (secretMessage != null) {
      _secret = secretMessage;
      notifyListeners();
      return true;
    }
    return false;
  }


  void loadData() {
    _user = UsersModel(fullName: _fullName, email: _email, id: _id, username: _userName);
  }

  void setUser(UsersModel user) {
    _user = user;
    notifyListeners();
  }


  Future<bool> setPhoneNumber(String value) async {
    _phoneNumber = value;
    notifyListeners();
    return true;
  }

  Future<bool> setSecret(String value) async {
    _secret = value;
    notifyListeners();
    return true;
  }

  Future<bool> setUserName(String value) async {
    _userName = value;
    notifyListeners();
    return true;
  }

  Future<bool> setId(String value) async {
    _id = value;
    notifyListeners();
    return true;
  }

  Future<bool> setToken(String value) async {
    _token = value;
    notifyListeners();
    return true;
  }

  Future<bool> setEmail(String value) async {
    _email = value;
    notifyListeners();
    return true;
  }

  Future<bool> setFullName(String value) async {
    _fullName = value;
    notifyListeners();
    return true;
  }

  Future<bool> setPassword(String value) async {
    _password = value;
    notifyListeners();
    return true;
  }
  Future<bool> setDeviceName(String value) async {
    _deviceName = value;
    notifyListeners();
    return true;
  }

  Future<bool> setBearerToken(String value) async {
    _bearerToken = value;
    notifyListeners();
    return true;
  }

  Future<bool> setFullData(Map<String, dynamic> value) async {
    _fullData = value;
    notifyListeners();
    return true;
  }
  Future<bool> setUserModel(UsersModel value) async {
    _userModel = value;
    notifyListeners();
    return true;
  }

  Future<bool> setIsLoading(bool value) async {
    _isloading = value;
    notifyListeners();
    return true;
  }


}
