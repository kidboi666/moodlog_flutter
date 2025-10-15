// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_font_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleFontModel _$GoogleFontModelFromJson(Map<String, dynamic> json) =>
    GoogleFontModel(
      family: json['family'] as String,
      category: json['category'] as String,
      subsets: (json['subsets'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      popularity: (json['popularity'] as num).toInt(),
    );

Map<String, dynamic> _$GoogleFontModelToJson(GoogleFontModel instance) =>
    <String, dynamic>{
      'family': instance.family,
      'category': instance.category,
      'subsets': instance.subsets,
      'popularity': instance.popularity,
    };
