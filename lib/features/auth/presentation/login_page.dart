import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/widgets/textfield.dart';
import 'package:lalgedi/features/auth/Getx/login_controller.dart';
import 'package:lalgedi/features/auth/presentation/signuppage.dart';
import 'package:lalgedi/features/navigationbar/navigationscreen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundcolor,
      body: Stack(
        children: [
          // Background fixed image
          ClipRect(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset("assets/image/logo.png"),
              ),
            ),
          ),

          // Scrollable content
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

                  // Logo Row
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
                    "Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Email
                  CustomTextField(
                    hintText: "email",
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 25),

                  // Password
                  Obx(() => CustomTextField(
                        hintText: "password",
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

                  // Remember me
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
                                  TextSpan(
                                    text: "Remember me",
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

                  // Login Button
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
                                  Get.offAll(() => NavigationBarScreen());
                                }
                              : null,
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(height: 16),

                  // Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Signup Link
                  Row(
                    children: [
                      const Text(
                        "Don't have account ? ",
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const Signup());
                        },
                        child: const Text(
                          "Signup",
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
