import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lalgedi/core/utils/colors.dart';
import 'package:lalgedi/core/utils/responsive.dart'; // ✅ responsive utils
import 'package:lalgedi/core/widgets/url_launcher.dart';
import 'package:lalgedi/features/account/presentation/widgets/settingwidget.dart';
import 'package:lalgedi/features/auth/Getx/account_controller.dart';
import 'package:lalgedi/features/auth/Getx/thehe_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountController controller = Get.put(AccountController());
    final ThemeController themeController = Get.find();
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
                    "setting.title".tr,
                    style: TextStyle(
                      color: AppColors.primarycolor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.sp(15),
                    ),
                  ),
                  SizedBox(height: context.sh(10)),
                  SettingItem(
                    icon: Icons.color_lens,
                    title: "setting.appearance.title".tr,
                    description: "setting.appearance.description".tr,
                    onTap: () {
                      Get.defaultDialog(
                        title: "Theme Settings".tr,
                        content: Obx(() {
                          return SwitchListTile(
                            title: Text(themeController.isDarkMode.value
                                ? "account.dark_mode".tr
                                : "account.light_mode".tr),
                            value: themeController.isDarkMode.value,
                            onChanged: (value) {
                              themeController.toggleTheme(value);
                            },
                          );
                        }),
                        textCancel: "general.close".tr,
                      );
                    },
                  ),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.language,
                    title: "setting.language.title".tr,
                    description: "setting.language.description".tr,
                    onTap: showLanguageSwitcherDialog,
                  ),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.scale,
                    title: "setting.unit_system.title".tr,
                    description: "setting.unit_system.description".tr,
                  ),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.calendar_today,
                    title: "setting.calendar.title".tr,
                    description: "setting.calendar.description".tr,
                  ),
                  SizedBox(height: context.sh(12)),
                  Obx(() => SettingItem(
                        icon: Icons.notifications,
                        title: "setting.notification.title".tr,
                        description: controller.notificationsEnabled.value
                            ? "setting.notification.enabled".tr
                            : "setting.notification.disabled".tr,
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
                    "help_support.title".tr,
                    style: TextStyle(
                      color: AppColors.primarycolor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.sp(15),
                    ),
                  ),
                  SizedBox(height: context.sh(10)),
                  SettingItem(
                      icon: Icons.message,
                      title: "help_support.whatsapp.title".tr,
                      description: "help_support.whatsapp.description".tr,
                      onTap: () {
                        UrlLauncherHelper.openWhatsApp("9779861355002");
                      }),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.facebook,
                    title: "help_support.facebook.title".tr,
                    description: "help_support.facebook.description".tr,
                    onTap: () {
                      UrlLauncherHelper.openFacebook(
                          "https://www.facebook.com/ashish.bk.379621");
                    },
                  ),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.email,
                    title: "help_support.email.title".tr,
                    description: "help_support.email.description".tr,
                    onTap: () {
                      UrlLauncherHelper.openMail("");
                    },
                  ),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.support_agent,
                    title: "help_support.in_app.title".tr,
                    description: "help_support.in_app.description".tr,
                  ),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.bug_report,
                    title: "help_support.report_bugs.title".tr,
                    description: "help_support.report_bugs.description".tr,
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
                    "legal.title".tr,
                    style: TextStyle(
                      color: AppColors.primarycolor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.sp(15),
                    ),
                  ),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.description,
                    title: "legal.terms.title".tr,
                    description: "legal.terms.description".tr,
                  ),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.privacy_tip,
                    title: "legal.privacy.title".tr,
                    description: "legal.privacy.description".tr,
                  ),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.info,
                    title: "legal.about.title".tr,
                    description: "legal.about.description".tr,
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
                    "profile.title".tr,
                    style: TextStyle(
                      color: AppColors.primarycolor,
                      fontWeight: FontWeight.bold,
                      fontSize: context.sp(15),
                    ),
                  ),
                  SizedBox(height: context.sh(12)),
                  SettingItem(
                    icon: Icons.settings_outlined,
                    title: "profile.setting.title".tr,
                    description: "profile.setting.description".tr,
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
