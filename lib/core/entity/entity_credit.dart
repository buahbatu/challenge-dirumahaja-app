class Credit {
  final String content;
  final String creator;
  final String link;

  Credit(this.content, this.creator, this.link);

  static List<Credit> fromJsonList(dynamic json) {
    final jsonList = (json as List);
    return jsonList.map((i) {
      final json = i as Map<String, dynamic>;
      return Credit(json['content'], json['creator'], json['link']);
    }).toList();
  }
}
