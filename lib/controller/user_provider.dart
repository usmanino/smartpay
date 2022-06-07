import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:smartplay/model/response_message_model.dart';
import 'package:smartplay/model/user_model.dart';
import 'package:smartplay/services/network_services.dart';

enum UserStatus { uninitialized, unauthorized, authenticating, authenticated }

class UserProvider extends ChangeNotifier {
  int num = 0;
  var isLoginObsecure = true;
  UserStatus status = UserStatus.uninitialized;
  UserModel _user = UserModel();
  SharedPreferences? _prefs;
  get user => _user;
  String? _token;

  get tok => _token;
  set setTok(String v) {
    _token = v;
  }

  get pass => isLoginObsecure;

  get use => _user;
  set setUser(UserModel value) {
    _user = value;
  }

  //otp
  String? tokenId;
  get getTokenId => tokenId;
  set setTokenId(String value) {
    tokenId = value;
  }

  UserProvider.initialize() {
    onInit();
    checkUser();
    status = UserStatus.unauthorized;
    notifyListeners();
  }

  Future<void> onInit() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> checkUser() async {
    _prefs = await SharedPreferences.getInstance();
    final hasToken = _prefs?.getString('token');
    print(hasToken);
    if (hasToken != null) {
      status = UserStatus.authenticated;
    } else {
      status = UserStatus.unauthorized;
    }
    notifyListeners();
  }

  issecure() {
    isLoginObsecure = !isLoginObsecure;
    notifyListeners();
  }

  Future<ResponseMessageModel> getToken({required String email}) async {
    try {
      final _responseMessageModel = await NetworkServices.getToken(
        email: email,
      );
      print(_responseMessageModel.data);
      if (_responseMessageModel.data != null) {
        return _responseMessageModel;
      }
      //UserStatus.unauthorized;
      return _responseMessageModel;
    } catch (e) {
      print(e);
      UserStatus.unauthorized;
      return ResponseMessageModel(
        success: false,
        message: "Oops an error occur",
      );
    }
  }

  Future<ResponseMessageModel> verifyToken(
      {required String token, required String email}) async {
    try {
      final _responseMessageModel = await NetworkServices.verifyToken(
        email: email,
        token: token,
      );
      if (_responseMessageModel.success!) {
        return _responseMessageModel;
      }
      UserStatus.unauthorized;
      return _responseMessageModel;
    } catch (e) {
      print(e);
      UserStatus.unauthorized;
      return ResponseMessageModel(
        success: false,
        message: "Oops an error occur",
      );
    }
  }

  Future register({
    required String full_name,
    required String email,
    required String country,
    required String password,
    required String device_name,
  }) async {
    try {
      final _responseMessageModel = await NetworkServices.register(
        full_name: full_name,
        email: email,
        country: country,
        password: password,
        device_name: device_name,
      );
      // print("------");
      // print(_responseMessageModel.success);
      // print("------");

      if (_responseMessageModel.success!) {
        setTok = _responseMessageModel.data!['token'];
        _user = UserModel.fromJson(_responseMessageModel.data!['user']);
        _prefs!
            .setString('user', jsonEncode(_responseMessageModel.data!['user']));
        _prefs!.setString(
            'token', jsonEncode(_responseMessageModel.data!['token']));
        status = UserStatus.authenticated;
        notifyListeners();
      }
      // await dashboard();
      //UserStatus.unauthorized;
      return _responseMessageModel;
    } catch (e) {
      print(e);
      //UserStatus.unauthorized;
      return ResponseMessageModel(
        success: false,
        message: "Oops an error occur",
      );
    }
  }

  Future<ResponseMessageModel> login({
    required String password,
    required String email,
    required String device_name,
  }) async {
    try {
      status = UserStatus.unauthorized;
      _prefs = await SharedPreferences.getInstance();
      notifyListeners();

      final _responseMessageModel = await NetworkServices.login(
        email: email,
        password: password,
        device_name: device_name,
      );

      // if (_responseMessageModel.data != null) {
      //   _user = UserModel.fromJson(_responseMessageModel.data!['user']);
      //   _prefs!
      //       .setString('user', jsonEncode(_responseMessageModel.data!['user']));
      //   _prefs!.setString(
      //       'token', jsonEncode(_responseMessageModel.data!['token']));
      //   status = UserStatus.Authenticated;
      //   notifyListeners();
      //   return _responseMessageModel;
      // }
      // status = UserStatus.Unauthorized;
      // notifyListeners();
      if (_responseMessageModel.success!) {
        setTok = _responseMessageModel.data!['token'];
        _user = UserModel.fromJson(_responseMessageModel.data!['user']);
        _prefs!
            .setString('user', jsonEncode(_responseMessageModel.data!['user']));
        _prefs!.setString(
            'token', jsonEncode(_responseMessageModel.data!['token']));
        status = UserStatus.authenticated;

        notifyListeners();
      }
      status = UserStatus.unauthorized;
      notifyListeners();
      return _responseMessageModel;
    } catch (e) {
      print("-----------");

      print(e);
      print("-----------");
      status = UserStatus.unauthorized;
      notifyListeners();
      return ResponseMessageModel(
        success: false,
        message: "Oops an error occur",
      );
    }
  }

  Future dashboard() async {
    try {
      final _responseMessageModel =
          await NetworkServices.dashboard(_user, _token!);
      print("------");
      print(_responseMessageModel.success);
      print("------");

      if (_responseMessageModel.success!) {
        _token = _responseMessageModel.data!['token'];

        notifyListeners();
      }
      UserStatus.unauthorized;
      return _responseMessageModel;
    } catch (e) {
      print(e);
      //UserStatus.unauthorized;
      return ResponseMessageModel(
        success: false,
        message: "Oops an error occur",
      );
    }
  }

  Future<void> logout() async {
    // _prefs = await SharedPreferences.getInstance();
    _prefs!.clear();
    status = UserStatus.unauthorized;
    notifyListeners();
  }
}
