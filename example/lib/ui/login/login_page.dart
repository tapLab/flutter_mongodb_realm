import 'package:flutter_mongodb_realm_example/data/repository/realm_repository.dart';
import 'package:flutter_mongodb_realm_example/ui/authentication/authentication_bloc.dart';
import 'package:flutter_mongodb_realm_example/data/service/mongo_db.dart';
import 'package:flutter_mongodb_realm_example/ui/login/login_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/login/login_form.dart';
import 'package:flutter_mongodb_realm_example/ui/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: close_sinks
  late AuthenticationBloc _authenticationBloc;
  late RealmRepository _realmRepository;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _realmRepository = RepositoryProvider.of<RealmRepository>(context);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      realmRepository: _realmRepository,
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Login to MongoDB Realm';

    return Scaffold(
      key: GlobalKeyService.loginPageKey,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment(0.0, 1),
                      begin: Alignment(0.0, -1),
                      colors: <Color>[
                        Color(0xFFF1F5F9),
                        Color(0x00F1F5F9),
                      ],
                    ),
                  ),
                ),
              ),
              //bottom grey shadow
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment(0.0, -1),
                      begin: Alignment(0.0, 0.4),
                      colors: <Color>[
                        Color(0xFFF1F5F9),
                        Color(0x00F1F5F9),
                      ],
                    ),
                  ),
                ),
              ),

              BlocBuilder<LoginBloc, LoginState>(
                bloc: _loginBloc,
                builder: (
                  BuildContext context,
                  LoginState state,
                ) {
                  if (state is LoginFailure) {
                    _onWidgetDidBuild(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                  }

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.all(20),
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        LoginForm(loginBloc: _loginBloc),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}
