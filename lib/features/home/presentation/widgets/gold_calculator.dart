import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';

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

    // Example calculation
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
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffix != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 12, top: 12),
                    child: Text(
                      suffix,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : null,
            suffixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: widget.themeColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: widget.themeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: widget.themeColor, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              children: [
                Icon(Icons.calculate, color: widget.themeColor),
                const SizedBox(width: 6),
                Text(widget.title,
                    style: TextStyle(
                        color: widget.themeColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),

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
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
                onPressed: _calculate,
                child: const Text(
                  "Calculate",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundcolor),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Summary (only show if calculated)
            if (_showSummary) ...[
              const Text("Summary",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundcolor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _buildSummaryRow(
                        "Gold Value : ${_goldQuantityController.text} tola",
                        goldValue),
                    _buildSummaryRow(
                        "Wastage value : ${_wastageController.text}%",
                        wastageValue),
                    _buildSummaryRow("Making value", makingValue),
                    const Divider(),
                    _buildSummaryRow("Estimated cost", estimatedCost,
                        highlight: true),
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                  color: highlight ? AppColors.primarycolor : Colors.black)),
          Text(
            "${widget.currencyLabel} ${value.toStringAsFixed(0)}",
            style: TextStyle(
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: highlight ? AppColors.primarycolor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
