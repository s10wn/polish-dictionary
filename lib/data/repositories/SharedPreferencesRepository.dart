import 'package:polish_dictionary/domain/models/WordItem.dart';

abstract class DataRepository {
  Future<void> saveData(List<Word> data);
  Future<List<Word>> loadData();
  Future<void> addWord(
      String sound, String word, String category, int id, String translation);
  Future<void> updateFavoriteState(int id, bool isFavorite);
  Future<void> updatePlayingState(int id, bool isPlaying);
  Future<List<Word>> getFavoriteWords();
}
