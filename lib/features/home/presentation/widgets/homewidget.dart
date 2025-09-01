import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart';
import 'package:lalgedi/features/home/presentation/bloc/liveprice_controller.dart';
import 'package:lalgedi/features/home/presentation/widgets/livebuttonontap.dart';

class HomeTopRow extends StatelessWidget {
  final Animation<double> animation;

  const HomeTopRow({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    final GlobalKey liveBtnKey = GlobalKey();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: context.sp(30),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
            children: const [
              TextSpan(
                text: 'लाल',
                style: TextStyle(color: AppColors.primarycolor),
              ),
              TextSpan(
                text: 'गेडी',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              key: liveBtnKey,
              onTap: () => showLivePricePopup(context, liveBtnKey),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.sw(8),
                  vertical: context.sh(4),
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarycolor,
                  borderRadius: BorderRadius.circular(context.sw(4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeTransition(
                      opacity: animation,
                      child: Container(
                        width: context.sw(8),
                        height: context.sh(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(width: context.sw(4)),
                    Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: context.sp(12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: context.sw(12)),
            Icon(Icons.notifications_none, size: context.sp(28)),
          ],
        ),
      ],
    );
  }
}

class RateCard extends StatelessWidget {
  final VoidCallback? onShare;
  final VoidCallback? onTapBadge;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final String locationLabel;

  RateCard({
    super.key,
    this.onShare,
    this.onTapBadge,
    this.borderRadius = 12.0,
    this.padding,
    this.locationLabel = "Kathmandu",
  });

  final NumberFormat _fmt2 = NumberFormat("#,##0.00"); // gold
  final NumberFormat _fmt3 = NumberFormat("#,##0.000"); // silver

  @override
  Widget build(BuildContext context) {
    // Use the same LivePriceController instance registered in HomeScreen.
    final LivePriceController controller =
        Get.isRegistered<LivePriceController>()
            ? Get.find<LivePriceController>()
            : Get.put(LivePriceController(), permanent: true);

    final cardPadding = padding ?? EdgeInsets.all(context.sw(14));

    return Column(
      children: [
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(context.sw(borderRadius)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.sw(borderRadius)),
            child: Container(
              width: double.infinity,
              padding: cardPadding,
              color: Colors.white,
              child: Column(
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "general.today_rate".tr,
                        style: TextStyle(
                          color: AppColors.primarycolor,
                          fontWeight: FontWeight.bold,
                          fontSize: context.sp(18),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: Colors.green, size: context.sp(18)),
                          SizedBox(width: context.sw(4)),
                          Text(
                            locationLabel,
                            style: TextStyle(fontSize: context.sp(14)),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: context.sh(20)),

                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // GOLD
                        Expanded(
                          child: _RateColumn(
                            label: "home.gold_rate".tr,
                            unit: "general.per_tola".tr,
                            imagePath: "assets/image/gold.png",
                            badgeLabel: "24k",
                            purity: "24k 99.99%",
                            priceObs: controller.goldPriceNpr,
                            changeObs: controller.goldChange,
                            percentObs: controller.goldPercent,
                            numberFormat: _fmt2,
                            showBadgeCallback: onTapBadge,
                          ),
                        ),
                        VerticalDivider(
                          width: context.sw(16),
                          thickness: context.sw(1),
                          color: const Color.fromARGB(255, 145, 144, 144),
                        ),
                        SizedBox(width: context.sw(5)),

                        // SILVER
                        Expanded(
                          child: _RateColumn(
                            label: "home.silver_rate".tr,
                            unit: "general.per_tola".tr,
                            imagePath: "assets/image/silver.png",
                            purity: "99.99%",
                            priceObs: controller.silverPriceNpr,
                            changeObs: controller.silverChange,
                            percentObs: controller.silverPercent,
                            numberFormat: _fmt3,
                            showShare: true,
                            onShare: onShare,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Updated time
        SizedBox(height: context.sh(8)),
        Align(
          alignment: Alignment.centerRight,
          child: Obx(() => Text(
                controller.lastUpdated.value.isNotEmpty
                    ? "Updated: ${controller.lastUpdated.value}"
                    : "Updated: --",
                style: TextStyle(fontSize: context.sp(12), color: Colors.grey),
              )),
        ),
      ],
    );
  }
}

class _RateColumn extends StatelessWidget {
  final String label;
  final String? unit;
  final String? imagePath;
  final String? badgeLabel;
  final String? purity;
  final RxDouble priceObs;
  final RxDouble changeObs;
  final RxDouble percentObs;
  final bool showShare;
  final VoidCallback? onShare;
  final VoidCallback? showBadgeCallback;
  final NumberFormat numberFormat;

  const _RateColumn({
    required this.label,
    this.unit,
    this.imagePath,
    this.badgeLabel,
    this.purity,
    required this.priceObs,
    required this.changeObs,
    required this.percentObs,
    this.showShare = false,
    this.onShare,
    this.showBadgeCallback,
    required this.numberFormat,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontSize: context.sp(14),
      fontWeight: FontWeight.w600,
    );
    final priceStyle = TextStyle(
      fontSize: context.sp(22),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    final unitStyle =
        TextStyle(fontSize: context.sp(12), color: Colors.black54);
    final purityStyle =
        TextStyle(fontSize: context.sp(12), color: Colors.black45);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with badge
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label, style: labelStyle),
            const Spacer(),
            if (badgeLabel != null)
              GestureDetector(
                onTap: showBadgeCallback,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.sw(8),
                    vertical: context.sh(4),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.sw(12)),
                    border: Border.all(color: Colors.red.shade200),
                    color: Colors.red.shade50,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        badgeLabel!,
                        style: TextStyle(
                          fontSize: context.sp(12),
                          color: AppColors.primarycolor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: context.sw(2)),
                      Icon(Icons.arrow_drop_down,
                          size: context.sp(16), color: AppColors.primarycolor),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: context.sh(8)),

        // Price + change %
        Obx(() {
          final priceVal = priceObs.value;
          final priceStr =
              (priceVal > 0) ? numberFormat.format(priceVal) : '--';
          final chg = changeObs.value;
          final pct = percentObs.value;
          final isUp = chg >= 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rs $priceStr",
                style: priceStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: context.sh(4)),
              Text(
                "${isUp ? "▲" : "▼"} ${numberFormat.format(chg)} (${pct.toStringAsFixed(2)}%)",
                style: TextStyle(
                  color: isUp ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: context.sp(13),
                ),
              ),
            ],
          );
        }),

        if (unit != null) ...[
          SizedBox(height: context.sh(6)),
          Text(unit!, style: unitStyle),
        ],

        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: context.sh(8)),
              child: imagePath != null
                  ? Image.asset(
                      imagePath!,
                      height: context.sh(50),
                      fit: BoxFit.contain,
                    )
                  : Container(
                      width: context.sw(80),
                      height: context.sh(50),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(context.sw(6)),
                      ),
                      child: Center(
                        child: Icon(Icons.image,
                            size: context.sp(28), color: Colors.black26),
                      ),
                    ),
            ),
          ),
        ),

        Row(
          children: [
            Text(purity ?? '', style: purityStyle),
            const Spacer(),
            if (showShare)
              InkWell(
                onTap: onShare,
                borderRadius: BorderRadius.circular(context.sw(8)),
                child: Padding(
                  padding: EdgeInsets.all(context.sw(6)),
                  child: Icon(
                    Icons.share,
                    color: Colors.red.shade400,
                    size: context.sp(20),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
