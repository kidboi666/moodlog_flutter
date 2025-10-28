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

class JsonMapConverter extends TypeConverter<Map<String, dynamic>, String> {
  const JsonMapConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) {
    try {
      final decoded = json.decode(fromDb);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  @override
  String toSql(Map<String, dynamic> value) {
    return json.encode(value);
  }
}
