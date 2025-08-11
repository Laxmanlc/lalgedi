import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/widgets/textfield.dart';
import 'package:lalgedi/features/auth/presentation/login_page.dart';
import 'package:lalgedi/features/auth/presentation/otpscreen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // Controllers
  final shopNameController1 = TextEditingController();
  final yournamecontroller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool agreeToTerms = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // allows form to move up on keyboard
      backgroundColor: AppColors.backgroundcolor,
      body: Stack(
        children: [
          // Background fixed image
          Align(
            alignment: Alignment.bottomLeft,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                "assets/image/logo.png",
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
                      Image.asset(
                        'assets/image/logo.png',
                        width: 50,
                        height: 50,
                      ),
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

                  // Shop Name 1
                  CustomTextField(
                    hintText: "Shop name",
                    controller: shopNameController1,
                  ),
                  const SizedBox(height: 12),

                  // Your name
                  CustomTextField(
                    hintText: "username",
                    controller: yournamecontroller,
                  ),
                  const SizedBox(height: 12),

                  // Email
                  CustomTextField(
                    hintText: "Email",
                    controller: emailController,
                  ),
                  const SizedBox(height: 12),

                  // Password
                  CustomTextField(
                    hintText: "Password",
                    controller: passwordController,
                    obscureText: !showPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Terms & Conditions
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        agreeToTerms = !agreeToTerms;
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: const Color(0xFFD10707),
                          value: agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              agreeToTerms = value ?? false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "I agree to "),
                                TextSpan(
                                  text: "Terms & Condition",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // SignUp Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: agreeToTerms
                            ? const Color(0xFFD10707)
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: agreeToTerms
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const OtpScreen();
                                }),
                              );
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
                  ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              },
                            ),
                          );
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
