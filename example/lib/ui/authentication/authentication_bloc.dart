import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/authentication/authentication_event.dart';
import 'package:flutter_mongodb_realm_example/ui/authentication/authentication_state.dart';
import 'package:flutter_mongodb_realm_example/data/model/app_user.dart';
import 'package:flutter_mongodb_realm_example/data/repository/realm_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final RealmRepository realmRepository;
  AuthenticationBloc({required this.realmRepository})
      : assert(realmRepository != null),
        super(const AuthenticationUninitialized()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is LoggedIn) {
        emit(AuthenticationLoading());
        final AppUser user = await realmRepository.getUser();
        print('AuthenticationAuthenticated');

        emit(AuthenticationAuthenticated(user: user));
      }

      if (event is LoggedOut) {
        emit(AuthenticationLoading());
        await realmRepository.logout();
        emit(AuthenticationUnauthenticated());
      }
    });
  }

  // ============== //
  // event triggers //
  // ============== //

  void logout() {
    add(LoggedOut());
  }
}
