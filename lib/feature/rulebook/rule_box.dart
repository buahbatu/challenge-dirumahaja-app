import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dirumahaja/core/entity/entity_rule.dart';

class RuleBox extends StatefulWidget {
  @override
  _RuleBoxState createState() => _RuleBoxState();
}

class _RuleBoxState extends State<RuleBox> {
  List<Rule> rules = [];

  @override
  void initState() {
    super.initState();
    loadRules();
  }

  void loadRules() async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    final rawRules = remoteConfig.getString('game_rule');
    final jsonRules = jsonDecode(rawRules);
    setState(() {
      rules = Rule.fromJsonList(jsonRules);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rules.map((r) => createItem(r)).toList(),
        ),
      ),
    );
  }

  Widget createItem(Rule rule) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor('F9C126'),
            ),
          ),
          Expanded(
            child: Text(
              rule.content,
              style: GoogleFonts.muli(
                color: Colors.black87,
                fontWeight: rule.isBold ? FontWeight.w800 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
