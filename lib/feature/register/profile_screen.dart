import 'package:dirumahaja/core/entity/entity_usename_exist.dart';
import 'package:dirumahaja/core/network/api.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/tools/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final Function({String username, int age, String gender}) onSubmit;

  const ProfileScreen({Key key, this.onSubmit}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  String userName = "";
  int umur = 22;
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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

  final _debouncerUsername = Debouncer(milliseconds: 1000);
  final _debouncerAge = Debouncer(milliseconds: 200);

  void toggleGender(bool isMale) async {
    widget.onSubmit(gender: isMale ? "m" : "f");
    setState(() {
      this.isMale = isMale;
    });
  }

  void onAgeChange(String age) async {
    final parsedAge = int.tryParse(age);
    if (parsedAge != null && parsedAge > 0) {
      umur = parsedAge;
      widget.onSubmit(age: umur);
    }
  }

  void onUsernameChange(String name) async {
    userName = name;
    final result = await Api().post<ProfileExist>(
      path: '/auth/check',
      body: {"username": userName},
      dataParser: ProfileExist.dataParser,
    );
    setState(() {
      isUsernameExist = result?.data?.isExist ?? false;
      if (!isUsernameExist) widget.onSubmit(username: userName);
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
              onChanged: (str) => _debouncerUsername.run(
                () => onUsernameChange(str),
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                errorText: isUsernameExist ? 'username sudah digunakan' : null,
                hintText: 'Isi username (IG / twitter) mu disini',
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
              keyboardType: TextInputType.number,
              onChanged: (str) => _debouncerAge.run(() => onAgeChange(str)),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                hintText: umur.toString(),
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
                  color:
                      isMale ? Colors.white : AppColor.bodyColor.toHexColor(),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              color: isMale ? HexColor('0165C0') : null,
              onPressed: () => toggleGender(true),
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
                  color:
                      isMale ? AppColor.bodyColor.toHexColor() : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              color: isMale ? null : HexColor('0165C0'),
              onPressed: () => toggleGender(false),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
