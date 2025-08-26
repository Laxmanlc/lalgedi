import 'package:flutter/material.dart';

extension SimpleResponsive on BuildContext {
  /// Base design width used in your original UI (set to whatever your
  /// designer used; common is 360 or 390). I use 390 here.
  double get _baseWidth => 390;

  /// Scale factor = current width / base width
  double get scale => MediaQuery.of(this).size.width / _baseWidth;

  /// scaled font size
  double sp(double size) => size * scale;

  /// scaled width value (use instead of fixed widths)
  double sw(double value) => value * scale;

  /// scaled height value (use instead of fixed heights)
  double sh(double value) => value * scale;

  /// small helper for EdgeInsets from a single number
  EdgeInsets ep(double all) => EdgeInsets.all(all * scale);
}
