class Friend {
  final String username;
  final String locationName;
  final String emblemImgUrl;
  final String emblemName;
  final int sessionDay;
  final int sessionHealth;
  final int sessionStatus;

  Friend({
    this.username,
    this.locationName,
    this.emblemImgUrl,
    this.emblemName,
    this.sessionDay,
    this.sessionHealth,
    this.sessionStatus,
  });

  static Friend fromMap(Map<String, dynamic> map) {
    return Friend(
      username: map['username'],
      locationName: map['locationName'],
      emblemImgUrl: map['emblemImgUrl'],
      emblemName: map['emblemName'],
      sessionDay: map['sessionDay'],
      sessionHealth: map['sessionHealth'],
      sessionStatus: map['sessionStatus'],
    );
  }

  static List<Friend> fromMapList(dynamic map) {
    final mapList = map as List;
    final friends = mapList.map((m) {
      final json = m as Map<String, dynamic>;
      final friend = Friend.fromMap(json);
      return friend;
    }).toList();

    return friends;
  }
}
