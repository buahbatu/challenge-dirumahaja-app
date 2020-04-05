import 'package:dirumahaja/core/network/base_result.dart';

class CheckIn extends Data {
  final bool isValid;

  CheckIn({this.isValid});

  static CheckIn fromMap(Map<String, dynamic> map) {
    return CheckIn(isValid: map['isValid']);
  }
}
