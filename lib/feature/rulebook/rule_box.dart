import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dirumahaja/core/entity/entity_rule.dart';

class RuleBox extends StatefulWidget {
  final double height;
  const RuleBox({
    Key key,
    this.height = 420,
  }) : super(key: key);

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
    final rawActivity = remoteConfig.getString('game_rule');
    print(rawActivity);
    final jsonActivity = jsonDecode(rawActivity);
    setState(() {
      rules = Rule.fromJsonList(jsonActivity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        height: widget.height,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rules.map((r) => createItem(r)).toList(),
        ),
      ),
    );
  }

  Row createItem(Rule rule) {
    return Row(
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
    );
  }
}
