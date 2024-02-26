import 'dart:ui';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../model/model.dart';

class DynamicLanguage {
  static String urlValue = '';
  static RxBool _isLoading = false.obs;
 static bool get isLoading => _isLoading.value;

  static RxString selectedLanguage = 'en'.obs;
  static Rx<TextDirection> languageDirection = TextDirection.ltr.obs;
  static List<Language> languages = [];
  static init({required String url}) {
    urlValue = url;
    if (urlValue != '') {
      Get.put(LanguageController());
    }
  }

  static key(String key) {
    return Get.find<LanguageController>().getTranslation(key);
  }

  static updateStatus(bool status) {
    _isLoading.value = status;
  }

  static updateLanguageKey(String langKey) {
    selectedLanguage.value = langKey;
  }

  // static TextDirection get languageDirection=>  Get.find<LanguageController>().languageDirection;
  static changeLanguage(String langKey) {
    selectedLanguage.value = langKey;
    Get.find<LanguageController>().changeLanguage(langKey);
    languageDirection.value = Get.find<LanguageController>().languageDirection;
  }
}
