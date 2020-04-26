import 'package:dirumahaja/core/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingDialog {
  static void dismissLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showLoading(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(14),
          children: <Widget>[
            Text(
              title,
              style: GoogleFonts.raleway(
                color: AppColor.titleColor.toHexColor(),
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            Container(
              height: 84,
              child: SpinKitChasingDots(
                size: 30,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index.isEven
                          ? HexColor('CCE7FF')
                          : AppColor.buttonColor.toHexColor(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
