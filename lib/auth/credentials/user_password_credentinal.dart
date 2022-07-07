import 'package:flutter/foundation.dart';

import 'realm_credential.dart';

@deprecated
class UserPasswordCredential extends RealmCredential {
  final String username;
  final String password;

  UserPasswordCredential({
    @required this.username,
    @required this.password,
  });
}
