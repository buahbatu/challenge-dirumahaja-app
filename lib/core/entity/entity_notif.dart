class Notif {
  final String imagePath;
  final String description;
  final String action;

  Notif({
    this.imagePath,
    this.description,
    this.action,
  });

  static Notif fromMap(Map<String, dynamic> map) {
    return Notif(
      action: map['action'],
      description: map['text'],
      imagePath: map['img_url'],
    );
  }

  static List<Notif> fromMapList(dynamic map) {
    final mapList = map as List;
    final notifs = mapList.map((m) {
      final json = m as Map<String, dynamic>;
      final notif = Notif.fromMap(json);
      return notif;
    }).toList();

    return notifs;
  }
}
