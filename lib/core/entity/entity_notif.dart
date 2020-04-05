class Notif {
  final String text;
  final String icon;
  final String button;
  final String action;

  Notif({
    this.text,
    this.icon,
    this.button,
    this.action,
  });

  static Notif fromMap(Map<String, dynamic> map) {
    return Notif(
      text: map['text'],
      icon: map['icon'],
      button: map['button'],
      action: map['action'],
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
