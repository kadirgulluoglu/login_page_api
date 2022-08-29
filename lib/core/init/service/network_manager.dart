import 'dart:io';

import 'package:dio/dio.dart';

import '../../../screen/login/model/user_model.dart';
import '../../../screen/login/model/user_request_model.dart';

class LoginService {
  final Dio _networkManager;
  LoginService()
      : _networkManager =
            Dio(BaseOptions(baseUrl: 'https://dummyjson.com/auth/'));

  requestData(UserRequestModel model) async {
    final response =
        await _networkManager.post(_LoginServicesPaths.login.name, data: model);
    if (response.statusCode == HttpStatus.ok) {
      return UserModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}

enum _LoginServicesPaths { login }
