class Journal {
  final int id;
  final DateTime createdAt;
  final String content;
  final List<String>? imageUri;
  final double? latitude;
  final double? longitude;
  final String? address;
  final double? temperature;
  final String? weatherIcon;
  final String? weatherDescription;

  Journal({
    required this.id,
    required this.createdAt,
    required this.content,
    this.imageUri,
    this.latitude,
    this.longitude,
    this.address,
    this.temperature,
    this.weatherIcon,
    this.weatherDescription,
  });
}
