import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/responsive.dart';
import 'package:lalgedi/features/home/presentation/bloc/liveprice_controller.dart';
import 'package:intl/intl.dart';

class LivePriceCard extends StatelessWidget {
  LivePriceCard({super.key});

  final LivePriceController controller = Get.put(LivePriceController());

  // Formatters
  final formatter = NumberFormat("#,##0.00"); // 2 decimals for Gold
  final formatter3 = NumberFormat("#,##0.000"); // 3 decimals for Silver

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
                  // Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "home.live_price".tr,
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
                              "home.international_gold_news".tr,
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

                  // Gold & Silver Row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // GOLD
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "home.gold_rate".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: context.sp(14),
                              ),
                            ),
                            Obx(() => Text(
                                  "Rs ${formatter.format(controller.goldPriceNpr.value)}",
                                  style: TextStyle(
                                    fontSize: context.sp(18),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                )),
                            Text(
                              "general.per_tola".tr,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: context.sp(12)),
                            ),
                            SizedBox(height: context.sh(8)),
                            Image.asset("assets/image/gold.png",
                                height: context.sh(40)),
                            SizedBox(height: context.sh(4)),
                            Obx(() {
                              final change = controller.goldChange.value;
                              final percent = controller.goldPercent.value
                                  .toStringAsFixed(2);
                              final isUp = change >= 0;
                              return Text(
                                "${isUp ? "▲" : "▼"} ${formatter.format(change)} ($percent%)",
                                style: TextStyle(
                                  color: isUp ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.sp(14),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),

                      // Divider
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
                              "home.silver_rate".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.sp(14)),
                            ),
                            Obx(() => Text(
                                  "Rs ${formatter3.format(controller.silverPriceNpr.value)}",
                                  style: TextStyle(
                                    fontSize: context.sp(18),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                )),
                            Text(
                              "general.per_tola".tr,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: context.sp(12)),
                            ),
                            SizedBox(height: context.sh(8)),
                            Image.asset("assets/image/silver.png",
                                height: context.sh(40)),
                            SizedBox(height: context.sh(4)),
                            Obx(() {
                              final change = controller.silverChange.value;
                              final percent = controller.silverPercent.value
                                  .toStringAsFixed(2);
                              final isUp = change >= 0;
                              return Text(
                                "${isUp ? "▲" : "▼"} ${formatter3.format(change)} ($percent%)",
                                style: TextStyle(
                                  color: isUp ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.sp(14),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.sh(10)),

                  // Last Updated
                  Obx(() => Text(
                        "Updated: ${controller.lastUpdated.value}",
                        style: TextStyle(
                          fontSize: context.sp(12),
                          color: Colors.grey,
                        ),
                      )),
                ],
              ),
            ),

            // Arrow
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
    final paint = Paint()..color = Colors.white;
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
