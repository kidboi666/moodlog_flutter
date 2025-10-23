class Activity {
  final int id;
  final String name;
  final String? color;
  final DateTime createdAt;

  Activity({
    required this.id,
    required this.name,
    this.color,
    required this.createdAt,
  });
}
