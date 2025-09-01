import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart';
import 'package:lalgedi/features/home/presentation/bloc/home_controller.dart';
import 'package:lalgedi/features/home/presentation/page/gold_calculator.dart';
import 'package:lalgedi/features/home/presentation/widgets/homewidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(255, 245, 245, 1),
        elevation: 0,
        title: HomeTopRow(animation: homeController.animation),
      ),
      backgroundColor: AppColors.backgroundcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: context.ep(8),
            child: Column(
              children: [
                // ✅ RateCard reads live prices internally from LivePriceController
                RateCard(
                  onShare: () {},
                  onTapBadge: () {},
                ),

                SizedBox(height: context.sh(20)),

                // Jewelry Calculator
                JewelryCalculatorWidget(
                  currencyLabel: "NPR",
                  themeColor: AppColors.primarycolor,
                  title: "home.simple_jewelry_calculator".tr,
                ),

                SizedBox(height: context.sh(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
