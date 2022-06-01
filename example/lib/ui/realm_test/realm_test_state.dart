import 'package:flutter_mongodb_realm_example/data/model/user_data.dart';
import 'package:equatable/equatable.dart';

abstract class RealmTestState extends Equatable {
  final UserData? userData;

  const RealmTestState({
    this.userData,
  });

  @override
  List<Object> get props => [
        userData ?? Object,
      ];
}

class RealmTestUninitialized extends RealmTestState {
  const RealmTestUninitialized()
      : super(
          userData: null,
        );

  @override
  String toString() => 'RealmTestUninitialized';
}

class RealmResponseLoading extends RealmTestState {
  const RealmResponseLoading()
      : super(
          userData: null,
        );

  @override
  String toString() => 'RealmResponseLoading';
}

class RealmResponseLoaded extends RealmTestState {
  const RealmResponseLoaded({
    user,
    userData,
  }) : super(
          userData: userData,
        );

  @override
  String toString() => 'RealmResponseLoaded';
}
