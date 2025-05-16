import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gopresent/services/login_service.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var username = '';
  var password = '';

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void togglePasswordVisibility() {
   
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  final LoginService _loginService = LoginService();

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;
    isLoading.value = true;

    var result = await _loginService.login(username, password);

    if (result['status'] == true) {
     Get.offAndToNamed('/navbar');
    } else {
      Get.snackbar(
        'Login Gagal',
        result['message'],
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }
}
