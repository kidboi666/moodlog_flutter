extension StringExtension on String {
  bool isNetworkImage() {
    return startsWith('http://') || startsWith('https://');
  }
}
