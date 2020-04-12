import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class Information {
  final Gradient gradient;
  final String title;
  final String subtitle;
  final String action;
  final String link;

  Information(this.gradient, this.title, this.subtitle, this.action, this.link);

  static Gradient getCardGradient(String start, String end) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
      colors: [HexColor(start), HexColor(end)],
    );
  }

  static List<Information> fromJsonList(dynamic json) {
    final jsonList = (json as List);
    return jsonList.map((i) {
      final json = i as Map<String, dynamic>;
      return Information(
        getCardGradient(json['start_color'], json['end_color']),
        json['title'],
        json['subtitle'],
        json['action_text'],
        json['link'],
      );
    }).toList();
  }
}
