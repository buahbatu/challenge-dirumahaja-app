import 'package:dirumahaja/core/network/base_result.dart';

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
