import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/features/account/presentation/pages/accountpage.dart';
import 'package:lalgedi/features/catalog/presentation/catalog.dart';
import 'package:lalgedi/features/goldcalculator/page/goldloan_calculator.dart';
import 'package:lalgedi/features/home/presentation/page/homepage.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      body: _screens[_selectedIndex],
      floatingActionButton: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: AppColors.primarycolor, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.qr_code_scanner, // you can replace with Image.asset()
          size: 35,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home
              _buildNavItem("assets/image/home.png", "Home", 0),
              _buildNavItem("assets/image/catalog.png", "Catalog", 1),
              const SizedBox(width: 50), // Space for center button
              _buildNavItem("assets/image/lona.png", "Gold Loan", 2),
              _buildNavItem("assets/image/account.png", "Account", 3),
            ],
          ),
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
            color: isSelected ? Colors.red : Colors.black, // Change color here
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.red : Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
