import 'dart:async';
import 'dart:convert';

import 'package:bson/bson.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mongodb_realm/stream_interop/stream_interop.dart';
import 'package:flutter_mongo_realm_platform_interface/flutter_mongo_realm_platform_interface.dart';
import 'package:universal_html/html.dart';

import 'auth/core_realm_user.dart';

class FlutterMongoRealm {
  static Future connectToMongo(String appId) async {
    return await FlutterMongoRealmPlatform.instance.connectToMongo(appId);
  }

  static Future signInAnonymously() async {
    var details = await FlutterMongoRealmPlatform.instance.signInAnonymously();
    return CoreRealmUser.fromMap(details);
  }

  static Future<CoreRealmUser> signInWithUsernamePassword(
      String username, String password) async {
    var details = await FlutterMongoRealmPlatform.instance
        .signInWithUsernamePassword(username, password);
    return CoreRealmUser.fromMap(details);
  }

  static Future<CoreRealmUser> signInWithGoogle(String authCode) async {
    var details =
        await FlutterMongoRealmPlatform.instance.signInWithGoogle(authCode);
    return CoreRealmUser.fromMap(details);
  }

  static Future<CoreRealmUser> signInWithFacebook(String accessToken) async {
    var details = await FlutterMongoRealmPlatform.instance
        .signInWithFacebook(accessToken);
    return CoreRealmUser.fromMap(details);
  }

  static Future<CoreRealmUser> signInWithCustomJwt(String token) async {
    var details =
        await FlutterMongoRealmPlatform.instance.signInWithCustomJwt(token);
    return CoreRealmUser.fromMap(details);
  }

  static Future<CoreRealmUser> signInWithCustomFunction(String json) async {
    var details =
        await FlutterMongoRealmPlatform.instance.signInWithCustomFunction(json);
    return CoreRealmUser.fromMap(details);
  }

  static Future logout() async {
    return await FlutterMongoRealmPlatform.instance.logout();
  }

  static Future getUserId() async {
    return await FlutterMongoRealmPlatform.instance.getUserId();
  }

  static Future<bool> registerWithEmail(String email, String password) async {
    return await FlutterMongoRealmPlatform.instance
        .registerWithEmail(email, password);
  }

  static Future<CoreRealmUser> getUser() async {
    var details = await FlutterMongoRealmPlatform.instance.getUser();
    return CoreRealmUser.fromMap(details);
  }

  static Future<bool> sendResetPasswordEmail(String email) async {
    return await FlutterMongoRealmPlatform.instance
        .sendResetPasswordEmail(email);
  }

  ///

  static Future insertDocument({
    @required String collectionName,
    @required String databaseName,
    @required Map<String, Object> data,
  }) async {
    return await FlutterMongoRealmPlatform.instance.insertDocument(
      collectionName: collectionName,
      databaseName: databaseName,
      data: data,
    );
  }

  static Future insertDocuments({
    @required String collectionName,
    @required String databaseName,
    @required List<String> list,
  }) async {
    return await FlutterMongoRealmPlatform.instance.insertDocuments(
      collectionName: collectionName,
      databaseName: databaseName,
      list: list,
    );
  }

  static Future findDocuments(
      {String collectionName,
      String databaseName,
      dynamic filter,
      String projection,
      int limit,
      String sort}) async {
    return await FlutterMongoRealmPlatform.instance.findDocuments(
      collectionName: collectionName,
      databaseName: databaseName,
      filter: filter,
      limit: limit,
      sort: sort,
      projection: projection,
    );
  }

  static Future findFirstDocument(
      {String collectionName,
      String databaseName,
      dynamic filter,
      String projection}) async {
    return await FlutterMongoRealmPlatform.instance.findFirstDocument(
      collectionName: collectionName,
      databaseName: databaseName,
      filter: filter,
      projection: projection,
    );
  }

  static Future deleteDocument(
      {String collectionName, String databaseName, dynamic filter}) async {
    return await FlutterMongoRealmPlatform.instance.deleteDocument(
      collectionName: collectionName,
      databaseName: databaseName,
      filter: filter,
    );
  }

