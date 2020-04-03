import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/core/entity/entity_punishment.dart';
import 'package:dirumahaja/feature/punishment/punishment_check_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class PunishmentScreen extends StatelessWidget {
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
              itemCount: resources.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (ctx, i) => createItem(resources[i], context),
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
          ],
        ),
      ),
    );
  }

  void goToCheck(Punishment n, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => PunishmentCheckScreen(n)),
    );
    ;
  }

  final resources = [
    Punishment(AppImages.tearSvg, 'Jawab 1 pertanyaan truth dari penantang mu'),
    Punishment(
      AppImages.happySvg,
      'Post foto selfie memalukan di IG kamu dan katakan kamu kalah tantangan',
    ),
    Punishment(
      AppImages.happySvg,
      'Post video pengakuan di IG kamu dan katakan kamu kalah tantangan',
    ),
    Punishment(AppImages.happySvg, 'Lakukan 1 aksi dare dari penantang mu'),
    Punishment(
      AppImages.happySvg,
      'Kirim donasi mengenai covid19 dan post buktinya di socmed kamu',
    ),
    Punishment(
      AppImages.happySvg,
      'Kirim makanan untuk penantang mu',
    ),
    Punishment(
      AppImages.happySvg,
      'Kirim makanan untuk penantang mu',
    ),
    Punishment(
      AppImages.happySvg,
      'Kirim makanan untuk penantang mu',
    ),
  ];
}
