import 'package:polish_dictionary/domain/models/WordItem.dart';

List<Word> filterWordsByCategory(List<Word> words, String category) {
  return words.where((word) => word.category == category).toList();
}
