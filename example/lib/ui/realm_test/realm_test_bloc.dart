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
        print('RealmTestBloc -> RealmResponseLoaded (GetUserData)');

        emit(RealmResponseLoaded(
          userData: userData,
        ));
      }

      if (event is GetFileUrl) {
        emit(RealmResponseLoading());
        String path = event.path;
        final String stringResponse =
            await realmRepository.getRemoteFileUrl({'path': path});
        print('RealmTestBloc -> RealmResponseLoaded (GetFileUrl)');

        emit(RealmResponseLoaded(
          stringResponse: stringResponse,
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

  void getFileUrl({required String path}) {
    add(GetFileUrl(path: path));
  }

  void init() {
    add(RealmTestInit());
  }
}
