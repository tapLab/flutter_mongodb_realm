import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_mongodb_realm_example/ui/layout/approve_modal.dart';
import 'package:flutter_mongodb_realm_example/data/model/app_user.dart';
import 'package:flutter_mongodb_realm_example/data/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';

class GlobalKeyService {
  static GlobalKey rootKey = GlobalKey();
  static GlobalKey splashPageKey = GlobalKey();
  static GlobalKey loginPageKey = GlobalKey();
}

class MongoDB {
  final MongoRealmClient _client = MongoRealmClient();
  final RealmApp _app = RealmApp();
  final bool debugAlert = true;

  MongoDB() {
    RealmApp.init('bewegteslernen-varzw');
  }

  Future<dynamic> showDebugInfoAlert({
    String title = 'MongoDB callFunction',
    required String text,
  }) {
    BuildContext? context = GlobalKeyService.loginPageKey.currentContext ??
        GlobalKeyService.splashPageKey.currentContext;
    String pageName = 'unknown';
    if (context == GlobalKeyService.loginPageKey.currentContext) {
      pageName = 'loginPageKey';
    }
    if (context == GlobalKeyService.splashPageKey.currentContext) {
      pageName = 'splashPage';
    }
    print(
        'showDebugInfoAlert (mongo_db.dart): $title -> $text, pageName: $pageName');

    if (debugAlert) {
      if (context != null) {
        return ApproveModal(
          context: context,
          title: title,
          question: text,
          cancelText: '',
          onApproved: null,
        ).show();
      }
    }

    return Future.value(false);
  }

  Future<UserData?> getUserData() async {
    UserData? userData;

    try {
      return showDebugInfoAlert(text: 'getUserData').then((value) async {
        print('callFunction getUserData (mongo_db.dart)');
        String userDataJsonStr =
            await _client.callFunction('getUserData', args: []);
        String showText = userDataJsonStr;
        if (showText.length > 100) {
          showText = showText.substring(0, 100) + '...';
        }
        return showDebugInfoAlert(text: 'getUserData done, response: $showText')
            .then((value) async {
          Map<String, dynamic> userDataJson = jsonDecode(userDataJsonStr);
          userData = UserData.fromJson(userDataJson);
          print(
              'callFunction getUserData (mongo_db.dart) returns: $userDataJson');
          return userData;
        });
      });
    } catch (e) {
      log(
          '[MongoDB] callFunction error to get userData object: ' +
              e.toString(),
          error: e);
      return showDebugInfoAlert(title: 'getUserData error', text: e.toString())
          .then((value) async {
        return userData;
      });
    }
  }

  Future<dynamic> getFileUrl(Map<String, dynamic> file) async {
    String fileUrl = '';

    try {
      return showDebugInfoAlert(text: 'getFileUrl').then((value) async {
        fileUrl = await _client
            .callFunction('getFileUrl', args: ['{"path":"${file['path']}"}']);

        return fileUrl;
      });
    } on PlatformException catch (e) {
      print("getFileUrl (mongo_db.dart) Error: ${e.message}");
      print('getFileUrl (mongo_db.dart) Error string: ${e.toString()}');
    }

    return fileUrl;
  }

  ///
  ///
  /// User Stuff...
  ///
  ///

  Future<AppUser> authenticate(
      {required String username, required String password}) async {
    print('yyy mongodb login');
    await _app.login(Credentials.emailPassword(username, password));

    return await getUser();
  }

  Future<void> logout() async {
    try {
      print('yyy mongodb logout');
      await _app.logout();
    } catch (e) {
      print('logout error -> maybe offline?, error: $e');
    }
    return;
  }

  Future<bool> hasUser() async {
    try {
      await getUser();
      return true;
    } catch (e) {}
    return false;
  }

  Future<AppUser> getUser() async {
    try {
      print('getUser (mongo_db.dart) -> _app.currentUser: $_app');
      CoreRealmUser? realmUser = await _app.currentUser;
      if (realmUser != null) {
        print('getUser -> realmUser: $realmUser');
        return AppUser(realmUser: realmUser);
      }
    } catch (e) {
      log('[MongoDB] hasNoUser: ' +
          e.toString()); // on iOS on Login page after login: hasNoUser: type 'List<Object?>' is not a subtype of type 'LinkedHashMap<dynamic, dynamic>?' in type cast
    }
    throw MongoDBException('has no user');
  }
}

class MongoDBException implements Exception {
  String message;
  MongoDBException(this.message);

  @override
  String toString() => 'MongoDBException: $message';
}
