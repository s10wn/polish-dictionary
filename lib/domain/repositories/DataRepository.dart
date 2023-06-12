import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:polish_dictionary/data/repositories/SharedPreferencesRepository.dart';
import 'package:polish_dictionary/domain/models/WordItem.dart';

class SharedPreferencesRepository implements DataRepository {
  late SharedPreferences _sharedPreferences;
  static const String dataAddedKey = 'dataAdded';
  SharedPreferencesRepository() {
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveData(List<Word> data) async {
    await _initSharedPreferences(); // Инициализируем SharedPreferences перед использованием
    List<Map<String, dynamic>> wordListData =
        data.map((word) => word.toJson()).toList();
    String encodedData = jsonEncode(wordListData);
    await _sharedPreferences.setString('wordList', encodedData);
  }

  @override
  Future<List<Word>> loadData() async {
    await _initSharedPreferences(); // Инициализируем SharedPreferences перед использованием
    String? jsonData = _sharedPreferences.getString('wordList');
    if (jsonData != null) {
      List<dynamic> decodedData = jsonDecode(jsonData);
      List<Word> data = decodedData.map((item) => Word.fromJson(item)).toList();
      data.sort((a, b) => a.category.compareTo(b.category));
      return data;
    }
    return [];
  }

  @override
  Future<void> addWord(String sound, String word, String categoryIcon,
      String category, int id, String translation) async {
    List<Word> wordList = await loadData();

    // Создаем новое слово
    Word newWord = Word(
      sound: sound,
      word: word,
      categoryIcon: categoryIcon,
      category: category,
      id: id,
      isFavorite: false,
      isPlaying: false,
      translation: translation,
    );

    bool wordExists = wordList.any((word) => word.word == newWord.word);

    if (!wordExists) {
      wordList.add(newWord);
      await saveData(wordList);
    } else {
      print('Слово уже существует в списке');
    }
  }

  @override
  Future<void> updateFavoriteState(int id, bool isFavorite) async {
    List<Word> wordList = await loadData();

    // Находим индекс слова в списке по полю id
    int wordIndex = wordList.indexWhere((w) => w.id == id);

    if (wordIndex != -1) {
      // Обновляем состояние isFavorite
      wordList[wordIndex].isFavorite = isFavorite;
      print(wordList[wordIndex].isFavorite);
      // Сохраняем изменения в SharedPreferences
      await saveData(wordList);
    }
  }

  @override
  Future<void> updatePlayingState(int id, bool isPlaying) async {
    List<Word> wordList = await loadData();

    int wordIndex = wordList.indexWhere((w) => w.id == id);

    if (wordIndex != -1) {
      // Обновляем состояние isPlaying
      wordList[wordIndex].isPlaying = isPlaying;

      // Сохраняем изменения в SharedPreferences
      await saveData(wordList);
    }
  }

  @override
  Future<List<Word>> getFavoriteWords() async {
    List<Word> wordList = await loadData();
    List<Word> favoriteWords =
        wordList.where((word) => word.isFavorite).toList();
    return favoriteWords;
  }

  @override
  Future<bool> isDataAdded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(dataAddedKey) ?? false;
  }

  @override
  Future<void> setDataAdded(bool isAdded) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(dataAddedKey, isAdded);
  }
}
