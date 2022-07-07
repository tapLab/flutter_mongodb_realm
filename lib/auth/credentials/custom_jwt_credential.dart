import 'realm_credential.dart';

@deprecated
class CustomJwtCredential extends RealmCredential {
  final String token;

  CustomJwtCredential(this.token);
}
