import 'package:flutter/material.dart';
import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// /////////////////////////////////////////////////////
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mongodb_realm_example/ui/authentication/authentication_bloc.dart';
import 'package:flutter_mongodb_realm_example/data/repository/realm_repository.dart';
import 'package:flutter_mongodb_realm_example/data/service/mongo_db.dart';
import 'package:flutter_mongodb_realm_example/ui/authentication/authentication_state.dart';
import 'package:flutter_mongodb_realm_example/ui/layout/sized_progress_indicator.dart';
import 'package:flutter_mongodb_realm_example/ui/login/login_page.dart';
import 'package:flutter_mongodb_realm_example/ui/realm_test/realm_test_bloc.dart';
import 'package:flutter_mongodb_realm_example/ui/realm_test/realm_test_page.dart';
import 'package:flutter_mongodb_realm_example/ui/realm_test/realm_test_state.dart';
import 'package:flutter_mongodb_realm_example/ui/result_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MongoRealmClient client = MongoRealmClient();
  final RealmApp app = RealmApp();
  MongoDB mongoDB = MongoDB();
  late RealmRepository realmRepository;
  late AuthenticationBloc authenticationBloc;
  late RealmTestBloc realmTestBloc;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    realmRepository = RealmRepository(mongoDB: mongoDB);
    authenticationBloc = AuthenticationBloc(realmRepository: realmRepository);
    realmTestBloc = RealmTestBloc(realmRepository: realmRepository);

    // initialized MongoRealm App

    try {} on PlatformException catch (e) {
      print("Error! ${e.message}");
    } on Exception {}
  }

  Future<void> countData() async {
    var collection = client.getDatabase("test").getCollection("my_collection");

    try {
      var size = await collection.count();
      print("size=$size");
    } on PlatformException catch (e) {
      print("Error! ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<RealmTestBloc>(
            create: (context) => realmTestBloc,
          ),
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<RealmRepository>(
              create: (context) => realmRepository,
            ),
          ],
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            builder: (
              BuildContext context,
              AuthenticationState state,
            ) {
              if (state is AuthenticationAuthenticated) {
                return BlocBuilder<RealmTestBloc, RealmTestState>(
                  bloc: realmTestBloc,
                  builder: (
                    BuildContext context,
                    RealmTestState state,
                  ) {
                    if (state is RealmResponseLoading) {
                      return SizedProgressIndicator();
                    }
                    if (state is RealmResponseLoaded) {
                      return ResultPage();
                    }

                    return RealmTestPage();
                  },
                );
              }
              return LoginPage();
            },
          ),
        ),
      ),
    );
  }
}
