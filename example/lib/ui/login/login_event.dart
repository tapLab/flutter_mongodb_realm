import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent([List props = const []]);
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({
    required this.username,
    required this.password,
  }) : super([username, password]);

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class SetInitial extends LoginEvent {}

class SetLoadingState extends LoginEvent {}
