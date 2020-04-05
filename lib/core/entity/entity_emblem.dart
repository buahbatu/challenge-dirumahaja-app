class Emblem {
  final String id;
  final bool isActive;
  final String code;
  final String name;
  final String imgUrl;

  Emblem({
    this.id,
    this.isActive,
    this.code,
    this.name,
    this.imgUrl,
  });

  static Emblem fromMap(Map<String, dynamic> map) {
    return Emblem(
      id: map['id'],
      isActive: map['is_active'],
      code: map['code'],
      name: map['name'],
      imgUrl: map['img_url'],
    );
  }

  static List<Emblem> fromMapList(dynamic map) {
    final mapList = map as List;
    final emblems = mapList.map((m) {
      final json = m as Map<String, dynamic>;
      final emblem = Emblem.fromMap(json);
      return emblem;
    }).toList();

    return emblems;
  }
}
