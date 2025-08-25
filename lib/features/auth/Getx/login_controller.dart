import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var agreeToTerms = false.obs;
  var showPassword = false.obs;

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleTerms(bool? value) {
    agreeToTerms.value = value ?? false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
