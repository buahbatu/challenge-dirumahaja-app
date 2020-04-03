import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/core/entity/entity_notif.dart';
import 'package:dirumahaja/feature/punishment/punishment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('4DA6EA'),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('4DA6EA'),
        title: Text(
          'Notifikasi',
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: resources.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (ctx, i) => createItem(resources[i]),
      ),
    );
  }

  Card createItem(Notif n) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                n.imagePath.toSvgPicture(width: 52),
                Container(width: 16),
                Expanded(
                  child: Text(
                    n.description,
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
          if (n.action.isNotEmpty)
            Material(
              color: AppColor.buttonColor.toHexColor(),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              child: InkWell(
                onTap: () => onActionClick(n.action),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    parseAction(n.action),
                    style: GoogleFonts.muli(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void onActionClick(String action) async {
    if (isPunishmentAction(action)) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => PunishmentScreen(),
      ));
    } else {
      launch(action);
    }
  }

  bool isPunishmentAction(String action) {
    return action == '/punishment';
  }

  String parseAction(String action) {
    if (isPunishmentAction(action)) {
      return 'Terima Hukuman';
    } else {
      return 'Lihat Detail';
    }
  }

  final resources = [
    Notif(
      AppImages.tearSvg,
      'Yah.. Nyawa Kamu Telah Habis, Ayo pilih hukuman dan coba lagi',
      '/punishment',
    ),
    Notif(
      AppImages.happySvg,
      'Yesss! Kamu menang Challenge melawan KaAlifYangSedih. Jangan lupa tagih hadiah mu',
      '',
    ),
  ];
}
