import 'package:flutter/material.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/features/account/presentation/widgets/settingwidget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background Cover with Title
            Stack(
              alignment: Alignment.center,
              children: [
                // Cover image
                Image.asset(
                  "assets/image/cover.jpg",
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),

                // Outlined Text (Ashish Jewellers)
                Stack(
                  children: [
                    Text(
                      "Ashish Jewellers",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 4
                          ..color = AppColors.primarycolor,
                      ),
                    ),
                    const Text(
                      "Ashish Jewellers",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Profile Picture with Edit + Verified
            Transform.translate(
              offset: const Offset(0, -80),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Circular profile with border
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundImage:
                          AssetImage("assets/image/profilepic.jpg"),
                    ),
                  ),

                  // Edit Button
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primarycolor,
                        child: Icon(
                          Icons.mode_edit_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  // Verified Badge
                  const Positioned(
                    bottom: -5,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Name
            const Text(
              "Ashish BK",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Settings Section
            Container(
              margin: const EdgeInsets.all(5), // side spacing
              padding: const EdgeInsets.all(10), // inner padding
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(-5, 5),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Setting",
                    style: TextStyle(
                        color: AppColors.primarycolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SettingItem(
                    icon: Icons.color_lens,
                    title: "Appearance",
                    description: "Change app theme",
                  ),
                  SizedBox(height: 12),
                  SettingItem(
                    icon: Icons.language,
                    title: "Language",
                    description: "Change language in app",
                  ),
                  SizedBox(height: 12),
                  SettingItem(
                    icon: Icons.scale,
                    title: "Unit system",
                    description: "Change Unit system for gold and silver",
                  ),
                  SizedBox(height: 12),
                  SettingItem(
                    icon: Icons.calendar_today,
                    title: "Calendar",
                    description: "Change calendar system",
                  ),
                  SizedBox(height: 12),
                  SettingItem(
                    icon: Icons.notifications,
                    title: "Notification",
                    description: "Enable and disable app notification",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Help & Support Section
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(-5, 5),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Help and Support",
                    style: TextStyle(
                        color: AppColors.primarycolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SettingItem(
                    icon: Icons.message,
                    title: "Connect To Whats-app",
                    description: "Connect with us in whatsapp",
                  ),
                  SizedBox(height: 12),
                  SettingItem(
                    icon: Icons.facebook,
                    title: "Facebook Page",
                    description: "LalGedi facebook page",
                  ),
                  SizedBox(height: 12),
                  SettingItem(
                    icon: Icons.email,
                    title: "Email Support",
                    description: "Email us for any support",
                  ),
                  SizedBox(height: 12),
                  SettingItem(
                    icon: Icons.support_agent,
                    title: "In-App Support",
                    description: "Chat ai assistant of app",
                  ),
                  SizedBox(height: 12),
                  SettingItem(
                    icon: Icons.bug_report,
                    title: "Report Bugs",
                    description: "Report Bugs of app",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(-5, 5),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legal",
                    style: TextStyle(
                        color: AppColors.primarycolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SettingItem(
                    icon: Icons.description,
                    title: "Terms and COndition",
                    description: "Terms and COndition of app",
                  ),
                  SizedBox(height: 12),
                  SettingItem(
                    icon: Icons.privacy_tip,
                    title: "Privacy Poolicy ",
                    description: "Our privacy policy",
                  ),
                  SizedBox(height: 12),
                  SettingItem(
                    icon: Icons.info,
                    title: "About Us",
                    description: "About lalgedi App",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(-5, 5),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Setting",
                    style: TextStyle(
                        color: AppColors.primarycolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SettingItem(
                    icon: Icons.settings_outlined,
                    title: "Profile Setting",
                    description: "Logout, change and forgot password",
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
