import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dirumahaja/core/entity/entity_punishment.dart';
import 'package:dirumahaja/core/network/api.dart';
import 'package:dirumahaja/feature/punishment/punishment_check_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class PunishmentScreen extends StatefulWidget {
  @override
  _PunishmentScreenState createState() => _PunishmentScreenState();
}

class _PunishmentScreenState extends State<PunishmentScreen> {
  List<Punishment> punishmentList = [];
  @override
  void initState() {
    super.initState();
    loadPunishment();
  }

  void loadPunishment() async {
    final user = await FirebaseAuth.instance.currentUser();

    final request = await Api().getDio().get<Map<String, dynamic>>(
          '/session/punishments',
          options: Options(headers: {'uid': user.uid}),
        );

    final punishments = Punishment.fromMapList(request.data['data']);
    setState(() {
      punishmentList = punishments;
    });
  }

  void logSelectedPunishment(Punishment n) async {
    final user = await FirebaseAuth.instance.currentUser();

    final punishment = await Api().post(
      path: '/session/punishments',
      dataParser: null,
      headers: {'uid': user.uid},
      body: {"punishment": n.text},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('504658'),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('504658'),
        title: Text(
          'Terima Hukuman',
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Text(
              'Pilih satu untuk melanjutkan',
              style: GoogleFonts.muli(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (ctx, i) => Container(height: 12),
              itemCount: punishmentList.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (ctx, i) => createItem(punishmentList[i], context),
            ),
          ),
        ],
      ),
    );
  }

  Widget createItem(Punishment n, BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      elevation: 2,
      child: InkWell(
        onTap: () => goToCheck(n, context),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: n.imgUrl,
                    width: 52,
                    fit: BoxFit.fitWidth,
                  ),
                  Container(width: 16),
                  Expanded(
                    child: Text(
                      n.text,
                      style: GoogleFonts.muli(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToCheck(Punishment n, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => PunishmentCheckScreen(n)),
    );
  }
}
