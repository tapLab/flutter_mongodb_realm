import 'package:flutter_mongodb_realm_example/data/model/app_user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  final AppUser? user;
  final bool authenticated;

  const AuthenticationState({
    this.user,
    this.authenticated = false,
  });

  @override
  List<Object> get props => [
        user ?? Object,
        authenticated,
      ];
}

class AuthenticationUninitialized extends AuthenticationState {
  const AuthenticationUninitialized();

  @override
  String toString() => 'AuthenticationUninitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated({
    user,
    userData,
  }) : super(
          user: user,
          authenticated: true,
        );

  @override
  String toString() => 'AuthenticationAuthenticated';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  const AuthenticationUnauthenticated()
      : super(
          user: null,
          authenticated: false,
        );

  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading()
      : super(
          user: null,
          authenticated: false,
        );

  @override
  String toString() => 'AuthenticationLoading';
}
