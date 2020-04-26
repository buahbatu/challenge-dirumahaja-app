import 'package:dirumahaja/core/entity/entity_usename_exist.dart';
import 'package:dirumahaja/core/network/api.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/tools/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengerScreen extends StatefulWidget {
  final Function(String username) onSubmit;

  const ChallengerScreen({Key key, this.onSubmit}) : super(key: key);

  @override
  _ChallengerScreenState createState() => _ChallengerScreenState();
}

class _ChallengerScreenState extends State<ChallengerScreen>
    with AutomaticKeepAliveClientMixin {
  bool isUsernameExist = false;
  String userName = "";
  final _debouncerUsername = Debouncer(milliseconds: 1000);

  void onUsernameChange(String name) async {
    userName = name;
    if (name.isNotEmpty) {
      final result = await Api().post<ProfileExist>(
        path: '/auth/check',
        body: {"username": userName},
        dataParser: ProfileExist.dataParser,
      );
      setState(() {
        isUsernameExist = result?.data?.isExist ?? false;
        if (isUsernameExist)
          widget.onSubmit(userName);
        else
          widget.onSubmit("");
      });
    } else {
      setState(() {
        isUsernameExist = true;
        widget.onSubmit("-1");
      });
    }
  }

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

  Widget getTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Siapa yang nantang kamu?',
            style: GoogleFonts.raleway(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColor.titleColor.toHexColor(),
            ),
          ),
          Container(height: 8),
          Text(
            'Kasih tau dia kalo kamu juga bisa',
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
              'Username penantang',
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
                errorText: userName.isEmpty
                    ? null
                    : isUsernameExist ? null : 'username tidak ditemukan',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                hintText: 'Isi username teman mu',
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
            Container(height: 8),
            Text(
              'Kosongkan jika tidak ada',
              style: GoogleFonts.muli(
                fontSize: 12,
                color: AppColor.bodyColor.toHexColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
