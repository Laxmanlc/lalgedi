import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // import helper
import 'package:lalgedi/features/data/model/homepagemodel.dart';
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
              fontSize: context.sp(30), // responsive font
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
  final RateItem gold;
  final RateItem silver;
  final String? lastUpdated;
  final VoidCallback? onShare;
  final VoidCallback? onTapBadge;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const RateCard({
    super.key,
    required this.gold,
    required this.silver,
    this.lastUpdated,
    this.onShare,
    this.onTapBadge,
    this.borderRadius = 12.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Rate",
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
                            "Kathmandu",
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
                        Expanded(
                          child: _RateColumn(
                            item: gold,
                            showBadgeCallback: onTapBadge,
                          ),
                        ),
                        VerticalDivider(
                          width: context.sw(16),
                          thickness: context.sw(1),
                          color: const Color.fromARGB(255, 145, 144, 144),
                        ),
                        SizedBox(width: context.sw(5)),
                        Expanded(
                          child: _RateColumn(
                            item: silver,
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
        if (lastUpdated != null) ...[
          SizedBox(height: context.sh(8)),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              lastUpdated!,
              style: TextStyle(fontSize: context.sp(12), color: Colors.grey),
            ),
          )
        ],
      ],
    );
  }
}

class _RateColumn extends StatelessWidget {
  final RateItem item;
  final bool showShare;
  final VoidCallback? onShare;
  final VoidCallback? showBadgeCallback;

  const _RateColumn({
    required this.item,
    this.showShare = false,
    this.onShare,
    this.showBadgeCallback,
  });

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      color: item.labelColor ?? Colors.black87,
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(item.label, style: labelStyle),
            const Spacer(),
            if (item.badgeLabel != null)
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
                        item.badgeLabel!,
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                item.price,
                style: priceStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: context.sw(8)),
          ],
        ),
        if (item.unit != null) ...[
          SizedBox(height: context.sh(6)),
          Text(item.unit!, style: unitStyle),
        ],
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: context.sh(8)),
              child: item.image ??
                  Container(
                    width: context.sw(80),
                    height: context.sh(50),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(context.sw(6)),
                    ),
                    child: Center(
                        child: Icon(Icons.image,
                            size: context.sp(28), color: Colors.black26)),
                  ),
            ),
          ),
        ),
        Row(
          children: [
            Text(item.purity ?? '', style: purityStyle),
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
