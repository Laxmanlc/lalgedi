import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/features/data/model/homepagemodel.dart';
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
        automaticallyImplyLeading: false, // removes default back button
        backgroundColor: const Color.fromRGBO(255, 245, 245, 1),
        elevation: 0,
        title: HomeTopRow(animation: homeController.animation),
      ),
      backgroundColor: AppColors.backgroundcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Rate Card reactive with GetX
                Obx(() => RateCard(
                      gold: RateItem(
                        label: 'Gold Rate',
                        labelColor: AppColors.primarycolor,
                        price: "Rs ${homeController.goldPrice.value}",
                        unit: 'Per Tola',
                        badgeLabel: '24k',
                        purity: '24k 99.99%',
                        image: Image.asset(
                          "assets/image/gold.png",
                          height: 50,
                          width: 50,
                        ),
                      ),
                      silver: RateItem(
                        label: 'Silver Rate',
                        labelColor: AppColors.silvercolor,
                        price: "Rs ${homeController.silverPrice.value}",
                        unit: 'Per Tola',
                        purity: '99.99%',
                        image: Image.asset(
                          "assets/image/silver.png",
                          height: 60,
                          width: 60,
                        ),
                      ),
                      lastUpdated: homeController.lastUpdated.value,
                      onShare: () {},
                      onTapBadge: () {},
                    )),

                const SizedBox(height: 20),

                // Jewelry Calculator Widget (if reactive needed, wrap with Obx)
                const JewelryCalculatorWidget(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
