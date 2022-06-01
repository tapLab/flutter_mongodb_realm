import 'package:equatable/equatable.dart';

abstract class RealmTestEvent extends Equatable {
  const RealmTestEvent([List props = const []]);
  @override
  List<Object> get props => [];
}

class RealmTestInit extends RealmTestEvent {
  @override
  String toString() => 'RealmTestInit';
}

class GetUserData extends RealmTestEvent {
  @override
  String toString() => 'GetUserData';
}
