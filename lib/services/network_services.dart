import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:smartplay/controller/user_provider.dart';
import 'package:smartplay/core/constants.dart';
import 'package:smartplay/model/response_message_model.dart';
import 'package:smartplay/model/user_model.dart';

class NetworkServices {
  static Future<ResponseMessageModel> getToken({
    required String email,
  }) async {
    try {
      final data = {
        'email': email,
      };
      final response = await http.post(
        Uri.parse(Constants.GET_TOKEN),
        headers: {'Accept': 'application/json'},
        body: data,
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // ignore: no_leading_underscores_for_local_identifiers
        ResponseMessageModel _responseMessageModel =
            ResponseMessageModel.fromJson(responseData)..success = true;
        return _responseMessageModel;
      } else {
        final responseData = jsonDecode(response.body);
        // ignore: no_leading_underscores_for_local_identifiers
        ResponseMessageModel _responseMessageModel =
            ResponseMessageModel.fromJson(responseData)..success = false;
        return _responseMessageModel;
      }
    } catch (error) {
      // ignore: no_leading_underscores_for_local_identifiers
      ResponseMessageModel _responseMessageModel = ResponseMessageModel(
        success: false,
        message: "An error occur",
      );
      return _responseMessageModel;
    }
  }

  static Future<ResponseMessageModel> verifyToken({
    required String email,
    required String token,
  }) async {
    try {
      final data = {
        'email': email,
        'token': token,
      };
      print(data.toString());
      final response = await http.post(
        Uri.parse(Constants.VERIFY_TOKEN),
        headers: {'Accept': 'application/json'},
        body: data,
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        ResponseMessageModel _responseMessageModel =
            ResponseMessageModel.fromJson(responseData)..success = true;
        return _responseMessageModel;
      } else {
        final responseData = jsonDecode(response.body);
        ResponseMessageModel _responseMessageModel =
            ResponseMessageModel.fromJson(responseData)..success = false;
        return _responseMessageModel;
      }
    } catch (error) {
      ResponseMessageModel _responseMessageModel = ResponseMessageModel(
        success: false,
        message: "An error occur",
      );
      return _responseMessageModel;
    }
  }

  static Future<ResponseMessageModel> register({
    required String full_name,
    required String email,
    required String country,
    required String password,
    required String device_name,
  }) async {
    try {
      final data = {
        'full_name': full_name,
        'email': email,
        'country': country,
        'password': password,
        'device_name': device_name,
      };
      print(data.toString());
      final response = await http.post(
        Uri.parse(Constants.REGISTER),
        headers: {'Accept': 'application/json'},
        body: data,
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        ResponseMessageModel _responseMessageModel =
            ResponseMessageModel.fromJson(responseData)..success = true;
        return _responseMessageModel;
      } else {
        final responseData = jsonDecode(response.body);
        ResponseMessageModel _responseMessageModel =
            ResponseMessageModel.fromJson(responseData)..success = false;
        return _responseMessageModel;
      }
    } catch (error) {
      ResponseMessageModel _responseMessageModel = ResponseMessageModel(
        success: false,
        message: "An error occur",
      );
      return _responseMessageModel;
    }
  }

  static Future<ResponseMessageModel> login({
    required String email,
    required String password,
    required String device_name,
  }) async {
    try {
      log('enter');
      final data = {
        'email': email,
        'password': password,
        'device_name': device_name,
      };
      log('enter');
      final response = await http.post(
        Uri.parse(Constants.LOGIN),
        headers: {'Accept': 'application/json'},
        body: data,
      );
      final responseData = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        log('bemmmmi');
        print(responseData);
        ResponseMessageModel _responseMessageModel =
            ResponseMessageModel.fromJson(responseData)..success = true;
        return _responseMessageModel;
      } else {
        ResponseMessageModel _responseMessageModel =
            ResponseMessageModel.fromJson(responseData)..success = false;
        return _responseMessageModel;
      }
    } catch (error) {
      print('Error here then');
      print(error);
      ResponseMessageModel _responseMessageModel = ResponseMessageModel(
        success: false,
        message: "An error occur",
      );
      print("catch");

      return _responseMessageModel;
    }
  }

  static Future<ResponseMessageModel> dashboard(
      UserModel userModel, String token) async {
    try {
      final response = await http.get(
        Uri.parse(Constants.DASHBOARD),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        ResponseMessageModel _responseMessageModel =
            ResponseMessageModel.fromJson(responseData)..success = true;
        return _responseMessageModel;
      } else {
        final responseData = jsonDecode(response.body);
        ResponseMessageModel _responseMessageModel =
            ResponseMessageModel.fromJson(responseData)..success = false;
        return _responseMessageModel;
      }
    } catch (error) {
      ResponseMessageModel _responseMessageModel = ResponseMessageModel(
        success: false,
        message: "An error occur",
      );
      return _responseMessageModel;
    }
  }
}
