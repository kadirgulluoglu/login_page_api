import 'package:flutter/material.dart';

import '../../../core/cache/cache_manager.dart';
import '../../../core/init/service/network_manager.dart';
import '../model/user_model.dart';
import '../model/user_request_model.dart';

class LoginViewModel with ChangeNotifier {
  late final LoginService loginService;
  LoginViewModel() {
    loginService = LoginService();
  }
  UserModel? userModel;
  fetchUserLogin(String username, String password) async {
    try {
      final response = await loginService.requestData(
          UserRequestModel(username: username, password: password));
      userModel = response;
    } on Exception catch (e) {
      print(e);
    }
  }

  getUserFromCache(TextEditingController _emailController,
      TextEditingController _passwordController) async {
    final name = await CacheManager.getUsername() ?? '';
    final password = await CacheManager.getPassword() ?? '';

    _emailController.text = name;
    _passwordController.text = password;

    return _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty
        ? true
        : false;
  }
}
