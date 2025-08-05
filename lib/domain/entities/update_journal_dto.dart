class UpdateJournalDto {
  final int id;
  final String? content;
  final List<String>? imageUri;
  final String? aiResponse;
  final double? latitude;
  final double? longitude;
  final String? address;

  const UpdateJournalDto({
    required this.id,
    this.content,
    this.imageUri,
    this.aiResponse,
    this.latitude,
    this.longitude,
    this.address,
  });
}