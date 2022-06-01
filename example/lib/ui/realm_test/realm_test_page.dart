import 'package:flutter_mongodb_realm_example/data/service/mongo_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/authentication/authentication_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/layout/primary_button_blue.dart';
import 'package:flutter_mongodb_realm_example/ui/layout/primary_button_green.dart';
import 'package:flutter_mongodb_realm_example/ui/realm_test/realm_test_bloc.dart';

class RealmTestPage extends StatefulWidget {
  const RealmTestPage({
    Key? key,
  }) : super(key: key);

  @override
  _RealmTestPageState createState() => _RealmTestPageState();
}

class _RealmTestPageState extends State<RealmTestPage> {
  late AuthenticationBloc _authenticationBloc;
  late RealmTestBloc _realmTestBloc;

  @override
  void initState() {
    print('xxx RealmTestPage');
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _realmTestBloc = BlocProvider.of<RealmTestBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'realm test selection';

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

              SingleChildScrollView(
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryButtonGreen(
                            text: 'callFunction getUserData',
                            onPressed: () => _realmTestBloc.getUserData(),
                          ),
                          SizedBox(height: 80.0),
                          PrimaryButtonBlue(
                            text: 'logout',
                            onPressed: () => _authenticationBloc.logout(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
