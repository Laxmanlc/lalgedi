import 'package:get/get.dart';

class OnboardingController extends GetxController {
  // Store selected options for 4 steps
  var selectedOptions = <int, String>{}.obs;

  final int totalSteps = 4;

  void setOption(int stepIndex, String option) {
    selectedOptions[stepIndex] = option;
  }

  bool isStepCompleted(int stepIndex) {
    return selectedOptions[stepIndex] != null &&
        selectedOptions[stepIndex]!.isNotEmpty;
  }

  bool isAllStepsCompleted() {
    return selectedOptions.length == totalSteps &&
        selectedOptions.values.every((value) => value.isNotEmpty);
  }
}
