import 'package:flutter_mongodb_realm_example/data/model/user_profile.dart';
import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String id;
  final String email;
  final int uid;

  final UserProfile? profile;

  const UserData({
    required this.id,
    required this.email,
    required this.uid,
    required this.profile,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    String id = '';
    if (json['_id'] is Map) {
      Map idMap = Map.from(json['_id']);
      if (idMap.containsKey('\$oid')) {
        id = idMap['\$oid'].toString();
      }
    }

    String email = json['email'] ?? '';

    int uid = 0;
    if (json['uid'] is Map) {
      Map uidMap = Map.from(json['uid']);
      if (uidMap.containsKey('\$numberInt')) {
        uid = int.parse(((uidMap['\$numberInt']).toString()));
      }
      if (uidMap.containsKey('\$numberLong')) {
        uid = int.parse(((uidMap['\$numberLong']).toString()));
      }
    }

    UserProfile? profile;
    if (json['profile'] is Map) {
      Map<String, dynamic> map = Map<String, dynamic>.from(json['profile']);
      profile = UserProfile.fromJson(map);
    }

    return UserData(
      id: id,
      email: email,
      uid: uid,
      profile: profile,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'uid': uid,
        'profile': profile?.toJson(),
      };

  @override
  List<Object?> get props => [id, email, uid, profile];
}
