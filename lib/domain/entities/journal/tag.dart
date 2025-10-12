class Tag {
  final int id;
  final String name;
  final String? color;
  final DateTime createdAt;

  Tag({
    required this.id,
    required this.name,
    this.color,
    required this.createdAt,
  });
}
