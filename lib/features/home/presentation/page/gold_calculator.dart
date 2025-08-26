import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // ✅ use responsive helpers

class JewelryCalculatorWidget extends StatefulWidget {
  final String title;
  final Color themeColor;
  final String currencyLabel;

  const JewelryCalculatorWidget({
    super.key,
    this.title = "Simple Jewelry Calculator",
    this.themeColor = AppColors.primarycolor,
    this.currencyLabel = "NPR",
  });

  @override
  State<JewelryCalculatorWidget> createState() =>
      _JewelryCalculatorWidgetState();
}

class _JewelryCalculatorWidgetState extends State<JewelryCalculatorWidget> {
  final TextEditingController _goldQuantityController = TextEditingController();
  final TextEditingController _wastageController = TextEditingController();
  final TextEditingController _makingFeesController = TextEditingController();

  bool _showSummary = false;
  double goldValue = 0;
  double wastageValue = 0;
  double makingValue = 0;
  double estimatedCost = 0;

  void _calculate() {
    final qty = double.tryParse(_goldQuantityController.text) ?? 0;
    final wastagePercent = double.tryParse(_wastageController.text) ?? 0;
    final makingFee = double.tryParse(_makingFeesController.text) ?? 0;

    goldValue = qty * 1000; // Example: Rate per tola = 1000 NPR
    wastageValue = goldValue * (wastagePercent / 100);
    makingValue = makingFee;

    estimatedCost = goldValue + wastageValue + makingValue;

    setState(() {
      _showSummary = true;
    });
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    String? suffix,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.number,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: context.sp(14), // ✅ responsive font
          ),
        ),
        SizedBox(height: context.sh(4)),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: context.sp(14)), // ✅ responsive input font
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: context.sp(13)),
            suffixIcon: suffix != null
                ? Padding(
                    padding: EdgeInsets.only(
                      right: context.sw(12),
                      top: context.sh(12),
                    ),
                    child: Text(
                      suffix,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.sp(13),
                      ),
                    ),
                  )
                : null,
            suffixIconConstraints: BoxConstraints(
              minWidth: context.sw(0),
              minHeight: context.sh(0),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.sw(12),
              vertical: context.sh(12),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.sw(8)),
              borderSide: BorderSide(color: widget.themeColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.sw(8)),
              borderSide: BorderSide(color: widget.themeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.sw(8)),
              borderSide: BorderSide(color: widget.themeColor, width: 2),
            ),
          ),
        ),
        SizedBox(height: context.sh(12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(context.sw(12)), // ✅ responsive radius
      ),
      child: Padding(
        padding: EdgeInsets.all(context.sw(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              children: [
                Icon(Icons.calculate,
                    color: widget.themeColor, size: context.sp(20)),
                SizedBox(width: context.sw(6)),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.themeColor,
                    fontSize: context.sp(16), // ✅ responsive title
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.sh(16)),

            // Inputs
            _buildTextField(
              label: "Gold Quantity",
              hint: "Eg: 0.000",
              suffix: "Tola",
              controller: _goldQuantityController,
            ),
            _buildTextField(
              label: "Wastage",
              hint: "Eg: 0.0 %",
              suffix: "%",
              controller: _wastageController,
            ),
            _buildTextField(
              label: "Making Fees",
              hint: widget.currencyLabel,
              controller: _makingFeesController,
            ),

            // Calculate button
            SizedBox(
              width: double.infinity,
              height: context.sh(48),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.sw(10)),
                  ),
                  elevation: 4,
                ),
                onPressed: _calculate,
                child: Text(
                  "Calculate",
                  style: TextStyle(
                    fontSize: context.sp(16),
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundcolor,
                  ),
                ),
              ),
            ),

            SizedBox(height: context.sh(16)),

            // Summary
            if (_showSummary) ...[
              Text(
                "Summary",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.sp(14),
                ),
              ),
              SizedBox(height: context.sh(8)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: context.sw(12),
                  vertical: context.sh(12),
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroundcolor,
                  borderRadius: BorderRadius.circular(context.sw(8)),
                  border: Border.all(color: Colors.red.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: context.sw(5),
                      offset: Offset(0, context.sh(2)),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _buildSummaryRow(
                      "Gold Value : ${_goldQuantityController.text} tola",
                      goldValue,
                    ),
                    _buildSummaryRow(
                      "Wastage value : ${_wastageController.text}%",
                      wastageValue,
                    ),
                    _buildSummaryRow("Making value", makingValue),
                    const Divider(),
                    _buildSummaryRow(
                      "Estimated cost",
                      estimatedCost,
                      highlight: true,
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value,
      {bool highlight = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sh(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: context.sp(13),
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: highlight ? AppColors.primarycolor : Colors.black,
            ),
          ),
          Text(
            "${widget.currencyLabel} ${value.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: context.sp(13),
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: highlight ? AppColors.primarycolor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
