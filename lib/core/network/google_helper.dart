import 'package:dirumahaja/core/location/map_data.dart';
import 'package:flutter/material.dart';

abstract class GoogleHelper {
  static String _getGoogleApiKey(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return 'AIzaSyAODK8-14Wgp7n5nwJsx9-nU-IT7KWm2Kk';
    } else {
      return 'AIzaSyA6xgjj8n0Ua-KzssTtkptO3WuN2UWXp-M';
    }
  }

  static String createUrl(BuildContext context, MapData mapData) {
    const String baseUrl = 'https://maps.googleapis.com/maps/api/staticmap?';

    String queryString = '''
      key=${_getGoogleApiKey(context)}&
      center=${mapData.center.toString()}&
      zoom=${mapData.zoom}&
      size=${mapData.width}x${mapData.height}&
      format=${mapData.imageFormat.toString().split('.')[1]}&
      maptype=${mapData.mapType.toString().split('.')[1]}
    '''
        .replaceAll(RegExp(r'[ \n]'), ''); // replace space and newline

    mapData.queries?.forEach((key, value) {
      queryString += '&$key=$value';
    });

    queryString = Uri.encodeFull(queryString);
    return baseUrl + queryString;
  }
}
