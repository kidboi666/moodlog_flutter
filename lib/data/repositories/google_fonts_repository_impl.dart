import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:moodlog/data/data_source/remote/google_fonts_api_client.dart';
import 'package:moodlog/data/models/google_font_model.dart';
import 'package:moodlog/domain/entities/font/font_type.dart';
import 'package:moodlog/domain/repositories/google_fonts_repository.dart';

class GoogleFontsRepositoryImpl implements GoogleFontsRepository {
  final GoogleFontsApiClient? apiClient;
  final bool useApi;
  List<GoogleFontEntity>? _cachedFonts;

  GoogleFontsRepositoryImpl({
    this.apiClient,
    this.useApi = true,
  });

  Future<List<GoogleFontEntity>> _loadFontsFromApi() async {
    if (_cachedFonts != null) {
      return _cachedFonts!;
    }

    if (apiClient == null) {
      throw Exception('API client is not configured');
    }

    try {
      final fontModels = await apiClient!.getAllFonts();
      _cachedFonts = fontModels.map((model) => model.toEntity()).toList();
      return _cachedFonts!;
    } catch (e) {
      throw Exception('Failed to load fonts from API: $e');
    }
  }

  Future<List<GoogleFontEntity>> _loadFontsFromAsset() async {
    if (_cachedFonts != null) {
      return _cachedFonts!;
    }

    try {
      final jsonString =
          await rootBundle.loadString('assets/data/google_fonts.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedFonts = jsonList
          .map((json) => GoogleFontModel.fromJson(json).toEntity())
          .toList();
      return _cachedFonts!;
    } catch (e) {
      throw Exception('Failed to load Google Fonts from asset: $e');
    }
  }

  Future<List<GoogleFontEntity>> _loadFonts() async {
    if (useApi && apiClient != null) {
      try {
        return await _loadFontsFromApi();
      } catch (e) {
        return await _loadFontsFromAsset();
      }
    } else {
      return await _loadFontsFromAsset();
    }
  }

  @override
  Future<List<GoogleFontEntity>> getAllFonts() async {
    return await _loadFonts();
  }

  @override
  Future<List<GoogleFontEntity>> getFontsBySubset(String subset) async {
    final fonts = await _loadFonts();
    return fonts.where((font) => font.subsets.contains(subset)).toList();
  }

  @override
  Future<List<GoogleFontEntity>> searchFonts(String query) async {
    if (query.isEmpty) {
      return await getAllFonts();
    }

    final fonts = await _loadFonts();
    final lowerQuery = query.toLowerCase();
    return fonts
        .where((font) => font.family.toLowerCase().contains(lowerQuery))
        .toList();
  }

  @override
  Future<List<GoogleFontEntity>> getFontsByCategory(String category) async {
    final fonts = await _loadFonts();
    return fonts.where((font) => font.category == category).toList();
  }
}
