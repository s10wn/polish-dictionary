import 'package:polish_dictionary/domain/models/WordItem.dart';

abstract class DataRepository {
  Future<void> saveData(List<WordItem> data);
  Future<List<WordItem>> loadData();
}
