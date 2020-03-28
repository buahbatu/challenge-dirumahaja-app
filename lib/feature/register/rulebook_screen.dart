import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/feature/rulebook/rule_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RuleBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            Container(height: 64),
            Text(
              'Aturan Main',
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColor.titleColor.toHexColor(),
              ),
            ),
            Container(height: 8),
            Text(
              'Baca dulu biar paham, malu bertanya sesat di jalan',
              style: GoogleFonts.muli(
                fontSize: 12,
                color: AppColor.bodyColor.toHexColor(),
              ),
            ),
            Container(height: 32),
            RuleBox(),
          ],
        ),
      ),
    );
  }
}
