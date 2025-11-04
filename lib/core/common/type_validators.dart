import 'package:intl/intl.dart';
import 'dart:convert';

/// Validators that be used to validate that the value is coming is true and -
/// the same value type we waiting for
/// The main use in Model classes to validate types of data which are coming -
/// from API

T? numV<T extends num>(Object? value) {
  if (value == null) return null;
  if (value is num) {
    return _getNum<T>(value);
  }
  if (value is String) {
    final parsed = num.tryParse(value);
    if (parsed != null) {
      return _getNum<T>(parsed);
    }
    return null;
  }

  return null;
}

T? _getNum<T extends num>(Object? value) {
  if (value == null) return null;

  /// If value is from type T(int/double)
  if (value is T) return value;

  /// If value is int and T is double
  if (value is int && T == double) return value.toDouble() as T;

  /// If value is double and T is int
  if (value is double && T == int) return value.toInt() as T;

  return null;
}

String stringV(Object? value) {
  if (value == null) return '';
  return value.toString().trim();
}

bool boolV(Object? value) {
  if (value == null) return false;
  if (value is String) {
    if (value.toLowerCase() == "true" || value.toLowerCase() == "1") {
      return true;
    }
  }
  if (value is num) {
    if (value.toString() == "1") return true;
  }
  if (value is bool) return value;
  return false;
}

// DateTime? dateTimeV(String? dateTime) {
//   if (dateTime == null) return null;
//   return DateTime.tryParse(dateTime)?.toUtc().toLocal() ??
//       DateFormat("yyyy-MM-dd").parse(dateTime);
// }
DateTime? dateTimeV(String? dateTime) {
  if (dateTime == null) return null;

  DateTime? parsedDate = DateTime.tryParse(dateTime);
  if (parsedDate == null) {
    try {
      parsedDate = DateFormat("MM-dd-yyyy hh:mm:ss a").parse(dateTime);
    } catch (_) {
      try {
        parsedDate = DateFormat("yyyy-MM-dd hh:mm:ss a").parse(dateTime);
      } catch (_) {
        // Add more formats here if needed
      }
    }
  }

  return parsedDate?.toUtc().toLocal();
}

List<T> listV<T>(List<T?>? list) {
  if (list == null) return [];

  return list.whereType<T>().toList();
}

/// Safely parse a dynamic value into a Map<String, dynamic>.
/// - Accepts Map, Map<dynamic, dynamic>, or JSON-encoded String
/// - Returns null if the value cannot be parsed into a map
Map<String, dynamic>? mapV(Object? value) {
  if (value == null) return null;
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return value.map((key, val) => MapEntry(key.toString(), val));
  }
  if (value is String && value.isNotEmpty) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map) {
        return decoded.map((key, val) => MapEntry(key.toString(), val));
      }
    } catch (_) {
      // Not a JSON map string; ignore
    }
  }
  return null;
}
