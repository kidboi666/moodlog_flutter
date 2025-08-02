import 'dart:convert';

import 'package:drift/drift.dart';

class StringListConverter extends TypeConverter<List<String>?, String?> {
  const StringListConverter();

  @override
  List<String>? fromSql(String? fromDb) {
    if (fromDb == null || fromDb.isEmpty) return null;

    try {
      final decoded = json.decode(fromDb) as List;
      return decoded.cast<String>();
    } catch (e) {
      return null;
    }
  }

  @override
  String? toSql(List<String>? value) {
    if (value == null || value.isEmpty) return null;
    return json.encode(value);
  }
}
