import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/core/result/entity/entity_friend.dart';
import 'package:dirumahaja/core/result/entity/entity_notif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
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
            if (n.action.isNotEmpty) Container(height: 12),
            if (n.action.isNotEmpty)
              InkWell(
                onTap: () {},
                child: Text(
                  parseAction(n.action),
                  style: GoogleFonts.muli(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColor.buttonColor.toHexColor(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String parseAction(String action) {
    if (action == '/punishment') {
      return 'Terima Hukuman';
    } else {
      return action;
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
