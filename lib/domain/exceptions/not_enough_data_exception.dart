class NotEnoughDataException implements Exception {
  final String message;

  NotEnoughDataException(this.message);

  @override
  String toString() => message;
}
