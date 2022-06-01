import 'package:flutter_mongodb_realm_example/data/model/app_user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent([List props = const []]);
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final AppUser user;

  LoggedIn({required this.user}) : super([user]);

  @override
  String toString() => 'LoggedIn { user: $user }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
