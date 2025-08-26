import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/features/auth/Getx/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController());

    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;

    Widget otpBox(int index) {
      return SizedBox(
        width: size.width * 0.15, // ✅ responsive width
        child: TextField(
          controller: controller.controllers[index],
          focusNode: controller.focusNodes[index],
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textAlign: TextAlign.center,
          maxLength: 1,
          style: TextStyle(fontSize: isSmall ? 18 : 20),
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD10707)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD10707), width: 2),
            ),
          ),
          onChanged: (value) => controller.handleOtpInput(value, index),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            ClipRect(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset("assets/image/logo.png"),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.all(size.width * 0.05), // ✅ responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.08),

                  // Logo Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/logo.png',
                          width: size.width * 0.12, height: size.width * 0.12),
                      Text(
                        "लाल",
                        style: TextStyle(
                          fontSize: size.width * 0.12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                      Text(
                        "गेंडी",
                        style: TextStyle(
                          fontSize: size.width * 0.12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.12),

                  Text(
                    "Please Enter OTP Sent to\nYour Email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),

                  // OTP Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) => otpBox(index)),
                  ),
                  SizedBox(height: size.height * 0.04),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primarycolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: controller.onContinue,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.025),

                  // Resend Section with GetX
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Didn't get code? "),
                          GestureDetector(
                            onTap: controller.enableResend.value
                                ? controller.onResend
                                : null,
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: controller.enableResend.value
                                    ? const Color(0xFFD10707)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          Text(
                            controller.enableResend.value
                                ? ""
                                : " in ${controller.secondsRemaining.value} sec",
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
