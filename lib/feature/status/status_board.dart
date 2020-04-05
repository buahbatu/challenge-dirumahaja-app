import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dirumahaja/core/entity/entity_checkin.dart';
import 'package:dirumahaja/core/entity/entity_friend.dart';
import 'package:dirumahaja/core/entity/entity_profile.dart';
import 'package:dirumahaja/core/network/api.dart';
import 'package:dirumahaja/core/res/app_color.dart';
import 'package:dirumahaja/feature/friend/friend_screen.dart';
import 'package:dirumahaja/feature/friend/share_screen.dart';
import 'package:dirumahaja/feature/status/status_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusBoard extends StatefulWidget {
  final Profile profile;
  final VoidCallback onHomeNeedReload;

  StatusBoard(
    this.profile,
    this.onHomeNeedReload, {
    Key key,
  }) : super(key: key);

  @override
  _StatusBoardState createState() => _StatusBoardState();
}

class _StatusBoardState extends State<StatusBoard> {
  List<Friend> friendList = [];

  @override
  void initState() {
    super.initState();
    loadFriends();
    doCheckIn();
  }

  void doCheckIn() async {
    final location = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final randHour = Random().nextInt(23) + 1;
    final user = await FirebaseAuth.instance.currentUser();
    final nextCheckIn = DateTime.now().add(Duration(hours: randHour));

    final checkInResult = await Api().post<CheckIn>(
      path: '/session/checkin',
      dataParser: CheckIn.fromMap,
      headers: {'uid': user.uid},
      body: {
        "coordinate": "${location.latitude}, ${location.longitude}",
        "next_checkin": nextCheckIn.toString(),
      },
    );

    final errorMessage = checkInResult.meta.userMessage;
    if (errorMessage != null && errorMessage.isNotEmpty)
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  void loadFriends() async {
    final user = await FirebaseAuth.instance.currentUser();

    final request = await Api().getDio().get<Map<String, dynamic>>(
          '/profile/relation?cache=false',
          options: Options(headers: {'uid': user.uid}),
        );

    final friends = Friend.fromMapList(request.data['data']);
    setState(() {
      friendList = friends;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColor.bgColor.toHexColor(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(23.0),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 9,
            child: getDayCount(),
          ),
          Flexible(
            flex: 7,
            child: getFriendCount(),
          ),
        ],
      ),
    );
  }

  Widget getDayCount() {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => StatusScreen(
              widget.profile,
              widget.onHomeNeedReload,
            ),
          ));
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Lama kamu di rumah',
                style: GoogleFonts.muli(
                  fontSize: 12,
                  color: AppColor.bodyColor.toHexColor(),
                ),
              ),
              Container(height: 4),
              Text(
                '${widget.profile?.sessionDay ?? 0} Hari',
                style: GoogleFonts.raleway(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.titleColor.toHexColor(),
                ),
              ),
              Container(height: 16),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColor.buttonColor.toHexColor(),
                ),
                child: Text(
                  widget.profile?.emblemName ?? '',
                  style: GoogleFonts.raleway(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container getFriendCount() {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Teman Challenge',
            style: GoogleFonts.muli(
              fontSize: 12,
              color: AppColor.bodyColor.toHexColor(),
            ),
          ),
          Container(height: 4),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => FriendScreen(
                    widget.profile?.username ?? '',
                    widget.profile?.emblemImgUrl ?? '',
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ...friendList
                    .map((f) => createImage(f?.emblemImgUrl ?? ''))
                    .toList(),
                if (friendList.isEmpty) Text('Masih Kosong'),
                if (friendList.length > 3)
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HexColor('FFC010'),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '+${friendList.length - 3}',
                      style: GoogleFonts.muli(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(height: 16),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '+ Ajak Teman',
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColor.titleColor.toHexColor(),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => ShareScreen(
                  widget.profile?.username ?? '',
                  widget.profile?.emblemImgUrl ?? '',
                ),
              ));
            },
          )
        ],
      ),
    );
  }

  Widget createImage(String path) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: HexColor('8EC13F'), width: 2),
          ),
        ),
        CachedNetworkImage(imageUrl: path ?? '', width: 24)
      ],
    );
  }
}
