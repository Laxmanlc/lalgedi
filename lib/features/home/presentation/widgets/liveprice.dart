import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // import helper
import 'package:lalgedi/features/home/presentation/bloc/home_controller.dart';

class LivePriceCard extends StatelessWidget {
  LivePriceCard({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.sw(0), right: context.sw(10)),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main container
            Container(
              constraints: BoxConstraints(maxWidth: context.sw(350)),
              padding: context.ep(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.sw(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: context.sw(8),
                    offset: Offset(0, context.sh(4)),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Live Price",
                        style: TextStyle(
                          fontSize: context.sp(18),
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.sw(5),
                          vertical: context.sh(5),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(context.sw(12)),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.newspaper,
                                size: context.sp(16), color: Colors.red),
                            SizedBox(width: context.sw(4)),
                            Text(
                              "International Gold News",
                              style: TextStyle(
                                fontSize: context.sp(12),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.sh(12)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // GOLD
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Gold Rate",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: context.sp(14),
                              ),
                            ),
                            Obx(() => Text(
                                  "Rs ${controller.goldPrice.value}",
                                  style: TextStyle(
                                    fontSize: context.sp(18),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                )),
                            Text(
                              "Per Tola",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: context.sp(12)),
                            ),
                            SizedBox(height: context.sh(8)),
                            Image.asset("assets/image/gold.png",
                                height: context.sh(40)),
                            SizedBox(height: context.sh(4)),
                            Obx(() => Text(
                                  "▲ ${controller.goldChange.value}",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: context.sp(14)),
                                )),
                          ],
                        ),
                      ),

                      Container(
                          width: context.sw(1),
                          height: context.sh(100),
                          color: Colors.grey.shade300),

                      // SILVER
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Silver Rate",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.sp(14)),
                            ),
                            Obx(() => Text(
                                  "Rs ${controller.silverPrice.value}",
                                  style: TextStyle(
                                    fontSize: context.sp(18),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                )),
                            Text(
                              "Per Tola",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: context.sp(12)),
                            ),
                            SizedBox(height: context.sh(8)),
                            Image.asset("assets/image/silver.png",
                                height: context.sh(40)),
                            SizedBox(height: context.sh(4)),
                            Obx(() => Text(
                                  "▼ ${controller.silverChange.value}",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: context.sp(14)),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow positioned to top right of container
            Positioned(
              top: context.sh(-10),
              right: context.sw(40),
              child: CustomPaint(
                size: Size(context.sw(20), context.sh(10)),
                painter: _ArrowPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color.fromARGB(255, 255, 255, 255);
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
