import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:dirumahaja/core/entity/entity_friend.dart';
import 'package:dirumahaja/feature/friend/share_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendScreen extends StatelessWidget {
  final String username;
  final String imagePath;
  final String downloadLink;
  final List<Friend> friendList;

  FriendScreen(
    this.username,
    this.imagePath,
    this.friendList,
    this.downloadLink,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('4DA6EA'),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('4DA6EA'),
        title: Text(
          'Daftar Penerima Challenge',
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: 'Ajak Teman',
            icon: Icon(Icons.share),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ShareScreen(
                  username,
                  imagePath,
                  downloadLink,
                ),
              ));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: friendList.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (ctx, i) => createItem(friendList[i]),
      ),
    );
  }

  Card createItem(Friend f) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            getUserIcon(f),
            Expanded(child: getUserInfo(f)),
            getUserStatus(f),
          ],
        ),
      ),
    );
  }

  Container getUserStatus(Friend f) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        color: HexColor('346182'),
      ),
      child: Column(
        children: <Widget>[
          Text(
            f.sessionDay.toString(),
            style: GoogleFonts.muli(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Hari',
            style: GoogleFonts.muli(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(height: 6),
          Row(
            children: <Widget>[
              AppImages.energySvg.toSvgPicture(width: 8),
              Container(width: 2),
              Text(
                f.sessionHealth.toString(),
                style: GoogleFonts.muli(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding getUserIcon(Friend f) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: f.emblemImgUrl.toPngImage(width: 68),
    );
  }

  Column getUserInfo(Friend f) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          f.username,
          style: GoogleFonts.muli(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        Text(
          f.locationName ?? 'Unknown',
          style: GoogleFonts.muli(
            color: AppColor.bodyColor.toHexColor(),
          ),
        ),
        Container(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColor.buttonColor.toHexColor(),
          ),
          child: Text(
            f.emblemName,
            style: GoogleFonts.raleway(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
