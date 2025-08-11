import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Store selected option per step
  final Map<int, String> _selectedOptions = {};

  void nextPage() {
    if (_selectedOptions[_currentPage] != null && _currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onOptionSelected(int stepIndex, String option) {
    setState(() {
      _selectedOptions[stepIndex] = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/logo.png',
                        width: 50,
                        height: 50,
                      ),
                      const Text(
                        "लाल",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                      const Text(
                        "गेडी",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Flexible(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 8,
                                spreadRadius: 2,
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                child: PageView(
                                  controller: _pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  onPageChanged: (index) {
                                    setState(() => _currentPage = index);
                                  },
                                  children: [
                                    SelectableStepWidget(
                                      stepIndex: 0,
                                      stepTitle: "Choose your language",
                                      options: const ["English", "Nepali"],
                                      selectedOption: _selectedOptions[0],
                                      onOptionSelected: onOptionSelected,
                                    ),
                                    SelectableStepWidget(
                                      stepIndex: 1,
                                      stepTitle: "Choose Units System",
                                      options: const ["Tola", "Gram"],
                                      selectedOption: _selectedOptions[1],
                                      onOptionSelected: onOptionSelected,
                                    ),
                                    SelectableStepWidget(
                                      stepIndex: 2,
                                      stepTitle: "Select Calendar",
                                      options: const ["BS", "AD"],
                                      selectedOption: _selectedOptions[2],
                                      onOptionSelected: onOptionSelected,
                                    ),
                                    LocationStepWidget(
                                      selectedDistrict: _selectedOptions[3],
                                      onDistrictSelected: (value) =>
                                          onOptionSelected(3, value),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed:
                                        _currentPage == 0 ? null : prevPage,
                                    child: Text(
                                      "Go back",
                                      style: TextStyle(
                                        color: _currentPage == 0
                                            ? Colors.grey.shade400
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed:
                                        _selectedOptions[_currentPage] != null
                                            ? nextPage
                                            : null,
                                    child: Text(
                                      _currentPage == 3 ? "Finish" : "Next",
                                      style: TextStyle(
                                        color: _selectedOptions[_currentPage] !=
                                                null
                                            ? AppColors.primarycolor
                                            : Colors.red.shade200,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
        const SizedBox(height: 10),
        const Text("Finish your setup",
            style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          color: AppColors.primarycolor,
          backgroundColor: Colors.red.shade100,
          minHeight: 3,
        ),
        const SizedBox(height: 20),
        Text(
          stepTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primarycolor,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 150,
          children: options.map((option) {
            final isSelected = option == selectedOption;
            return OutlinedButton(
              onPressed: () => onOptionSelected(stepIndex, option),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: isSelected
                        ? AppColors.primarycolor
                        : Colors.grey.shade300,
                    width: isSelected ? 2 : 1),
                backgroundColor: isSelected ? Colors.red.shade50 : Colors.white,
                foregroundColor:
                    isSelected ? AppColors.primarycolor : Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(option),
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
        const SizedBox(height: 10),
        const Text("Finish your setup",
            style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: 1.0,
          color: AppColors.primarycolor,
          backgroundColor: Colors.red.shade100,
          minHeight: 3,
        ),
        const SizedBox(height: 20),
        const Text(
          "Shop Location",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primarycolor,
          ),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Select District",
          ),
          value: selectedDistrict,
          items: districts
              .map((district) =>
                  DropdownMenuItem(value: district, child: Text(district)))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onDistrictSelected(value);
            }
          },
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed: selectedDistrict != null
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Setup Finished!")),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedDistrict != null
                  ? AppColors.primarycolor
                  : Colors.red.shade200,
            ),
            child: Text(
              "Finish Setup",
              style: TextStyle(
                  color:
                      selectedDistrict != null ? Colors.white : Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
