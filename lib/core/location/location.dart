import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dirumahaja/core/res/app_images.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndonesiaPlace {
  final String province;
  final String city;
  final String district;
  final String street;
  final Coordinate coordinate;

  IndonesiaPlace({
    this.province,
    this.city,
    this.district,
    this.street,
    this.coordinate,
  });

  @override
  String toString() {
    return "${province ?? ''}|${city ?? ''}|${district ?? ''}|${street ?? ''}|${coordinate?.toString() ?? ''}";
  }

  factory IndonesiaPlace.parseString(String placeStr) {
    final places = placeStr.split("|");
    return IndonesiaPlace(
      province: places[0],
      city: places[1],
      district: places[2],
      street: places[3],
      coordinate: Coordinate.parseString(places[4]),
    );
  }
}

class Coordinate {
  final double latitude;
  final double longitude;

  const Coordinate(this.latitude, this.longitude);

  @override
  String toString() {
    return '$latitude,$longitude';
  }

  LatLng toLatLng() => LatLng(latitude, longitude);

  Position toPosition() => Position(latitude: latitude, longitude: longitude);

  factory Coordinate.parseString(String coordinate) {
    if (coordinate == null || coordinate.isEmpty) return null;

    final splitted =
        coordinate.split(',').map((s) => double.parse(s.trim())).toList();
    return Coordinate(splitted[0], splitted[1]);
  }

  factory Coordinate.parseFromPosition(Position position) {
    return Coordinate(position.latitude, position.longitude);
  }

  factory Coordinate.parseFromLatLng(LatLng latLng) {
    return Coordinate(latLng.latitude, latLng.longitude);
  }
}

class ReverseGeocoder {
  static Future<IndonesiaPlace> loadCurrentLocation() async {
    final locations = await _getLocationNames();

    final geolocator = Geolocator();
    final readPosition = await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    String province = "";
    String city = "";
    double distance = -1;

    for (final prov in locations.keys) {
      Map<String, dynamic> tempProv = locations[prov];
      for (final tempCity in tempProv.keys) {
        final tempDistance = await geolocator.distanceBetween(
          readPosition.latitude,
          readPosition.longitude,
          tempProv[tempCity]['latitude'],
          tempProv[tempCity]['longitude'],
        );
        if (distance == -1) {
          distance = tempDistance;
          province = prov;
          city = tempCity;
        } else if (tempDistance <= distance) {
          distance = tempDistance;
          province = prov;
          city = tempCity;
        }
      }
    }

    return IndonesiaPlace(
      province: province,
      city: city,
      coordinate: Coordinate(
        readPosition.latitude,
        readPosition.longitude,
      ),
    );
  }

  static Future<Map<String, dynamic>> _getLocationNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final locationListKey = 'locationNameList';
    var locations = Map<String, dynamic>();
    if (prefs.containsKey(locationListKey)) {
      locations = jsonDecode(prefs.getString(locationListKey));
    } else {
      final locationsResult = await Dio()
          .get(defaultDomain + '/assets/location-list/location.json');
      if (locationsResult.statusCode != 200) return null;

      prefs.setString(locationListKey, jsonEncode(locationsResult.data));
      locations = locationsResult.data;
    }
    return locations;
  }
}
