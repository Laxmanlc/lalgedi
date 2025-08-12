import 'package:flutter/material.dart';

class RateItem {
  final String label;
  final String price;
  final String? unit;
  final String? badgeLabel;
  final String? purity;
  final Widget? image;
  final Color? labelColor;

  const RateItem({
    required this.label,
    required this.price,
    this.unit,
    this.badgeLabel,
    this.purity,
    this.image,
    this.labelColor,
  });
}
