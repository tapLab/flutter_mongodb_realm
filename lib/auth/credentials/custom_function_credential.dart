import 'package:flutter_mongodb_realm/database/mongo_document.dart';

import 'realm_credential.dart';

@deprecated
class FunctionCredential extends RealmCredential {
  final MongoDocument arguments;

  FunctionCredential(this.arguments);
}
