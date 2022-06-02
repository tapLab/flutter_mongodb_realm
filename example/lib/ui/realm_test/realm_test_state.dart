import 'package:flutter_mongodb_realm_example/data/model/user_data.dart';
import 'package:equatable/equatable.dart';

abstract class RealmTestState extends Equatable {
  final UserData? userData;
  final String? stringResponse;

  const RealmTestState({
    this.userData,
    this.stringResponse,
  });

  @override
  List<Object> get props => [
        userData ?? Object,
        stringResponse ?? '',
      ];
}

class RealmTestUninitialized extends RealmTestState {
  const RealmTestUninitialized()
      : super(
          userData: null,
          stringResponse: null,
        );

  @override
  String toString() => 'RealmTestUninitialized';
}

class RealmResponseLoading extends RealmTestState {
  const RealmResponseLoading()
      : super(
          userData: null,
          stringResponse: null,
        );

  @override
  String toString() => 'RealmResponseLoading';
}

class RealmResponseLoaded extends RealmTestState {
  const RealmResponseLoaded({
    userData,
    stringResponse,
  }) : super(
          userData: userData,
          stringResponse: stringResponse,
        );

  @override
  String toString() => 'RealmResponseLoaded';
}
