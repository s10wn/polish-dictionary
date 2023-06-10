class Word {
  int id;
  String sound;
  String word;
  String translation;
  String category;
  bool isFavorite;
  bool isPlaying;

  Word({
    required this.id,
    required this.sound,
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
      'category': category,
      'id': id,
      'isFavorite': isFavorite,
      'isPlaying': isPlaying,
      'translation': translation,
    };
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      sound: json['sound'],
      word: json['word'],
      category: json['category'],
      id: json['id'],
      isFavorite: json['isFavorite'],
      isPlaying: json['isPlaying'],
      translation: json['translation'],
    );
  }
}
