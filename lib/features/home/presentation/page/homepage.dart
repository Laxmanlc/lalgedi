import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/features/data/model/homepagemodel.dart';
import 'package:lalgedi/features/home/presentation/page/gold_calculator.dart';
import 'package:lalgedi/features/home/presentation/widgets/homewidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 0.4).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                HomeTopRow(animation: _animation),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // The universal rate card
                      RateCard(
                        gold: RateItem(
                          label: 'Gold Rate',
                          labelColor: AppColors.primarycolor,
                          price: 'Rs 1,95,000',
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
                          price: 'Rs 19,000',
                          unit: 'Per Tola',
                          purity: '99.99%',
                          image: Image.asset(
                            "assets/image/silver.png",
                            height: 60,
                            width: 60,
                          ),
                        ),
                        lastUpdated: 'last update 1hrs ago',
                        onShare: () {
                          // handle share
                          debugPrint('share tapped');
                        },
                        onTapBadge: () {
                          debugPrint('badge tapped');
                        },
                      ),
                    ],
                  ),
                ),
                const JewelryCalculatorWidget(),
                const SizedBox(height: 20), // Extra bottom space
              ],
            ),
          ),
        ),
      ),
    );
  }
}
