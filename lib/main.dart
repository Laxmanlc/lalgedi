import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lalgedi/core/utils/app_translation.dart';
import 'package:lalgedi/features/auth/Getx/thehe_controller.dart';
import 'package:lalgedi/features/home/presentation/bloc/language_controller.dart';
import 'package:lalgedi/features/splash/presentation/splash_screen.dart';
// change if your start screen is different

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ThemeController());
  GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.find();
  final LanguageController langController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        translations: AppTranslations(),
        locale: langController.currentLocale.value,
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        title: 'Your App',
        theme: ThemeData.light(), // light theme
        darkTheme: ThemeData.dark(), // dark theme
        themeMode: themeController.theme, // reactive theme
        home: const SplashScreen(), // or whatever your first screen is
      );
    });
  }
}
