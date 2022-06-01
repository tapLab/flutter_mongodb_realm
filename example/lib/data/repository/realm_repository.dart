import 'package:flutter_mongodb_realm_example/data/model/app_user.dart';
import 'package:flutter_mongodb_realm_example/data/model/user_data.dart';
import 'package:flutter_mongodb_realm_example/data/service/mongo_db.dart';

class RealmRepository {
  final MongoDB mongoDB;
  RealmRepository({required this.mongoDB});

  Future<AppUser> authenticate(
      {required String username, required String password}) {
    return mongoDB
        .authenticate(username: username, password: password)
        .then((AppUser appUser) async {
      return appUser;
    });
  }

  Future<UserData?> getUserData() {
    return mongoDB.getUserData().then((UserData? userData) async {
      return userData;
    });
  }

  Future<void> logout() async {
    return mongoDB.logout();
  }

  Future<bool> hasUser() {
    return mongoDB.hasUser();
  }

  Future<AppUser> getUser() {
    return mongoDB.getUser();
  }
}
