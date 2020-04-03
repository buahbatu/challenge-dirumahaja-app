import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/core/entity/entity_punishment.dart';
import 'package:dirumahaja/core/entity/entity_rule.dart';
import 'package:dirumahaja/feature/dashboard/dashboard_screen.dart';
import 'package:dirumahaja/feature/rulebook/rule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class PunishmentCheckScreen extends StatefulWidget {
  final Punishment punishment;

  PunishmentCheckScreen(
    this.punishment, {
    Key key,
  }) : super(key: key);

  @override
  _PunishmentCheckScreenState createState() => _PunishmentCheckScreenState();
}

class _PunishmentCheckScreenState extends State<PunishmentCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Hukuman',
          style: GoogleFonts.raleway(
            color: AppColor.titleColor.toHexColor(),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: getAction(context),
        iconTheme: IconThemeData(
          color: AppColor.titleColor.toHexColor(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  widget.punishment.imagePath.toSvgPicture(
                    width: 150,
                  ),
                  Container(height: 24),
                  Text(
                    widget.punishment.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.muli(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(height: 36),
                  createItem(
                    Rule('Jangan lupa gunakan hashtag #dirumahaja', false),
                  ),
                  createItem(
                    Rule(
                      'Setelah melaksanakan hukuman, status mu akan dimulai lagi dari 0',
                      false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          getButton(),
        ],
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

  Container getButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          'Sudah Dilaksanakan',
          style: GoogleFonts.muli(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        // color: HexColor('9CD147'),
        color: AppColor.buttonColor.toHexColor(),
        onPressed: resetStatus,
      ),
    );
  }

  void resetStatus() async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => DashboardScreen()),
      (r) => false,
    );
  }

  List<Widget> getAction(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: AppImages.helpSvg.toSvgPicture(
          color: AppColor.titleColor.toHexColor(),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => RuleScreen()),
          );
        },
      ),
    ];
  }
}
