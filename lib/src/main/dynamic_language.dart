import 'dart:ui';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../model/model.dart';

class DynamicLanguage {
  static String urlValue = '';
  static bool isLoading = false;
  static RxString selectedLanguage ='en'.obs;
  static Rx<TextDirection> languageDirection =TextDirection.ltr.obs;
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
    selectedLanguage.value = langKey;
  }
  static updateLanguageDir(TextDirection dir){
    languageDirection.value = dir;
  }

  static changeLanguage(String langKey){
    selectedLanguage.value = langKey;
    Get.find<LanguageController>().changeLanguage(langKey);
  }
}
