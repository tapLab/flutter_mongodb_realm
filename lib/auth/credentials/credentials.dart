export 'realm_credential.dart';
export 'anonymous_credential.dart';
export 'user_password_credentinal.dart';
export 'google_credential.dart';
export 'facebook_credential.dart';
export 'custom_jwt_credential.dart';
export 'custom_function_credential.dart';

import 'package:flutter_mongodb_realm/database/mongo_document.dart';

import '../auth.dart';

class Credentials {
  // ignore: deprecated_member_use_from_same_package
  static RealmCredential anonymous() => AnonymousCredential();

  static RealmCredential emailPassword(String username, String password) =>
      // ignore: deprecated_member_use_from_same_package
      UserPasswordCredential(username: username, password: password);

  static RealmCredential google({String serverClientId, List<String> scopes}) =>
      // ignore: deprecated_member_use_from_same_package
      GoogleCredential(serverClientId: serverClientId, scopes: scopes);

  static RealmCredential facebook(String accessToken) =>
      // ignore: deprecated_member_use_from_same_package
      FacebookCredential(accessToken);

  // ignore: deprecated_member_use_from_same_package
  static RealmCredential jwt(String token) => CustomJwtCredential(token);

  static RealmCredential customFunction(MongoDocument arguments) =>
      // ignore: deprecated_member_use_from_same_package
      FunctionCredential(arguments);
}
