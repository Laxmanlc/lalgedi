import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // import helper
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
    final double navHeight = context.sh(70); // responsive nav bar height
    final double qrSize = context.sw(70); // responsive QR button
    final double iconSize = context.sw(25); // nav icons
    final double textSize = context.sp(12); // nav text

    return Scaffold(
      body: Obx(() => _screens[navController.selectedIndex.value]),
      bottomNavigationBar: SizedBox(
        height: navHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: context.sw(8),
              child: SizedBox(
                height: navHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(context, "assets/image/home.png", "Home", 0,
                        iconSize, textSize),
                    _buildNavItem(context, "assets/image/catalog.png",
                        "Catalog", 1, iconSize, textSize),
                    SizedBox(width: qrSize), // space for QR button
                    _buildNavItem(context, "assets/image/lona.png", "Gold Loan",
                        2, iconSize, textSize),
                    _buildNavItem(context, "assets/image/account.png",
                        "Account", 3, iconSize, textSize),
                  ],
                ),
              ),
            ),
            // QR Button
            Positioned(
              top: -qrSize / 2,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // handle QR tap
                  child: Container(
                    height: qrSize,
                    width: qrSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.primarycolor,
                        width: context.sw(2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: context.sw(8),
                          offset: Offset(0, context.sh(4)),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: context.sp(35),
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

  Widget _buildNavItem(BuildContext context, String assetPath, String label,
      int index, double iconSize, double textSize) {
    return Obx(() {
      bool isSelected = navController.selectedIndex.value == index;
      return GestureDetector(
        onTap: () => navController.changeIndex(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: iconSize,
              width: iconSize,
              color: isSelected ? AppColors.primarycolor : Colors.black,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primarycolor : Colors.black,
                fontSize: textSize,
              ),
            ),
          ],
        ),
      );
    });
  }
}
