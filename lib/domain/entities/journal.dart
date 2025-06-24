class Journal {
  final int id;
  final String? content;
  final String moodName;
  final String? imageUri;
  final DateTime createdAt;

  Journal({
    required this.id,
    required this.content,
    required this.moodName,
    required this.imageUri,
    required this.createdAt,
  });
}
