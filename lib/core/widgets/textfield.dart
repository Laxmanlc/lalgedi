// ---------------- Reusable TextField Widget ----------------
import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // ✅ add this

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: context.sp(14)), // ✅ responsive font
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: context.sp(14)), // ✅ responsive hint
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.sw(16),
          vertical: context.sh(12), // ✅ make vertical padding responsive too
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD10707)),
          borderRadius:
              BorderRadius.circular(context.sw(8)), // ✅ responsive radius
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD10707)),
          borderRadius: BorderRadius.circular(context.sw(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD10707), width: 2),
          borderRadius: BorderRadius.circular(context.sw(8)),
        ),
      ),
    );
  }
}
