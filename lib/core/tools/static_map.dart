import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirumahaja/core/location/map_data.dart';
import 'package:dirumahaja/core/network/google_helper.dart';
import 'package:flutter/material.dart';

enum ImageFormat { JPEG, PNG, GIF }

class StaticMap extends StatelessWidget {
  final MapData mapData;

  StaticMap(this.mapData);

  @override
  Widget build(BuildContext context) {
    String imageUrl = GoogleHelper.createUrl(context, this.mapData);
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fitWidth,
      placeholder: (context, url) => CircularProgressIndicator(),
    );
  }
}
