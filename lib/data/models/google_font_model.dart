import 'package:json_annotation/json_annotation.dart';
import 'package:moodlog/domain/entities/font/font_type.dart';

part 'google_font_model.g.dart';

@JsonSerializable()
class GoogleFontModel {
  final String family;
  final String category;
  final List<String> subsets;
  final int popularity;

  GoogleFontModel({
    required this.family,
    required this.category,
    required this.subsets,
    required this.popularity,
  });

  factory GoogleFontModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleFontModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleFontModelToJson(this);

  GoogleFontEntity toEntity() {
    return GoogleFontEntity(
      family: family,
      category: category,
      subsets: subsets,
      popularity: popularity,
    );
  }
}
