import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lalgedi/core/utils/colors.dart';

class GoldLoanCalculatorPage extends StatefulWidget {
  const GoldLoanCalculatorPage({super.key});

  @override
  State<GoldLoanCalculatorPage> createState() => _GoldLoanCalculatorPageState();
}

class _GoldLoanCalculatorPageState extends State<GoldLoanCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _rateCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();

  DateTime? _selectedDate;

  bool _showSummary = false;
  int _days = 0;
  double _interest = 0;
  double _total = 0;

  final _currency = NumberFormat.currency(locale: 'en_IN', symbol: 'Rs ');

  @override
  void dispose() {
    _amountCtrl.dispose();
    _rateCtrl.dispose();
    _dateCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    DateTime tempPickedDate = _selectedDate ?? now;

    await showCupertinoModalPopup(
      context: context,
      builder: (ctx) => Container(
        height: 250,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = DateTime(
                          tempPickedDate.year,
                          tempPickedDate.month,
                          tempPickedDate.day,
                        );
                        _dateCtrl.text =
                            DateFormat('dd-MM-yyyy').format(_selectedDate!);
                      });
                      Navigator.pop(ctx);
                    },
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                maximumDate: now,
                initialDateTime: _selectedDate ?? now,
                onDateTimeChanged: (val) {
                  tempPickedDate = val;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculate() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountCtrl.text.replaceAll(',', ''));
    final ratePct = double.parse(_rateCtrl.text);
    if (_selectedDate == null) {
      _snack('Please pick a loan date.');
      return;
    }

    final today = DateTime.now();
    _days = today.difference(_selectedDate!).inDays;
    if (_days < 0) {
      _snack('Loan date cannot be in the future.');
      return;
    }

    final r = ratePct / 100.0;
    _interest = amount * r * (_days / 365.0);
    _total = amount + _interest;

    setState(() => _showSummary = true);
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  InputDecoration _fieldDecoration({
    required String label,
    String? hint,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      isDense: true,
      suffixIcon: suffix == null
          ? null
          : Padding(padding: const EdgeInsets.only(right: 8), child: suffix),
      suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth > 500;
        final double horizontalPadding = isWide ? 32 : 16;
        final double maxWidth = isWide ? 500 : double.infinity;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "लाल",
                  style: TextStyle(
                    color: AppColors.primarycolor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "गेडी",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: 12),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'GOLD',
                        style: TextStyle(
                          color: AppColors.primarycolor,
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'LOAN CALCULATOR',
                        style: TextStyle(
                          letterSpacing: 1.1,
                          color: AppColors.primarycolor,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _label('Loan amount'),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _amountCtrl,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d{0,2}')),
                                ],
                                decoration: _fieldDecoration(
                                  label: '',
                                  hint: 'NPR …',
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return 'Enter loan amount';
                                  }
                                  final n = double.tryParse(v);
                                  if (n == null || n <= 0) {
                                    return 'Invalid amount';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),
                              _label('Loan date'),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _dateCtrl,
                                readOnly: true,
                                onTap: _pickDate,
                                decoration: _fieldDecoration(
                                  label: '',
                                  hint: 'DD-MM-YYYY',
                                  suffix: IconButton(
                                    onPressed: _pickDate,
                                    icon: const Icon(
                                        Icons.calendar_today_outlined),
                                    tooltip: 'Pick date',
                                  ),
                                ),
                                validator: (_) => _selectedDate == null
                                    ? 'Pick the date'
                                    : null,
                              ),
                              const SizedBox(height: 14),
                              _label('Interest rate'),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _rateCtrl,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d{0,3}')),
                                ],
                                decoration: _fieldDecoration(
                                  label: '',
                                  hint: 'Eg 12.0',
                                  suffix: const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('%',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return 'Enter annual rate';
                                  }
                                  final n = double.tryParse(v);
                                  if (n == null) return 'Invalid rate';
                                  if (n < 0 || n > 100) {
                                    return 'Rate must be 0–100';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 18),
                              SizedBox(
                                width: double.infinity,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.primarycolor,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x33000000),
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      )
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _calculate,
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                    ),
                                    child: const Text(
                                      'Calculate',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              if (_showSummary) ...[
                                _label('Loan Summary'),
                                const SizedBox(height: 8),
                                _summaryCard(),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEEEE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFD6D6)),
      ),
      child: Column(
        children: [
          _row('Loan amount', _currency.format(double.parse(_amountCtrl.text))),
          const SizedBox(height: 8),
          _row('Interest ($_days days)', _currency.format(_interest)),
          const SizedBox(height: 8),
          _row('Interest rate', '${_rateCtrl.text}%'),
          const Divider(height: 20, thickness: 1),
          _row('Total Payable', _currency.format(_total), emphasize: true),
        ],
      ),
    );
  }

  Widget _row(String left, String right, {bool emphasize = false}) {
    final styleLeft = TextStyle(
      fontWeight: emphasize ? FontWeight.w800 : FontWeight.w700,
      color: emphasize ? Colors.red.shade800 : Colors.black,
    );
    final styleRight = TextStyle(
      fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
      color: emphasize ? Colors.red.shade800 : Colors.black,
    );

    return Row(
      children: [
        Expanded(child: Text(left, style: styleLeft)),
        Text(right, style: styleRight),
      ],
    );
  }
}
