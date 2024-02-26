import 'dart:ui';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../model/model.dart';

class DynamicLanguage {
  static String urlValue = '';
  static final RxBool _isLoading = false.obs;
  static bool get isLoading => _isLoading.value;

  static RxString selectedLanguage = 'en'.obs;
  static TextDirection languageDirection = Get.find<LanguageController>().languageDirection;
  static List<Language> languages = [];
  static init({required String url}) {
    urlValue = url;
    if (urlValue != '') {
      Get.put(LanguageController());
    }
  }

  /// Getting language by key
  static key(String key) {
    return Get.find<LanguageController>().getTranslation(key);
  }

  /// Update language loading status
  static updateStatus(bool status) {
    _isLoading.value = status;
  }

  /// Update language key
  static updateLanguageKey(String langKey) {
    selectedLanguage.value = langKey;
  }

  /// Update Language Direction
  static updateLanguageDirection(TextDirection textDirection) {
    languageDirection = textDirection;
  }

  /// Change language method
  static changeLanguage(String langKey) {
    selectedLanguage.value = langKey;
    Get.find<LanguageController>().changeLanguage(langKey);
    languageDirection = Get.find<LanguageController>().languageDirection;
  }
}
