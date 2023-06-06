import 'dart:convert';
import 'package:polish_dictionary/data/repositories/dataRepository.dart';
import 'package:polish_dictionary/domain/models/WordItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository implements DataRepository {
  @override
  Future<void> saveData(List<WordItem> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonDataList =
        data.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList('wordList', jsonDataList);
  }

  @override
  Future<List<WordItem>> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonDataList = prefs.getStringList('wordList');
    if (jsonDataList != null) {
      List<WordItem> data = jsonDataList
          .map((jsonData) => WordItem.fromJson(jsonDecode(jsonData)))
          .toList();
      return data;
    }
    return [];
  }
}
