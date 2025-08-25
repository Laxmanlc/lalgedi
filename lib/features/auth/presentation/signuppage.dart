import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/widgets/textfield.dart';
import 'package:lalgedi/features/auth/Getx/signup_controller.dart';
import 'package:lalgedi/features/auth/presentation/login_page.dart';
import 'package:lalgedi/features/auth/presentation/otpscreen.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundcolor,
      body: Stack(
        children: [
          // Background image
          ClipRect(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset("assets/image/logo.png"),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/logo.png',
                          width: 50, height: 50),
                      const Text(
                        "लाल",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                      const Text(
                        "गेडी",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  const Text(
                    "SignUp",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Shop Name
                  CustomTextField(
                    hintText: "Shop name",
                    controller: controller.shopNameController,
                  ),
                  const SizedBox(height: 12),

                  // Username
                  CustomTextField(
                    hintText: "username",
                    controller: controller.yourNameController,
                  ),
                  const SizedBox(height: 12),

                  // Email
                  CustomTextField(
                    hintText: "Phone number",
                    controller: controller.phonenumber,
                  ),
                  const SizedBox(height: 12),

                  // Password
                  Obx(() => CustomTextField(
                        hintText: "Password",
                        controller: controller.passwordController,
                        obscureText: !controller.showPassword.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.showPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black54,
                          ),
                          onPressed: controller.togglePassword,
                        ),
                      )),
                  const SizedBox(height: 16),

                  // Terms & Conditions
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            activeColor: const Color(0xFFD10707),
                            value: controller.agreeToTerms.value,
                            onChanged: controller.toggleTerms,
                          ),
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(text: "I agree to "),
                                  TextSpan(
                                    text: "Terms & Condition",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 16),

                  // SignUp Button
                  Obx(() => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.agreeToTerms.value
                                ? const Color(0xFFD10707)
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: controller.agreeToTerms.value
                              ? () {
                                  Get.to(() => const OtpScreen());
                                }
                              : null,
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 16),

                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have account ? ",
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const LoginPage());
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
