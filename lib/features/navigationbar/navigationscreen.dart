// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/features/account/presentation/pages/accountpage.dart';
import 'package:lalgedi/features/catalog/presentation/catalog.dart';
import 'package:lalgedi/features/goldcalculator/page/goldloan_calculator.dart';
import 'package:lalgedi/features/home/presentation/page/homepage.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CatalogScreen(),
    const GoldLoanCalculatorPage(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // keyboard pushes only body
      body: _screens[_selectedIndex],

      bottomNavigationBar: SizedBox(
        height: 70, // extra height for half-circle effect
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Bottom Nav Bar
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
                    const SizedBox(width: 70), // gap for QR button
                    _buildNavItem("assets/image/lona.png", "Gold Loan", 2),
                    _buildNavItem("assets/image/account.png", "Account", 3),
                  ],
                ),
              ),
            ),

            // 👇 Positioned QR Button (half inside/outside)
            Positioned(
              top: -25, // moves it up so it's half inside the bar
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {},
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
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
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
  }
}
