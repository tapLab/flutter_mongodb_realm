import 'package:flutter_mongodb_realm_example/data/service/mongo_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/authentication/authentication_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/layout/primary_button_blue.dart';
import 'package:flutter_mongodb_realm_example/ui/realm_test/realm_test_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/realm_test/realm_test_state.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<ResultPage> {
  late AuthenticationBloc _authenticationBloc;
  late RealmTestBloc _realmTestBloc;

  @override
  void initState() {
    print('xxx ResultPage');
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _realmTestBloc = BlocProvider.of<RealmTestBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'result page';

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

              BlocBuilder<RealmTestBloc, RealmTestState>(
                bloc: _realmTestBloc,
                builder: (
                  BuildContext context,
                  RealmTestState state,
                ) {
                  if (state is RealmResponseLoaded) {
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
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'realm user data',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                Text(
                                    'id: ${_authenticationBloc.state.user?.realmUser.id}'),
                                Text(
                                    'email: ${_authenticationBloc.state.user!.realmUser.profile.email}'),
                                SizedBox(height: 40.0),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'callFunction response data',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                Text('userData id: ${state.userData!.id}'),
                                Text(
                                    'userdata name: ${state.userData!.profile!.fullname}'),
                                SizedBox(height: 40.0),
                                PrimaryButtonBlue(
                                  text: 'back to realm test selection',
                                  onPressed: () => _realmTestBloc.init(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
