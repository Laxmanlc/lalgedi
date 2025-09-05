import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lalgedi/features/home/presentation/bloc/nepali_price_controller.dart';
import 'package:workmanager/workmanager.dart';

import 'package:lalgedi/core/utils/app_translation.dart';
import 'package:lalgedi/features/auth/Getx/thehe_controller.dart';
import 'package:lalgedi/features/home/presentation/bloc/language_controller.dart';
import 'package:lalgedi/features/splash/presentation/splash_screen.dart';

// Workmanager task name
const fetchPricesTask = "fetchGoldSilverPriceTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == fetchPricesTask) {
      final controller = GoldPriceController();
      await controller.fetchPrices();
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage
  await GetStorage.init();

  // Initialize Workmanager for background fetch
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  // Register periodic task (every 15 min)
  Workmanager().registerPeriodicTask(
    "1",
    fetchPricesTask,
    frequency: const Duration(minutes: 15),
    initialDelay: const Duration(seconds: 5),
    constraints: Constraints(networkType: NetworkType.connected),
  );

  // Initialize GetX controllers
  Get.put(ThemeController());
  Get.put(LanguageController());
  Get.put(GoldPriceController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.find();
  final LanguageController langController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        translations: AppTranslations(),
        locale: langController.currentLocale.value,
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        title: 'Your App',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.theme,
        home: const SplashScreen(),
      );
    });
  }
}
