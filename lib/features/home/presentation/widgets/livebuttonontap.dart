import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lalgedi/features/home/presentation/widgets/liveprice.dart';

OverlayEntry? _overlayEntry;

void showLivePricePopup(BuildContext context, GlobalKey targetKey) {
  final renderBox = targetKey.currentContext!.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero);
  final size = renderBox.size;

  _overlayEntry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        // Blurred background
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: const Color.fromARGB(218, 0, 0, 0)
                    .withOpacity(0.2), // dim effect
              ),
            ),
          ),
        ),

        // Popup card
        Positioned(
          left: position.dx + size.width / 2 - 300, // center card
          top: position.dy + size.height + 8,
          child: const LivePriceCard(
            goldPrice: "195000",
            silverPrice: "19500",
            goldChange: "200",
            silverChange: "50",
          ),
        ),
      ],
    ),
  );

  Overlay.of(context).insert(_overlayEntry!);
}
