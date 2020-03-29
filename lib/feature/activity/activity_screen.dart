import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/core/result/entity/entity_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('4DA6EA'),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('4DA6EA'),
        title: Text(
          'Mari Produktif',
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: resources.map((r) => createItem(r)).toList(),
      ),
    );
  }

  Card createItem(Activity a) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => launch(a.resPath),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            a.imagePath.toSvgPicture(),
            Text(
              a.title,
              style: GoogleFonts.muli(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final resources = [
    Activity(
      AppImages.learnCodeSvg,
      'Belajar Design',
      'https://dirumahaja.xyz/belajar-ux-ui-design/',
    ),
    Activity(
      AppImages.readBookSvg,
      'Baca Buku',
      'https://dirumahaja.xyz/buku-bacaan/',
    ),
    Activity(
      AppImages.videoPodcastSvg,
      'Video & Podcast',
      'https://dirumahaja.xyz/video-podcast/',
    ),
    Activity(
      AppImages.cariCuanSvg,
      'Cari Cuan',
      'https://dirumahaja.xyz/freelance-tools/',
    ),
    Activity(
      AppImages.shoppingSvg,
      'Belanja Diskon',
      'https://m.bukalapak.com/promo-campaign/asikdirumah',
    ),
    Activity(
      AppImages.nontonKonserSvg,
      'Nonton Konser',
      'www.digitalconcerthall.com',
    ),
    Activity(
      AppImages.museumVitualSvg,
      'Tur Virtual',
      'https://artsandculture.google.com/',
    ),
    Activity(
      AppImages.donasiSvg,
      'Donasi Kebaikan',
      'https://m.tokopedia.com/discovery/salam-donasicovid19',
    ),
    Activity(
      AppImages.learnCodeSvg,
      'Belajar Koding',
      'https://www.codecademy.com/',
    ),
    Activity(
      AppImages.kajianSvg,
      'Denger Kajian',
      'https://m.youtube.com/channel/UCVes0G5DqPa3ZHPL4W2OrhA',
    ),
  ];
}