  static Future deleteDocuments(
      {String collectionName, String databaseName, dynamic filter}) async {
    return await FlutterMongoRealmPlatform.instance.deleteDocuments(
      collectionName: collectionName,
      databaseName: databaseName,
      filter: filter,
    );
  }

  static Future countDocuments(
      {String collectionName, String databaseName, dynamic filter}) async {
    return await FlutterMongoRealmPlatform.instance.countDocuments(
      collectionName: collectionName,
      databaseName: databaseName,
      filter: filter,
    );
  }

  ///
  static Future updateDocument(
      {String collectionName,
      String databaseName,
      String filter,
      String update}) async {
    return await FlutterMongoRealmPlatform.instance.updateDocument(
      collectionName: collectionName,
      databaseName: databaseName,
      filter: filter,
      update: update,
    );
  }

  static Future updateDocuments(
      {String collectionName,
      String databaseName,
      String filter,
      String update}) async {
    return await FlutterMongoRealmPlatform.instance.updateDocuments(
      collectionName: collectionName,
      databaseName: databaseName,
      filter: filter,
      update: update,
    );
  }

  static Stream watchCollection({
    @required String collectionName,
    @required String databaseName,
    List<String> ids,
    String filter,
    bool asObjectIds = true,
  }) {
    Stream nativeStream;

    if (kIsWeb) {
//      Stream<Event> jsStream =
//          document.on["watchEvent.$databaseName.$collectionName"];

      var jsStream = StreamInterop.getNativeStream(
          "watchEvent.$databaseName.$collectionName");

      // ignore: close_sinks
      var controller = StreamController<String>();

      // migrating events from the js-event to a dart event
      jsStream.listen((event) {
        var eventDetail = (event as CustomEvent).detail;

        var map = json.decode(eventDetail ?? "{}");

        if (map['_id'] is String == false) {
          map['_id'] = ObjectId.parse(map['_id']);
        }
        controller.add(jsonEncode(map));
      });

      nativeStream = controller.stream;
    } else {
      nativeStream = StreamInterop.getNativeStream({
        "handler": "watchCollection",
        "db": databaseName,
        "collection": collectionName,
        "filter": filter,
        "ids": ids,
        "as_object_ids": asObjectIds,
      });
    }

    return nativeStream;

    // continuous stream of events from platform side
//    return _streamsChannel.receiveBroadcastStream({
//      "handler": "watchCollection",
//      "db": databaseName,
//      "collection": collectionName,
//      "filter": filter,
//      "ids": ids,
//      "as_object_ids": asObjectIds,
//    });
  }

  static aggregate(
      {@required String collectionName,
      @required String databaseName,
      List<String> pipeline}) async {
    return await FlutterMongoRealmPlatform.instance.aggregate(
      collectionName: collectionName,
      databaseName: databaseName,
      pipeline: pipeline,
    );
  }

  static Future callFunction(String name,
      {List args, int requestTimeout}) async {
    return await FlutterMongoRealmPlatform.instance.callFunction(
      name,
      args: args,
      requestTimeout: requestTimeout,
    );
  }

  static Stream authListener() {
    Stream nativeStream;

    if (kIsWeb) {
      //Stream<Event> jsStream = document.on["authChange"];
      var jsStream = StreamInterop.getNativeStream("authChange");

      // ignore: close_sinks
      var controller = StreamController<Map>();

      controller.onListen = () {
        controller.add(null);
      };

      // migrating events from the js-event to a dart event
      jsStream.listen((event) {
        var eventDetail = (event as CustomEvent).detail;
        print(eventDetail);
        if (eventDetail == null) {
          controller.add(null);
        } else {
          controller.add(eventDetail);
        }
      });

      nativeStream = controller.stream;
    } else {
      nativeStream = StreamInterop.getNativeStream({
        "handler": "auth",
      });
    }

    return nativeStream;

//    return _streamsChannel.receiveBroadcastStream({
//      "handler": "auth",
//    });
  }

  // WEB-specific helpers

  static Future setupWatchCollection(String collectionName, String databaseName,
      {List<String> ids, bool asObjectIds, String filter}) async {
    await FlutterMongoRealmPlatform.instance.setupWatchCollection(
      collectionName,
      databaseName,
      ids: ids,
      asObjectIds: asObjectIds,
      filter: filter,
    );
  }
}
