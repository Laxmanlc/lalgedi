import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // ✅ added
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
                left: context.sw(15),
                right: context.sw(15),
                bottom:
                    MediaQuery.of(context).viewInsets.bottom + context.sh(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.sh(40)),

                  // Logo Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/logo.png',
                        width: context.sw(50),
                        height: context.sh(50),
                      ),
                      Text(
                        "लाल",
                        style: TextStyle(
                          fontSize: context.sp(50),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                      Text(
                        "गेडी",
                        style: TextStyle(
                          fontSize: context.sp(50),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.sh(50)),

                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: context.sp(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: context.sh(20)),

                  // Email
                  CustomTextField(
                    hintText: "email",
                    controller: controller.emailController,
                  ),
                  SizedBox(height: context.sh(25)),

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
                  SizedBox(height: context.sh(16)),

                  // Remember me
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            activeColor: const Color(0xFFD10707),
                            value: controller.agreeToTerms.value,
                            onChanged: controller.toggleTerms,
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: context.sp(14),
                                ),
                                children: const [
                                  TextSpan(
                                    text: "Remember me",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: context.sh(16)),

                  // Login Button
                  Obx(() => SizedBox(
                        width: double.infinity,
                        height: context.sh(50),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.agreeToTerms.value
                                ? const Color(0xFFD10707)
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(context.sw(8)),
                            ),
                          ),
                          onPressed: controller.agreeToTerms.value
                              ? () {
                                  Get.offAll(() => NavigationBarScreen());
                                }
                              : null,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: context.sp(18),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: context.sh(16)),

                  // Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.sp(17),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.sh(20)),

                  // Signup Link
                  Row(
                    children: [
                      Text(
                        "Don't have account ? ",
                        style: TextStyle(fontSize: context.sp(18)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const Signup());
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.sp(19),
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
