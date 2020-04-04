import 'package:dirumahaja/core/network/base_result.dart';

class Profile extends Data {
  final String username;
  final String challenger;
  final int age;
  final String gender;
  final String coordinate;
  final String locationName;
  final int sessionDay;
  final int sessionHealth;
  final int sessionStatus;
  final int sessionPunishment;
  final String emblemImgUrl;
  final String emblemName;

  Profile({
    this.username,
    this.challenger,
    this.age,
    this.gender,
    this.coordinate,
    this.locationName,
    this.sessionDay,
    this.sessionHealth,
    this.sessionStatus,
    this.sessionPunishment,
    this.emblemImgUrl,
    this.emblemName,
  });

  Profile copyWith({
    String username,
    String challenger,
    int age,
    String gender,
    String coordinate,
    String locationName,
    int sessionDay,
    int sessionHealth,
    int sessionStatus,
    int sessionPunishment,
    int emblemImgUrl,
    int emblemName,
  }) {
    return Profile(
      username: username ?? this.username,
      challenger: challenger ?? this.challenger,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      coordinate: coordinate ?? this.coordinate,
      locationName: locationName ?? this.locationName,
      sessionDay: sessionDay ?? this.sessionDay,
      sessionHealth: sessionHealth ?? this.sessionHealth,
      sessionStatus: sessionStatus ?? this.sessionStatus,
      sessionPunishment: sessionPunishment ?? this.sessionPunishment,
      emblemImgUrl: emblemImgUrl ?? this.emblemImgUrl,
      emblemName: emblemName ?? this.emblemName,
    );
  }

  static Profile fromJson(Map<String, dynamic> json) {
    return Profile(
      username: json['username'],
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 'm',
      challenger: json['challenger'] ?? '',
      coordinate: json['coordinate'],
      locationName: json['location_name'] ?? '',
      sessionDay: json['session_day'],
      sessionHealth: json['session_health'],
      sessionStatus: json['session_status'],
      sessionPunishment: json['session_punishment'],
      emblemImgUrl: json['emblem_img_url'],
      emblemName: json['emblem_name'],
    );
  }
}
