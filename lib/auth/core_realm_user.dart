import 'package:flutter/foundation.dart';

/// A user that belongs to a MongoDB Realm application.
class CoreRealmUser {
  final String id;
  final String deviceId;
  final RealmUserProfile profile;

  CoreRealmUser({
    @required this.id,
    this.deviceId,
    this.profile,
  });

//  final String loggedInProviderType;
//  final String loggedInProviderName;
//  final RealmUserProfileImpl profile;
//  final bool isLoggedIn;
//  final DateTime lastAuthActivity;

  static fromMap(Map map) {
    return (map == null)
        ? null
        : CoreRealmUser(
            id: map["id"],
            deviceId: map["device_id"],
            profile: RealmUserProfile.fromMap(map['profile'] ?? Map()));
  }
}

class RealmUserProfile {
  final String name;
  final String email;
  final String pictureUrl;
  final String firstName;
  final String lastName;
  final String gender;
  final String birthday;
  final String minAge;
  final String maxAge;

  RealmUserProfile({
    this.name,
    this.email,
    this.pictureUrl,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthday,
    this.minAge,
    this.maxAge,
  });

  RealmUserProfile.fromMap(Map map)
      : name = map["name"] ?? '',
        email = map["email"] ?? '',
        pictureUrl = map["pictureUrl"] ?? '',
        firstName = map["firstName"] ?? '',
        lastName = map["lastName"] ?? '',
        gender = map["gender"] ?? '',
        birthday = map["birthday"] ?? '',
        minAge = map["minAge"] ?? '',
        maxAge = map["maxAge"] ?? '';
}
