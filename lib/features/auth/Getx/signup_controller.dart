import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // Text Editing Controllers
  final shopNameController = TextEditingController();
  final yourNameController = TextEditingController();
  final phonenumber = TextEditingController();
  final passwordController = TextEditingController();

  // Reactive variables
  var agreeToTerms = false.obs;
  var showPassword = false.obs;

  // Toggle password visibility
  void togglePassword() {
    showPassword.value = !showPassword.value;
  }

  // Toggle terms checkbox
  void toggleTerms(bool? value) {
    agreeToTerms.value = value ?? false;
  }

  @override
  void onClose() {
    shopNameController.dispose();
    yourNameController.dispose();
    phonenumber.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
