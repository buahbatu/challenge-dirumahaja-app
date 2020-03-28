import 'package:dirumahaja/core/res/app_color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class RuleBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(height: 64),
          Text(
            'Aturan Main',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: AppColor.titleColor.toHexColor(),
            ),
          ),
          Container(height: 32),
          getRuleBox(),
        ],
      ),
    );
  }

  List<String> getRules() => [
        '1. Pastikan Koneksi GPS Tersedia',
        '2. Pastikan Koneksi Internet Lancar',
        '3. Jangan keluar dari lingkungan rumah (500 m dari titik rumah)',
        '4. Buat persiapan sebelum memulai tantangan (makanan, minum, obat, dll)',
        '5. Kamu akan memulai dengan 1 energi ',
        '6. Energi mu akan berkurang jika tidak memenuhi poin 1,2,3',
        '7. Energi mu bisa bertambah jika teman mu kehabisan Energi',
        '8. Jika kamu kehabisan Energi, kamu harus menjalankan hukuman dan akan memulai hitungan hari dari 0',
        ' ',
      ];

  Widget getRuleBox() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 46),
      child: Container(
        height: 420,
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...getRules()
                .map((f) => Text(f,
                    style: GoogleFonts.muli(
                      color: HexColor('666666'),
                    )))
                .toList(),
            getPrivacyRow()
          ],
        ),
      ),
    );
  }

  RichText getPrivacyRow() {
    return RichText(
      text: TextSpan(
        text: 'baca  ',
        style: GoogleFonts.muli(color: HexColor('666666')),
        children: [
          getPrivacyPolicy(),
          TextSpan(
            text: ' Lebih Lanjut',
            style: GoogleFonts.muli(color: HexColor('666666')),
          ),
        ],
      ),
    );
  }

  TextSpan getPrivacyPolicy() {
    return TextSpan(
      text: 'privacy policy',
      style: GoogleFonts.muli(color: HexColor('E96666')),
      recognizer: new TapGestureRecognizer()
        ..onTap = () {
          print('click');
          launch(
              'https://www.notion.so/buahbatu/Privacy-Policy-eabfe866c14a43ea895d89d608843bfb');
        },
    );
  }
}
