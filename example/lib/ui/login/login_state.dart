import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  final String error;

  const LoginState({
    this.error = '',
  });

  @override
  List<Object?> get props => [error];
}

class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  const LoginLoading();

  @override
  String toString() => 'LoginLoading';
}

class LoginFailure extends LoginState {
  const LoginFailure({required error}) : super(error: error);

  @override
  String toString() => 'LoginFailure { error: $error }';
}
