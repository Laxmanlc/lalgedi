import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Gold & Silver Prices
  var goldPrice = "1,95,000".obs;
  var silverPrice = "19,000".obs;
  var goldChange = "+500".obs;
  var silverChange = "-200".obs;
  var lastUpdated = "1 hr ago".obs;

  // Animation for LIVE badge
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    animation =
        Tween<double>(begin: 1.0, end: 0.4).animate(animationController);
  }

  void updatePrices({
    required String gold,
    required String silver,
    required String goldDiff,
    required String silverDiff,
  }) {
    goldPrice.value = gold;
    silverPrice.value = silver;
    goldChange.value = goldDiff;
    silverChange.value = silverDiff;
    lastUpdated.value = "just now";
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
