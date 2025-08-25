import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lalgedi/features/home/presentation/widgets/liveprice.dart';

OverlayEntry? _overlayEntry;

void showLivePricePopup(BuildContext context, GlobalKey targetKey) {
  final renderBox = targetKey.currentContext!.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero);
  final size = renderBox.size;

  _overlayEntry = OverlayEntry(
    builder: (context) => Padding(
      padding: const EdgeInsets.all(8.0),
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

          // Popup card (NO Obx here)
          Positioned(
            left: position.dx + size.width / 2 - 300,
            top: position.dy + size.height + 8,
            child: LivePriceCard(), // <- clean widget
          ),
        ],
      ),
    ),
  );

  Overlay.of(context).insert(_overlayEntry!);
}
