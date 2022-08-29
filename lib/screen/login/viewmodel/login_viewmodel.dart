import 'package:flutter/material.dart';
import 'package:hardwareders/core/enum/state_enum.dart';

import '../../../core/cache/cache_manager.dart';
import '../../../core/init/service/network_manager.dart';
import '../model/user_model.dart';
import '../model/user_request_model.dart';

class LoginViewModel with ChangeNotifier {
  late final LoginService loginService;
  StateStatus _stateStatus = StateStatus.busy;
  StateStatus get stateStatus => _stateStatus;

  set stateStatus(StateStatus value) {
    _stateStatus = value;
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
      return userModel != null ? true : false;
    } on Exception catch (e) {
      print(e);
    }
  }

  getUserFromCache() async {
    final String? userName = await CacheManager.getUsername();
    final String? password = await CacheManager.getPassword();
    print(userName);
    print(password);
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
