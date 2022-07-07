import 'package:flutter/cupertino.dart';

import 'realm_credential.dart';

@deprecated
class GoogleCredential extends RealmCredential {
  final List<String> scopes;
  final String serverClientId;

  GoogleCredential({@required this.serverClientId, this.scopes});
}

class GoogleCredential2 extends RealmCredential {
  final String accessToken;

  GoogleCredential2(this.accessToken);
}
