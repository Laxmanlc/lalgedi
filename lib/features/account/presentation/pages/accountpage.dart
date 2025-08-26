import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // ✅ responsive utils
import 'package:lalgedi/features/account/presentation/widgets/settingwidget.dart';
import 'package:lalgedi/features/auth/Getx/account_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountController controller = Get.put(AccountController());

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
                  height: context.sh(220),
                  fit: BoxFit.cover,
                ),
                // Outlined Text (Ashish Jewellers)
                Stack(
                  children: [
                    Text(
                      "Ashish Jewellers",
                      style: TextStyle(
                        fontSize: context.sp(28),
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..color = AppColors.primarycolor
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = context.sw(4),
                      ),
                    ),
                    Text(
                      "Ashish Jewellers",
                      style: TextStyle(
                        fontSize: context.sp(28),
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
              offset: Offset(0, -context.sh(80)),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Circular profile with border
                  Obx(() => Container(
                        padding: EdgeInsets.all(context.sw(4)),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: context.sw(80),
                          backgroundImage:
                              AssetImage(controller.profileImage.value),
                        ),
                      )),

                  // Edit Button
                  Positioned(
                    top: context.sh(5),
                    right: context.sw(5),
                    child: GestureDetector(
                      onTap: () {
                        controller
                            .updateProfileImage("assets/image/profilepic2.jpg");
                      },
                      child: Container(
                        padding: EdgeInsets.all(context.sw(2)),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: context.sw(18),
                          backgroundColor: AppColors.primarycolor,
                          child: Icon(
                            Icons.mode_edit_outlined,
                            color: Colors.white,
                            size: context.sp(20),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Verified Badge
                  Positioned(
                    bottom: -context.sh(5),
                    child: CircleAvatar(
                      radius: context.sw(12),
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: context.sp(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Name
            Obx(() => Text(
                  controller.userName.value,
                  style: TextStyle(
                    fontSize: context.sp(30),
                    fontWeight: FontWeight.bold,
                  ),
                )),

            SizedBox(height: context.sh(20)),

            // Settings Section
            Container(
              margin: EdgeInsets.all(context.sw(5)),
              padding: EdgeInsets.all(context.sw(10)),
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(context.sw(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: context.sw(6),
                    offset: Offset(-context.sw(5), context.sh(5)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Setting",
                    style: TextStyle(
                      color: AppColors.primarycolor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.sp(15),
                    ),
                  ),
                  SizedBox(height: context.sh(10)),
                  const SettingItem(
                    icon: Icons.color_lens,
                    title: "Appearance",
                    description: "Change app theme",
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.language,
                    title: "Language",
                    description: "Change language in app",
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.scale,
                    title: "Unit system",
                    description: "Change Unit system for gold and silver",
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.calendar_today,
                    title: "Calendar",
                    description: "Change calendar system",
                  ),
                  SizedBox(height: context.sh(12)),
                  Obx(() => SettingItem(
                        icon: Icons.notifications,
                        title: "Notification",
                        description: controller.notificationsEnabled.value
                            ? "Enabled"
                            : "Disabled",
                        onTap: controller.toggleNotifications,
                      )),
                ],
              ),
            ),

            SizedBox(height: context.sh(20)),

            // Help & Support Section
            Container(
              margin: EdgeInsets.all(context.sw(5)),
              padding: EdgeInsets.all(context.sw(10)),
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(context.sw(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: context.sw(6),
                    offset: Offset(-context.sw(5), context.sh(5)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Help and Support",
                    style: TextStyle(
                      color: AppColors.primarycolor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.sp(15),
                    ),
                  ),
                  SizedBox(height: context.sh(10)),
                  const SettingItem(
                    icon: Icons.message,
                    title: "Connect To Whats-app",
                    description: "Connect with us in whatsapp",
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.facebook,
                    title: "Facebook Page",
                    description: "LalGedi facebook page",
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.email,
                    title: "Email Support",
                    description: "Email us for any support",
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.support_agent,
                    title: "In-App Support",
                    description: "Chat ai assistant of app",
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.bug_report,
                    title: "Report Bugs",
                    description: "Report Bugs of app",
                  ),
                ],
              ),
            ),

            SizedBox(height: context.sh(20)),

            // Legal Section
            Container(
              margin: EdgeInsets.all(context.sw(5)),
              padding: EdgeInsets.all(context.sw(10)),
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(context.sw(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: context.sw(6),
                    offset: Offset(-context.sw(5), context.sh(5)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legal",
                    style: TextStyle(
                      color: AppColors.primarycolor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.sp(15),
                    ),
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.description,
                    title: "Terms and Condition",
                    description: "Terms and Condition of app",
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.privacy_tip,
                    title: "Privacy Policy",
                    description: "Our privacy policy",
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.info,
                    title: "About Us",
                    description: "About lalgedi App",
                  ),
                ],
              ),
            ),

            SizedBox(height: context.sh(20)),

            // Profile Setting Section
            Container(
              margin: EdgeInsets.all(context.sw(5)),
              padding: EdgeInsets.all(context.sw(10)),
              decoration: BoxDecoration(
                color: AppColors.backgroundcolor,
                borderRadius: BorderRadius.circular(context.sw(12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: context.sw(6),
                    offset: Offset(-context.sw(5), context.sh(5)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Setting",
                    style: TextStyle(
                      color: AppColors.primarycolor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.sp(15),
                    ),
                  ),
                  SizedBox(height: context.sh(12)),
                  const SettingItem(
                    icon: Icons.settings_outlined,
                    title: "Profile Setting",
                    description: "Logout, change and forgot password",
                  ),
                ],
              ),
            ),
            SizedBox(height: context.sh(20)),
          ],
        ),
      ),
    );
  }
}
