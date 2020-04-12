import 'dart:convert';

import 'package:dirumahaja/core/entity/entity_credit.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditBox extends StatefulWidget {
  const CreditBox({
    Key key,
  }) : super(key: key);

  @override
  _CreditBoxState createState() => _CreditBoxState();
}

class _CreditBoxState extends State<CreditBox> {
  List<Credit> credits = [];

  @override
  void initState() {
    super.initState();
    loadCredits();
  }

  void loadCredits() async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    final rawCredits = remoteConfig.getString('game_credit');
    final jsonCredits = jsonDecode(rawCredits);
    setState(() {
      credits = Credit.fromJsonList(jsonCredits);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 24,
          top: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Text(
                'Credits',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColor.titleColor.toHexColor(),
                ),
              ),
            ),
            Container(height: 18),
            ...credits.map((c) => createItem(c)).toList(),
          ],
        ),
      ),
    );
  }

  Widget createItem(Credit credit) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: RichText(
        text: TextSpan(
          text: '${credit.content} by ',
          children: [
            TextSpan(
              text: credit.creator,
              style: GoogleFonts.muli(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (credit.link.isNotEmpty) launch(credit.link);
                },
            )
          ],
          style: GoogleFonts.muli(color: Colors.black87),
        ),
      ),
    );
  }
}
