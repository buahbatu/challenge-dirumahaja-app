import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/entity/entity_notif.dart';
import 'package:dirumahaja/feature/friend/share_screen.dart';
import 'package:dirumahaja/feature/punishment/punishment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  final String username;
  final String imagePath;
  final String downloadLink;
  final List<Notif> notifs;

  const NotificationScreen(
    this.notifs,
    this.username,
    this.imagePath,
    this.downloadLink, {
    Key key,
  }) : super(key: key);

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
      body: Stack(
        children: <Widget>[
          if (widget.notifs.isEmpty) getNote(),
          if (widget.notifs.isNotEmpty) getList(),
        ],
      ),
    );
  }

  ListView getList() {
    return ListView.builder(
      itemCount: widget.notifs.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (ctx, i) => createItem(widget.notifs[i]),
    );
  }

  Container getNote() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Belum ada notif. Sepi ya :’(',
            style: GoogleFonts.muli(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 21,
            ),
          ),
          Container(height: 8),
          Text(
            'Coba ajak teman-teman untuk mulai bergabung',
            style: GoogleFonts.muli(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Container(height: 21),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: Colors.white),
            ),
            child: Text(
              'Ajak Teman mu sekarang!',
              style: GoogleFonts.muli(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              print('asd');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ShareScreen(
                  widget.username,
                  widget.imagePath,
                  widget.downloadLink,
                ),
              ));
            },
          )
        ],
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
}
