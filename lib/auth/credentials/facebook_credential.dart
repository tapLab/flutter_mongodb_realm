import 'realm_credential.dart';

@deprecated
class FacebookCredential extends RealmCredential {
  final String accessToken;

  FacebookCredential(this.accessToken);
}
