import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/widgets/textfield.dart';
import 'package:lalgedi/features/auth/presentation/signuppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _SignupState();
}

class _SignupState extends State<LoginPage> {
  // Controllers

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
                        "गेंडी",
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
                    controller: emailController,
                  ),
                  const SizedBox(height: 25),

                  // Password
                  CustomTextField(
                    hintText: "password",
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
                                TextSpan(
                                  text: "Remember me",
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
                              // Sign up logic here
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
                  ),
                  const SizedBox(height: 16),

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
                  Row(
                    children: [
                      const Text(
                        "Don't have account ? ",
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Signup();
                              },
                            ),
                          );
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
