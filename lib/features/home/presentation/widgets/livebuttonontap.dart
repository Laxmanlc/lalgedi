import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // import helper
import 'package:lalgedi/features/home/presentation/widgets/liveprice.dart';

OverlayEntry? _overlayEntry;

void showLivePricePopup(BuildContext context, GlobalKey targetKey) {
  final renderBox = targetKey.currentContext!.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero);
  final size = renderBox.size;

  final screenWidth = MediaQuery.of(context).size.width;

  _overlayEntry = OverlayEntry(
    builder: (context) => Padding(
      padding: context.ep(8), // responsive padding
      child: Stack(
        children: [
          // Blurred background (tap to close)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),

          // Popup card
          Positioned(
            // Center the popup relative to the button
            left: (position.dx + size.width / 2 - (screenWidth * 0.75) / 2)
                .clamp(8.0, screenWidth - screenWidth * 0.75 - 8.0),
            top: position.dy + size.height + context.sh(8),
            width: screenWidth * 0.75, // responsive width (75% of screen)
            child: LivePriceCard(), // your clean widget
          ),
        ],
      ),
    ),
  );

  Overlay.of(context).insert(_overlayEntry!);
}
