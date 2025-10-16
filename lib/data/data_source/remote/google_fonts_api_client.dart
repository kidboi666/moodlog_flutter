import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moodlog/data/models/google_font_model.dart';

class GoogleFontsApiClient {
  final String? apiKey;
  final http.Client client;

  static const String _baseUrl =
      'https://www.googleapis.com/webfonts/v1/webfonts';
  static const String _publicMetadataUrl =
      'https://fonts.google.com/metadata/fonts';

  GoogleFontsApiClient({
    this.apiKey,
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<List<GoogleFontModel>> getAllFontsFromPublicApi() async {
    try {
      final uri = Uri.parse(_publicMetadataUrl);
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final startIndex = jsonString.indexOf('{');
        final cleanJson = jsonString.substring(startIndex);
        final jsonData = json.decode(cleanJson);
        final familyList = jsonData['familyMetadataList'] as List;

        return familyList
            .asMap()
            .entries
            .map((entry) {
              final index = entry.key;
              final item = entry.value;
              return GoogleFontModel(
                family: item['family'] as String,
                category: item['category'] as String,
                subsets: List<String>.from(item['subsets'] as List),
                popularity: index + 1,
              );
            })
            .toList();
      } else {
        throw Exception(
          'Failed to load fonts from public API: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to fetch fonts from public metadata: $e');
    }
  }

  Future<List<GoogleFontModel>> getAllFontsFromDeveloperApi({
    String? sort = 'popularity',
  }) async {
    if (apiKey == null || apiKey!.isEmpty || apiKey == 'YOUR_API_KEY_HERE') {
      throw Exception('API key is not configured');
    }

    try {
      final uri = Uri.parse('$_baseUrl?key=$apiKey&sort=$sort');
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final items = jsonData['items'] as List;

        return items
            .asMap()
            .entries
            .map((entry) {
              final index = entry.key;
              final item = entry.value;
              return GoogleFontModel(
                family: item['family'] as String,
                category: item['category'] as String,
                subsets: List<String>.from(item['subsets'] as List),
                popularity: index + 1,
              );
            })
            .toList();
      } else {
        throw Exception(
          'Failed to load fonts: ${response.statusCode} ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Failed to fetch Google Fonts: $e');
    }
  }

  Future<List<GoogleFontModel>> getAllFonts({
    String? sort = 'popularity',
  }) async {
    try {
      return await getAllFontsFromPublicApi();
    } catch (e) {
      try {
        return await getAllFontsFromDeveloperApi(sort: sort);
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<List<GoogleFontModel>> getFontsBySubset(String subset) async {
    final allFonts = await getAllFonts();
    return allFonts.where((font) => font.subsets.contains(subset)).toList();
  }

  void dispose() {
    client.close();
  }
}
