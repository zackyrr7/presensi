import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _key = 'isDarkmode';
  final _box = GetStorage();

  /// Reactive state agar UI bisa memantau perubahan
  final isDarkMode = false.obs;

  ThemeService() {
    // Saat class ini dibuat, load dari penyimpanan
    isDarkMode.value = _loadThemeFromStorage();
  }

  /// Ambil dari GetStorage
  bool _loadThemeFromStorage() {
    return _box.read(_key) ?? false;
  }

  /// Simpan ke GetStorage
  void _saveThemeToStorage(bool value) {
    _box.write(_key, value);
  }

  /// ThemeMode yang dipakai di GetMaterialApp
  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  /// Tombol toggle
  void switchTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToStorage(isDarkMode.value);
  }
}
