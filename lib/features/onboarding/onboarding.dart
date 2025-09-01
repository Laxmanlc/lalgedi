import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // import helper
import 'package:lalgedi/features/home/presentation/bloc/onboarding_controller.dart';
import 'package:lalgedi/features/navigationbar/navigationscreen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: context.sh(50)),
                  // Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/logo.png',
                        width: context.sw(50),
                        height: context.sh(50),
                      ),
                      Text(
                        "लाल",
                        style: TextStyle(
                          fontSize: context.sp(50),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                      Text(
                        "गेडी",
                        style: TextStyle(
                          fontSize: context.sp(50),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.sh(80)),

                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: context.sw(400)),
                      margin: EdgeInsets.symmetric(horizontal: context.sw(20)),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: context.ep(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: context.sw(8),
                                spreadRadius: context.sw(2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(context.sw(12)),
                          ),
                          child: Obx(() {
                            return Column(
                              children: [
                                SizedBox(
                                  height: context.sh(
                                      0.3 * MediaQuery.of(context).size.height),
                                  child: PageView(
                                    controller: pageController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    onPageChanged: (index) {
                                      controller.currentPage.value = index;
                                    },
                                    children: [
                                      SelectableStepWidget(
                                        stepIndex: 0,
                                        stepTitle: "Choose your language",
                                        options: const ["English", "Nepali"],
                                        selectedOption:
                                            controller.selectedOptions[0],
                                        onOptionSelected: controller.setOption,
                                      ),
                                      SelectableStepWidget(
                                        stepIndex: 1,
                                        stepTitle: "Choose Units System",
                                        options: const ["Tola", "Gram"],
                                        selectedOption:
                                            controller.selectedOptions[1],
                                        onOptionSelected: controller.setOption,
                                      ),
                                      SelectableStepWidget(
                                        stepIndex: 2,
                                        stepTitle: "Select Calendar",
                                        options: const ["BS", "AD"],
                                        selectedOption:
                                            controller.selectedOptions[2],
                                        onOptionSelected: controller.setOption,
                                      ),
                                      LocationStepWidget(
                                        selectedDistrict:
                                            controller.selectedOptions[3],
                                        onDistrictSelected: (value) =>
                                            controller.setOption(3, value),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: context.sh(10)),

                                // Buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed:
                                          controller.currentPage.value == 0
                                              ? null
                                              : () {
                                                  controller.prevPage();
                                                  pageController.previousPage(
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                      child: Text(
                                        "Go back",
                                        style: TextStyle(
                                          color:
                                              controller.currentPage.value == 0
                                                  ? Colors.grey.shade400
                                                  : Colors.black,
                                          fontSize: context.sp(14),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: controller.isStepCompleted(
                                              controller.currentPage.value)
                                          ? () {
                                              if (controller
                                                      .currentPage.value ==
                                                  3) {
                                                Get.to(() =>
                                                    NavigationBarScreen());
                                              } else {
                                                controller.nextPage();
                                                pageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                            }
                                          : null,
                                      child: Text(
                                        controller.currentPage.value == 3
                                            ? "Finish"
                                            : "Next",
                                        style: TextStyle(
                                          color: controller.isStepCompleted(
                                                  controller.currentPage.value)
                                              ? AppColors.primarycolor
                                              : AppColors.redBackgroundcolor,
                                          fontSize: context.sp(14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ✅ Reuse your existing Widgets (only responsiveness added)
class SelectableStepWidget extends StatelessWidget {
  final int stepIndex;
  final String stepTitle;
  final List<String> options;
  final String? selectedOption;
  final Function(int stepIndex, String option) onOptionSelected;

  const SelectableStepWidget({
    super.key,
    required this.stepIndex,
    required this.stepTitle,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (stepIndex + 1) / 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.sh(10)),
        Text("Finish your setup",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: context.sp(14),
            )),
        SizedBox(height: context.sh(8)),
        LinearProgressIndicator(
          value: progress,
          color: AppColors.primarycolor,
          backgroundColor: AppColors.redBackgroundcolor,
          minHeight: context.sh(3),
        ),
        SizedBox(height: context.sh(20)),
        Text(
          stepTitle,
          style: TextStyle(
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
            color: AppColors.primarycolor,
          ),
        ),
        SizedBox(height: context.sh(20)),
        Wrap(
          spacing: context.sw(20),
          runSpacing: context.sh(10),
          children: options.map((option) {
            final isSelected = option == selectedOption;
            return OutlinedButton(
              onPressed: () => onOptionSelected(stepIndex, option),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: isSelected
                        ? AppColors.primarycolor
                        : Colors.grey.shade300,
                    width: isSelected ? context.sw(2) : context.sw(1)),
                backgroundColor:
                    isSelected ? AppColors.redBackgroundcolor : Colors.white,
                foregroundColor:
                    isSelected ? AppColors.primarycolor : Colors.black,
                padding: EdgeInsets.symmetric(
                    horizontal: context.sw(20), vertical: context.sh(12)),
              ),
              child: Text(
                option,
                style: TextStyle(fontSize: context.sp(14)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class LocationStepWidget extends StatelessWidget {
  final String? selectedDistrict;
  final ValueChanged<String> onDistrictSelected;

  const LocationStepWidget({
    super.key,
    required this.selectedDistrict,
    required this.onDistrictSelected,
  });

  @override
  Widget build(BuildContext context) {
    const districts = ["District 1", "District 2", "District 3"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.sh(10)),
        Text("Finish your setup",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: context.sp(14),
            )),
        SizedBox(height: context.sh(8)),
        LinearProgressIndicator(
          value: 1.0,
          color: AppColors.primarycolor,
          backgroundColor: AppColors.redBackgroundcolor,
          minHeight: context.sh(3),
        ),
        SizedBox(height: context.sh(20)),
        Text(
          "Shop Location",
          style: TextStyle(
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
            color: AppColors.primarycolor,
          ),
        ),
        SizedBox(height: context.sh(20)),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "Select District",
            contentPadding: EdgeInsets.symmetric(
                horizontal: context.sw(12), vertical: context.sh(8)),
          ),
          value: selectedDistrict,
          items: districts
              .map((district) => DropdownMenuItem(
                  value: district,
                  child: Text(district,
                      style: TextStyle(fontSize: context.sp(14)))))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onDistrictSelected(value);
            }
          },
        ),
      ],
    );
  }
}
