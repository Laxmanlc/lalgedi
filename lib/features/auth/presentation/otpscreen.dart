import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/features/onboarding/onboarding.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  int secondsRemaining = 15;
  bool enableResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    Future.doWhile(() async {
      if (secondsRemaining > 0) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() => secondsRemaining--);
        return true;
      } else {
        setState(() => enableResend = true);
        return false;
      }
    });
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 20),
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
        onChanged: (value) {
          // Handle pasting whole OTP
          if (value.length > 1) {
            final pasted = value.split('');
            for (int i = 0; i < pasted.length && i < _controllers.length; i++) {
              _controllers[i].text = pasted[i];
            }
            FocusScope.of(context).unfocus();
            return;
          }

          if (value.isNotEmpty && index < _focusNodes.length - 1) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Row

                  const SizedBox(height: 50),
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

                  const SizedBox(height: 100),
                  const Text(
                    "Please Enter OTP Sent to\nYour Email",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),

                  // OTP Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) => otpBox(index)),
                  ),
                  const SizedBox(height: 30),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primarycolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const OnboardingScreen();
                          }),
                        );
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Resend Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't get code? "),
                      GestureDetector(
                        onTap: enableResend
                            ? () {
                                setState(() {
                                  secondsRemaining = 15;
                                  enableResend = false;
                                });
                                startTimer();
                              }
                            : null,
                        child: Text(
                          "Resend",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: enableResend
                                ? const Color(0xFFD10707)
                                : Colors.grey,
                          ),
                        ),
                      ),
                      Text(
                        enableResend ? "" : " in $secondsRemaining sec",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
