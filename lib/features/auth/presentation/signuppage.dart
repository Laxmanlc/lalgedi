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
    final size = MediaQuery.of(context).size;

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
                left: size.width * 0.04,
                right: size.width * 0.04,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.06),

                  // Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/logo.png',
                        width: size.width * 0.12,
                        height: size.width * 0.12,
                      ),
                      Text(
                        "लाल",
                        style: TextStyle(
                          fontSize: size.width * 0.12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                      Text(
                        "गेडी",
                        style: TextStyle(
                          fontSize: size.width * 0.12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.07),

                  Text(
                    "SignUp",
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),

                  // Shop Name
                  CustomTextField(
                    hintText: "Shop name",
                    controller: controller.shopNameController,
                  ),
                  SizedBox(height: size.height * 0.015),

                  // Username
                  CustomTextField(
                    hintText: "username",
                    controller: controller.yourNameController,
                  ),
                  SizedBox(height: size.height * 0.015),

                  // Phone Number
                  CustomTextField(
                    hintText: "Phone number",
                    controller: controller.phonenumber,
                  ),
                  SizedBox(height: size.height * 0.015),

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
                  SizedBox(height: size.height * 0.02),

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
                  SizedBox(height: size.height * 0.02),

                  // SignUp Button
                  Obx(() => SizedBox(
                        width: double.infinity,
                        height: size.height * 0.06,
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
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: size.height * 0.02),

                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have account ? ",
                        style: TextStyle(fontSize: size.width * 0.045),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const LoginPage());
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.05,
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
