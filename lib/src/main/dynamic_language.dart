import 'dart:ui';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../model/model.dart';

class DynamicLanguage {
  static String urlValue = '';
  static bool isLoading = false;
  static String selectedLanguage ='en';
  static TextDirection languageDirection =TextDirection.ltr;
  static List<Language> languages=[];
  static init({required String url}) {
    urlValue = url;
    if (urlValue != '') {
      Get.put(LanguageController());
    }
  }

  static key(String key) {
    return Get.find<LanguageController>().getTranslation(key);
  }

  static updateStatus(bool status){
    isLoading = status;
}
  static updateLanguageKey(String langKey){
    selectedLanguage = langKey;
  }
  static updateLanguageDir(TextDirection dir){
    languageDirection = dir;
  }

  static changeLanguage(String langKey){
    selectedLanguage = Get.find<LanguageController>().selectedLanguage.value;
    Get.find<LanguageController>().changeLanguage(langKey);
  }
}
