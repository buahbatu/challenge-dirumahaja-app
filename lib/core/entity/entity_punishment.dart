import 'package:dirumahaja/core/network/base_result.dart';

class Punishment extends Data {
  final String name;
  final String imgUrl;
  final String text;

  Punishment({
    this.name,
    this.imgUrl,
    this.text,
  });

  static Punishment fromMap(Map<String, dynamic> map) {
    return Punishment(
      name: map['map'],
      imgUrl: map['img_url'],
      text: map['text'],
    );
  }

  static List<Punishment> fromMapList(dynamic map) {
    final mapList = map as List;
    final notifs = mapList.map((m) {
      final json = m as Map<String, dynamic>;
      final notif = Punishment.fromMap(json);
      return notif;
    }).toList();

    return notifs;
  }
}
