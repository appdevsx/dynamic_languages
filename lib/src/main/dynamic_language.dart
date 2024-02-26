import 'package:get/get.dart';

import '../controller/controller.dart';

class DynamicLanguage {
  static String urlValue = '';
  static init({required String url}) {
    urlValue = url;
    if (urlValue != '') {
      Get.put(LanguageController());
    }
  }

  static key(String key) {
    return Get.find<LanguageController>().getTranslation(key);
  }

  static update(String key) {}
}
