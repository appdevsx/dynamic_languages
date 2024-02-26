import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/model.dart';

import 'dart:developer' as log;

class LanguageService {
  Future<List<Language>> fetchLanguages(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> languageDataList = data["data"]["languages"];
      final List<Language> languages =
          languageDataList.map((json) => Language.fromJson(json)).toList();
      log.log('Successfully get languages');
      return languages;
    } else {
      log.log('Failed to load language data');
      throw Exception('Failed to load language data');
    }
  }
}
