import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Themecontroll extends GetxController {
  final _box = GetStorage();
  final _key = 'isdarkmode';
  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;
  bool get isdarkmode => _loadTheme();
  bool _loadTheme() => _box.read(_key) ?? false;
  void saveTheme(bool isdarkmode) => _box.write(_key, isdarkmode);
  void toggltheme() {
    Future.delayed(const Duration(milliseconds: 50), () {
      Get.changeThemeMode(_loadTheme() ? ThemeMode.light : ThemeMode.dark);
      saveTheme(!_loadTheme());
      update();
    });
  }
}
