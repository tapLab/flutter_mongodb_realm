import 'package:flutter_mongodb_realm_example/ui/authentication/authentication_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/authentication/authentication_event.dart';
import 'package:flutter_mongodb_realm_example/data/model/app_user.dart';
import 'package:flutter_mongodb_realm_example/data/repository/realm_repository.dart';
import 'package:flutter_mongodb_realm_example/ui/login/login_event.dart';
import 'package:flutter_mongodb_realm_example/ui/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RealmRepository realmRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.realmRepository,
    required this.authenticationBloc,
  }) : super(const LoginInitial()) {
    // ============= //
    // event handler //
    // ============= //

    on<LoginEvent>((event, emit) async {
      print('LoginEvent: $event');

      if (event is SetLoadingState) {
        emit(const LoginLoading());
      }

      if (event is SetInitial) {
        emit(const LoginInitial());
      }

      if (event is LoginButtonPressed) {
        emit(const LoginLoading());

        try {
          final AppUser user = await realmRepository.authenticate(
            username: event.username,
            password: event.password,
          );

          authenticationBloc.add(LoggedIn(user: user));
          emit(const LoginInitial());
        } catch (error) {
          emit(LoginFailure(error: error.toString()));
        }
      }
    });
  }
}
