class Word {
  final int id;
  final String sound;
  final String categoryIcon;
  String word;
  final String translation;
  final String category;
  bool isFavorite;
  bool isPlaying;

  Word({
    required this.id,
    required this.sound,
    required this.categoryIcon,
    required this.word,
    required this.translation,
    required this.category,
    this.isFavorite = false,
    this.isPlaying = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'sound': sound,
      'word': word,
      'categoryIcon': categoryIcon,
      'category': category,
      'id': id,
      'isFavorite': isFavorite ? 1 : 0,
      'isPlaying': isPlaying ? 1 : 0,
      'translation': translation,
    };
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      sound: json['sound'],
      word: json['word'],
      categoryIcon: json['categoryIcon'],
      category: json['category'],
      id: json['id'],
      isFavorite: json['isFavorite'] == 1,
      isPlaying: json['isPlaying'] == 1,
      translation: json['translation'],
    );
  }
  @override
  String toString() {
    return 'Word{id: $id, sound: $sound, word: $word, categoryIcon: $categoryIcon, '
        'translation: $translation, category: $category, isFavorite: $isFavorite, '
        'isPlaying: $isPlaying}';
  }
}
