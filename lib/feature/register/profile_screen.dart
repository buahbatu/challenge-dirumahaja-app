import 'package:dirumahaja/core/network/api.dart';
import 'package:dirumahaja/core/network/base_result.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/tools/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileExist extends Data {
  final bool isExist;

  ProfileExist(this.isExist);

  static ProfileExist dataParser(Map<String, dynamic> json) {
    return ProfileExist(json[KEY_IS_EXIST]);
  }

  ProfileExist copyWith({String isExist}) {
    return ProfileExist(isExist != null ? isExist : this.isExist);
  }

  static const KEY_IS_EXIST = 'is_exist';

  Map<String, dynamic> toMap() {
    return {KEY_IS_EXIST: isExist};
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 52),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 64),
            getTitle(),
            getFormBox(),
            Container(height: 64),
          ],
        ),
      ),
    );
  }

  bool isUsernameExist = false;

  final _debouncer = Debouncer(milliseconds: 1000);

  void onUsernameChange(String name) async {
    final result = await Api().post<ProfileExist>(
      path: '/auth/check',
      body: {"username": name},
      dataParser: ProfileExist.dataParser,
    );

    setState(() {
      isUsernameExist = result?.data?.isExist ?? false;
    });
  }

  Widget getTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Kenalan Dulu Dong',
            style: GoogleFonts.raleway(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColor.titleColor.toHexColor(),
            ),
          ),
          Container(height: 8),
          Text(
            'Tak kenal maka tak sayang, ayo kenalan dulu',
            style: GoogleFonts.muli(
              fontSize: 12,
              color: AppColor.bodyColor.toHexColor(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFormBox() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Username',
              style: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColor.titleColor.toHexColor(),
              ),
            ),
            Container(height: 8),
            TextField(
              style: GoogleFonts.muli(),
              onChanged: (str) => _debouncer.run(() => onUsernameChange(str)),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                errorText: isUsernameExist ? 'username telah digunakan' : null,
                hintText: 'Isi username (IG / twitter) mu disini ...',
                filled: true,
                fillColor: AppColor.greyBgColor.toHexColor(),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8),
                  ),
                  borderSide: new BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Container(height: 16),
            ...getAgeSections(),
            Container(height: 16),
            getGenderRow(),
          ],
        ),
      ),
    );
  }

  List<Widget> getAgeSections() {
    return [
      Text(
        'Umur',
        style: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: AppColor.titleColor.toHexColor(),
        ),
      ),
      Container(height: 8),
      Row(
        children: <Widget>[
          Container(
            child: TextField(
              style: GoogleFonts.muli(),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                hintText: '22',
                filled: true,
                fillColor: AppColor.greyBgColor.toHexColor(),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8),
                  ),
                  borderSide: new BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            width: 90,
          ),
          Container(width: 8),
          Text(
            'tahun',
            style: GoogleFonts.muli(
              fontSize: 16,
              color: AppColor.bodyColor.toHexColor(),
            ),
          ),
        ],
      ),
    ];
  }

  Container getGenderRow() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColor.greyBgColor.toHexColor(),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              elevation: 0,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Pria',
                style: GoogleFonts.muli(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              color: HexColor('0165C0'),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: MaterialButton(
              elevation: 0,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Wanita',
                style: GoogleFonts.muli(
                  color: AppColor.bodyColor.toHexColor(),
                  // color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              // color: HexColor('0165C0'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
