import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  final _storage = GetStorage();
  final _key = 'language';

  // observable current locale
  var currentLocale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    super.onInit();
    String? langCode = _storage.read(_key);
    if (langCode != null) {
      currentLocale.value = langCode == 'ne'
          ? const Locale('ne', 'NP')
          : const Locale('en', 'US');
      Get.updateLocale(currentLocale.value);
    }
  }

  void changeLanguage(String langCode) {
    Locale locale =
        langCode == 'ne' ? const Locale('ne', 'NP') : const Locale('en', 'US');
    currentLocale.value = locale;
    Get.updateLocale(locale);
    _storage.write(_key, langCode);
  }
}
