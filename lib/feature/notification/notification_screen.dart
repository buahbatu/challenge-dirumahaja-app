import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/entity/entity_notif.dart';
import 'package:dirumahaja/feature/punishment/punishment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  final List<Notif> notifs;

  const NotificationScreen(this.notifs, {Key key}) : super(key: key);

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
        itemCount: widget.notifs.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (ctx, i) => createItem(widget.notifs[i]),
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
                CachedNetworkImage(
                  imageUrl: n.icon,
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

  // final resources = [
  //   Notif(
  //     icon: AppImages.tearSvg,
  //     text: 'Yah.. Nyawa Kamu Telah Habis, Ayo pilih hukuman dan coba lagi',
  //     action: '/punishment',
  //   ),
  //   Notif(
  //     icon: AppImages.happySvg,
  //     text:
  //         'Yesss! Kamu menang Challenge melawan KaAlifYangSedih. Jangan lupa tagih hadiah mu',
  //     action: '',
  //   ),
  // ];
}