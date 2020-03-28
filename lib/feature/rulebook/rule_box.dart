import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dirumahaja/core/result/entity/entity_rule.dart';

class RuleBox extends StatelessWidget {
  final double height;
  const RuleBox({
    Key key,
    this.height = 400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        height: height,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: getRules().map((r) => createItem(r)).toList(),
        ),
      ),
    );
  }

  List<Rule> getRules() {
    return [
      Rule('Pastikan Koneksi GPS Tersedia', true),
      Rule('Pastikan Koneksi Internet Lancar', true),
      Rule(
        'Jangan keluar dari lingkungan rumah \n(500 m dari titik rumah)',
        true,
      ),
      Rule(
        'Buat persiapan sebelum memulai tantangan (makanan, minum, obat, dll)',
        false,
      ),
      Rule(
        'Kamu akan memulai dengan 1 energi ',
        false,
      ),
      Rule(
        'Energi mu akan berkurang jika tidak memenuhi poin 1,2,3',
        false,
      ),
      Rule(
        'Energi mu bisa bertambah jika teman mu kehabisan Energi',
        false,
      ),
      Rule(
        'Jika kamu kehabisan energi, kamu harus menjalankan hukuman dan akan memulai hitungan hari dari 0',
        false,
      ),
    ];
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
}
