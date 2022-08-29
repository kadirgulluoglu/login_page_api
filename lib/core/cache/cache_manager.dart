// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheManager {
  static final _storage = FlutterSecureStorage();

  static Future setUsername(String userName) async {
    await _storage.write(key: CacheManagerKeys.username.name, value: userName);
  }

  static Future<String?> getUsername() async {
    String? userName = await _storage.read(key: CacheManagerKeys.username.name);
    return userName;
  }

  static Future setPassword(String password) async {
    await _storage.write(key: CacheManagerKeys.password.name, value: password);
  }

  static Future<String?> getPassword() async {
    String? password = await _storage.read(key: CacheManagerKeys.password.name);
    return password;
  }
}

enum CacheManagerKeys { username, password }
