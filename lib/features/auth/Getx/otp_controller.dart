import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/features/onboarding/onboarding.dart';

class OtpController extends GetxController {
  // OTP input controllers
  final controllers = List.generate(4, (index) => TextEditingController());
  final focusNodes = List.generate(4, (index) => FocusNode());

  // Timer state
  var secondsRemaining = 15.obs;
  var enableResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    secondsRemaining.value = 15;
    enableResend.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
        timer.cancel();
      }
    });
  }

  void onResend() {
    startTimer();
  }

  void onContinue() {
    // Collect OTP
    String otp = controllers.map((c) => c.text).join();
    print("Entered OTP: $otp");

    // Later: Call API to verify OTP
    Get.to(() => const OnboardingScreen());
  }

  void handleOtpInput(String value, int index) {
    if (value.length > 1) {
      final pasted = value.split('');
      for (int i = 0; i < pasted.length && i < controllers.length; i++) {
        controllers[i].text = pasted[i];
      }
      FocusManager.instance.primaryFocus?.unfocus();
      return;
    }

    if (value.isNotEmpty && index < focusNodes.length - 1) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }
}
