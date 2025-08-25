import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/features/account/presentation/pages/accountpage.dart';
import 'package:lalgedi/features/catalog/presentation/catalog.dart';
import 'package:lalgedi/features/goldcalculator/page/goldloan_calculator.dart';
import 'package:lalgedi/features/home/presentation/bloc/navigation_controller.dart';
import 'package:lalgedi/features/home/presentation/page/homepage.dart';

class NavigationBarScreen extends StatelessWidget {
  NavigationBarScreen({super.key});

  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> _screens = [
    const HomeScreen(),
    const CatalogScreen(),
    const GoldLoanCalculatorPage(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _screens[navController.selectedIndex.value]),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              child: SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem("assets/image/home.png", "Home", 0),
                    _buildNavItem("assets/image/catalog.png", "Catalog", 1),
                    const SizedBox(width: 70),
                    _buildNavItem("assets/image/lona.png", "Gold Loan", 2),
                    _buildNavItem("assets/image/account.png", "Account", 3),
                  ],
                ),
              ),
            ),
            // QR Button
            Positioned(
              top: -25,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // handle QR tap
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.primarycolor,
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String assetPath, String label, int index) {
    return Obx(() {
      bool isSelected = navController.selectedIndex.value == index;
      return GestureDetector(
        onTap: () => navController.changeIndex(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: 25,
              width: 25,
              color: isSelected ? AppColors.primarycolor : Colors.black,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primarycolor : Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    });
  }
}
