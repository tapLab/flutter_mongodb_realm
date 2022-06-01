import 'package:equatable/equatable.dart';
import 'package:flutter_mongodb_realm/auth/auth.dart';

class AppUser extends Equatable {
  const AppUser({required this.realmUser});

  final CoreRealmUser realmUser;

  @override
  List<Object?> get props => [realmUser];

  @override
  String toString() {
    return "AppUser {id:${realmUser.id}, email:${realmUser.profile?.email}}";
  }
}
