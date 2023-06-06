class WordItem {
  final String sound;
  final String text;
  final String translate;
  bool favorite;

  WordItem({
    required this.sound,
    required this.text,
    required this.translate,
    this.favorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'sound': sound,
      'text': text,
      'translate': translate,
      'favorite': favorite,
    };
  }

  factory WordItem.fromJson(Map<String, dynamic> json) {
    return WordItem(
      sound: json['sound'],
      text: json['text'],
      translate: json['translate'],
      favorite: json['favorite'],
    );
  }

  @override
  String toString() {
    return 'WordItem(sound: $sound, text: $text, translate: $translate, favorite: $favorite)';
  }
}
