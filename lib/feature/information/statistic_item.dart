import 'package:dirumahaja/core/entity/entity_stat.dart';
import 'package:dirumahaja/core/network/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticItem extends StatefulWidget {
  const StatisticItem({
    Key key,
  }) : super(key: key);

  @override
  _StatisticItemState createState() => _StatisticItemState();
}

class _StatisticItemState extends State<StatisticItem> {
  Stat stat;

  @override
  void initState() {
    super.initState();
    loadStat();
  }

  void loadStat() async {
    final user = await FirebaseAuth.instance.currentUser();
    final request = await Api().get<Stat>(
      path: '/profile/covid',
      dataParser: Stat.fromMap,
      headers: {'uid': user.uid},
    );

    setState(() {
      stat = request.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: HexColor('4BA4E8'),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: getContent(stat?.confirmed ?? 0, 'Postif Corona'),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: HexColor('8EC13F')),
              child: getContent(stat?.recovered ?? 0, 'Sembuh'),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: HexColor('FF5C76'),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: getContent(stat?.deceased ?? 0, 'Meninggal'),
            ),
          ),
        ],
      ),
    );
  }

  Column getContent(int count, String title) {
    return Column(
      children: <Widget>[
        Text(
          count.toString(),
          style: GoogleFonts.muli(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.muli(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
