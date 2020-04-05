import 'package:dirumahaja/core/network/base_result.dart';

class Stat extends Data {
  final int confirmed;
  final int deceased;
  final int negative;
  final int recovered;
  final int suspected;

  Stat({
    this.confirmed,
    this.deceased,
    this.negative,
    this.recovered,
    this.suspected,
  });

  static Stat fromMap(Map<String, dynamic> map) {
    return Stat(
      confirmed: map['confirmed'],
      deceased: map['deceased'],
      negative: map['negative'],
      recovered: map['recovered'],
      suspected: map['suspected'],
    );
  }
}
