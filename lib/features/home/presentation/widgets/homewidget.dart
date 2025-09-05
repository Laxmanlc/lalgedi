import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart';
import 'package:lalgedi/features/home/presentation/bloc/nepali_price_controller.dart';
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
    final GoldPriceController controller =
        Get.isRegistered<GoldPriceController>()
            ? Get.find<GoldPriceController>()
            : Get.put(GoldPriceController(), permanent: true);

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
                            priceObs: controller.goldPriceNpr,
                            changeObs: controller.goldChange,
                            percentObs: controller.goldPercent,
                            numberFormat: _fmt2,
                            isGold: true,
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

class _RateColumn extends StatefulWidget {
  final String label;
  final String? unit;
  final String? imagePath;
  final RxDouble priceObs;
  final RxDouble changeObs;
  final RxDouble percentObs;
  final bool showShare;
  final VoidCallback? onShare;
  final NumberFormat numberFormat;
  final bool isGold;

  const _RateColumn({
    required this.label,
    this.unit,
    this.imagePath,
    required this.priceObs,
    required this.changeObs,
    required this.percentObs,
    this.showShare = false,
    this.onShare,
    required this.numberFormat,
    this.isGold = false,
  });

  @override
  State<_RateColumn> createState() => _RateColumnState();
}

class _RateColumnState extends State<_RateColumn> {
  final Map<String, double> goldPurityMap = {
    "24k 99.99%": 1.0,
    "22k 91.67%": 0.9167,
    "20k 83.33%": 0.8333,
    "15k 62.50%": 0.625,
  };

  late String selectedPurity;

  @override
  void initState() {
    super.initState();
    selectedPurity = "24k 99.99%";
  }

  @override
  Widget build(BuildContext context) {
    double multiplier = widget.isGold ? goldPurityMap[selectedPurity]! : 1.0;

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
        // Label + Purity Dropdown
        Row(
          children: [
            Text(widget.label, style: labelStyle),
            const Spacer(),
            if (widget.isGold)
              Container(
                height: 30,
                padding: EdgeInsets.symmetric(
                  horizontal: context.sw(8),
                  vertical: context.sh(2),
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(context.sw(12)),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: DropdownButton<String>(
                  value: selectedPurity,
                  items: goldPurityMap.keys.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value.split(" ").first,
                        style: TextStyle(
                          fontSize: context.sp(12),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedPurity = val!;
                    });
                  },
                  underline: Container(),
                  icon: Icon(Icons.arrow_drop_down,
                      size: context.sp(16), color: AppColors.primarycolor),
                ),
              ),
          ],
        ),
        SizedBox(height: context.sh(8)),

        // Price + change
        Obx(() {
          final priceVal = widget.priceObs.value * multiplier;
          final priceStr =
              (priceVal > 0) ? widget.numberFormat.format(priceVal) : '--';
          final chg = widget.changeObs.value * multiplier;
          final pct = widget.percentObs.value;
          final isUp = chg >= 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rs $priceStr",
                style: priceStyle,
              ),
              SizedBox(height: context.sh(4)),
              Text(
                "${isUp ? "▲" : "▼"} ${widget.numberFormat.format(chg)} (${pct.toStringAsFixed(2)}%)",
                style: TextStyle(
                  color: isUp ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: context.sp(13),
                ),
              ),
            ],
          );
        }),

        if (widget.unit != null)
          Padding(
            padding: EdgeInsets.only(top: context.sh(4)),
            child: Text(widget.unit!, style: unitStyle),
          ),

        // Image
        Padding(
          padding: EdgeInsets.only(top: context.sh(8)),
          child: widget.imagePath != null
              ? Image.asset(
                  widget.imagePath!,
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

        // Purity text + Share button
        Row(
          children: [
            Text(widget.isGold ? selectedPurity : '', style: purityStyle),
            const Spacer(),
            if (widget.showShare)
              InkWell(
                onTap: widget.onShare,
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
