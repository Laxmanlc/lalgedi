import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';
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
          text: const TextSpan(
            style: TextStyle(
              fontSize: 30,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
            children: [
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primarycolor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeTransition(
                      opacity: animation,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.notifications_none, size: 28),
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
  final EdgeInsetsGeometry padding;

  const RateCard({
    super.key,
    required this.gold,
    required this.silver,
    this.lastUpdated,
    this.onShare,
    this.onTapBadge,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(14.0),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(borderRadius),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              width: double.infinity,
              padding: padding,
              color: Colors.white,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's  Rate",
                        style: TextStyle(
                          color: AppColors.primarycolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Colors.green),
                          SizedBox(width: 4),
                          Text("Kathmandu"),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
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
                        const VerticalDivider(
                          width: 16,
                          thickness: 1,
                          color: Color.fromARGB(255, 145, 144, 144),
                        ),
                        const SizedBox(width: 5),
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
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              lastUpdated!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
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
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
    const priceStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    const unitStyle = TextStyle(fontSize: 12, color: Colors.black54);
    const purityStyle = TextStyle(fontSize: 12, color: Colors.black45);

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                    color: Colors.red.shade50,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.badgeLabel!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primarycolor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.arrow_drop_down,
                          size: 16, color: AppColors.primarycolor),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
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
            const SizedBox(width: 8),
          ],
        ),
        if (item.unit != null) ...[
          const SizedBox(height: 6),
          Text(item.unit!, style: unitStyle),
        ],
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: item.image ??
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                        child:
                            Icon(Icons.image, size: 28, color: Colors.black26)),
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
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.share,
                    color: Colors.red.shade400,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
