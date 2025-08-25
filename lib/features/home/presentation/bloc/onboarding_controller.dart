import 'package:get/get.dart';

class OnboardingController extends GetxController {
  // Track current page
  var currentPage = 0.obs;

  // Store selected options
  var selectedOptions = <int, String>{}.obs;

  // Page count (4 steps here)
  final int totalSteps = 4;

  // Methods
  void setOption(int stepIndex, String option) {
    selectedOptions[stepIndex] = option;
  }

  bool isStepCompleted(int stepIndex) {
    return selectedOptions[stepIndex] != null;
  }

  void nextPage() {
    if (isStepCompleted(currentPage.value) &&
        currentPage.value < totalSteps - 1) {
      currentPage.value++;
    }
  }

  void prevPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }
}
