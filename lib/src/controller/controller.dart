import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../main/dynamic_language.dart';
import '../model/model.dart';
import '../service/service.dart';

class LanguageController extends GetxController {
  RxString selectedLanguage = "".obs; // Selected language is English
  RxString defLangKey = "".obs; // Default language is English

  @override
  void onInit() {
    fetchLanguages().then((value) => getDefaultKey());
    super.onInit();
  }

  late List<Language> languages;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  static const String selectedLanguageKey = 'selectedLanguage';

  Future<void> fetchLanguages() async {
    _isLoading.value = true;
    DynamicLanguage.updateStatus(_isLoading.value);
    try {
      final languageService = LanguageService();
      languages =
          await languageService.fetchLanguages(DynamicLanguage.urlValue);
      DynamicLanguage.languages =
          await languageService.fetchLanguages(DynamicLanguage.urlValue);
      _isLoading.value = false;
      DynamicLanguage.updateStatus(_isLoading.value);
    } catch (e) {
      debugPrint('Error fetching language data: $e');
    }
  }

  // >> get default language key
  String getDefaultKey() {
    _isLoading.value = true;
    DynamicLanguage.updateStatus(_isLoading.value);
    final selectedLang = languages.firstWhere(
      (lang) => lang.status == true,
      orElse: () => languages.firstWhere(
        (lang) => lang.status == false,
      ), // Fallback to language default code, when status true.
    );
    defLangKey.value = selectedLang.code;
    debugPrint('Default key ${defLangKey.value} ${selectedLang.code}');

    // Load selected language from cache
    final box = GetStorage();
    selectedLanguage.value = box.read(selectedLanguageKey) ?? defLangKey.value;
    debugPrint(box.read("SELECTED KEY $selectedLanguageKey"));
    DynamicLanguage.updateLanguageKey(selectedLanguage.value);
    _isLoading.value = false;
    DynamicLanguage.updateStatus(_isLoading.value);
    return selectedLang.code;
  }

  void changeLanguage(String newLanguage) {
    selectedLanguage.value = newLanguage;
    final box = GetStorage();
    box.write(selectedLanguageKey, newLanguage);
    DynamicLanguage.updateLanguageKey(newLanguage);
    update();
  }

  String getTranslation(String key) {
    final selectedLang = languages.firstWhere(
      (lang) => lang.code == selectedLanguage.value,
      orElse: () => languages.firstWhere(
        (lang) => lang.code == defLangKey.value,
      ),
    );

    final defaultLanguage = languages.firstWhere(
      (lang) => lang.code == 'en',
      orElse: () => languages.firstWhere(
        (lang) => lang.code == 'en',
      ),
    );

    String value;
    if (selectedLang.translateKeyValues[key] == '' ||
        selectedLang.translateKeyValues[key] == null) {
      value = defaultLanguage.translateKeyValues[key] ?? key;
    } else {
      value = selectedLang.translateKeyValues[key] ?? key;
    }

    return value;
  }

  /// Get text direction [ when selected language null return default direction ]
  TextDirection get languageDirection {
    _isLoading.value = true;
    DynamicLanguage.updateStatus(_isLoading.value);
    try {
      final selectedLang = languages.firstWhere(
        (lang) => lang.code == selectedLanguage.value,
        orElse: () => languages.firstWhere(
          (lang) => lang.code == defLangKey.value,
        ),
      );
      _isLoading.value = false;
      DynamicLanguage.updateStatus(_isLoading.value);

      // LocalStorage.saveRtl(type: selectedLang.dir == 'rtl' ? true : false);
      update();

      return selectedLang.dir == 'rtl' ? TextDirection.rtl : TextDirection.ltr;
    } catch (e) {
      return TextDirection.ltr; // Fallback to left-to-right (LTR)
    }
  }
}
