import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/realm_test/realm_test_event.dart';
import 'package:flutter_mongodb_realm_example/ui/realm_test/realm_test_state.dart';
import 'package:flutter_mongodb_realm_example/data/model/user_data.dart';
import 'package:flutter_mongodb_realm_example/data/repository/realm_repository.dart';

class RealmTestBloc extends Bloc<RealmTestEvent, RealmTestState> {
  final RealmRepository realmRepository;
  RealmTestBloc({required this.realmRepository})
      : assert(realmRepository != null),
        super(const RealmTestUninitialized()) {
    on<RealmTestEvent>((event, emit) async {
      if (event is RealmTestInit) {
        emit(RealmTestUninitialized());
      }
      if (event is GetUserData) {
        emit(RealmResponseLoading());
        final UserData? userData = await realmRepository.getUserData();
        print('xxx RealmResponseLoaded');

        emit(RealmResponseLoaded(
          userData: userData,
        ));
      }
    });
  }

  // ============== //
  // event triggers //
  // ============== //

  void getUserData() {
    add(GetUserData());
  }

  void init() {
    add(RealmTestInit());
  }
}
