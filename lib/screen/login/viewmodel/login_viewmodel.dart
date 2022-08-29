import 'package:flutter/material.dart';
import 'package:hardwareders/core/enum/state_enum.dart';

import '../../../core/cache/cache_manager.dart';
import '../../../core/init/service/network_manager.dart';
import '../model/user_model.dart';
import '../model/user_request_model.dart';

class LoginViewModel with ChangeNotifier {
  late final LoginService loginService;
  bool isObscure = true;
  bool isLoading = false;
  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  StateStatus _stateStatus = StateStatus.busy;
  StateStatus get stateStatus => _stateStatus;

  set stateStatus(StateStatus value) {
    _stateStatus = value;
    notifyListeners();
  }

  changeObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  LoginViewModel() {
    loginService = LoginService();
    getUserFromCache();
  }
  UserModel? userModel;

  fetchUserLogin(String username, String password) async {
    try {
      final response = await loginService.requestData(
          UserRequestModel(username: username, password: password));
      userModel = response;
      if (userModel != null) {
        if (rememberMe) {
          await CacheManager.setUsername(username);
          await CacheManager.setPassword(password);
        }
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getUserFromCache() async {
    final String? userName = await CacheManager.getUsername();
    final String? password = await CacheManager.getPassword();
    if (userName != null && password != null) {
      bool hasData = await fetchUserLogin(userName, password);

      if (hasData) {
        stateStatus = StateStatus.idle;
      } else {
        stateStatus = StateStatus.error;
      }
    } else {
      stateStatus = StateStatus.error;
    }
  }
}
