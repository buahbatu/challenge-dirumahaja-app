class Rule {
  final String content;
  final bool isBold;

  Rule(this.content, this.isBold);

  static List<Rule> fromJsonList(dynamic json) {
    final jsonList = (json as List);
    return jsonList.map((i) {
      final json = i as Map<String, dynamic>;
      return Rule(json['content'], json['is_bold']);
    }).toList();
  }
}
