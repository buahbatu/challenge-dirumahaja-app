import 'dart:convert';
import 'package:dirumahaja/core/result/base_data.dart';
import 'package:dirumahaja/core/tools/data_parser_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  const AppPref();

  Future clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future saveData(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is Data) {
      try {
        await prefs.setString(key, jsonEncode(value.toMap()));
      } catch (e) {
        throw UnimplementedError('Data to Map failing in preference save');
      }
    } else {
      try {
        await prefs.setString(key, jsonEncode(value));
      } catch (e) {
        throw ArgumentError('value is instance without proper mapper');
      }
    }
  }

  Future<T> loadData<T>(String key, {T defaultValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) return defaultValue;

    if (T is bool) {
      return prefs.getBool(key) as T;
    } else if (T is double) {
      return prefs.getDouble(key) as T;
    } else if (T is int) {
      return prefs.getInt(key) as T;
    } else if (T is String) {
      return prefs.getString(key) as T;
    } else {
      try {
        final jsonMap = jsonDecode(prefs.getString(key));
        final hasDecoder = DataParserFactory.get().decodersMap.containsKey(T);
        final data = hasDecoder
            ? DataParserFactory.get().decode<T>(jsonMap)
            : jsonDecode(prefs.getString(key)) as T;
        return data;
      } catch (e) {
        throw UnimplementedError('ParserFactory didn\'t have parser of $T');
      }
    }
  }

  // instance
  static const AppPref _instance = const AppPref();
  static AppPref get() => _instance;
}
