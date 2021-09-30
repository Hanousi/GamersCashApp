
import 'package:shopping_app/feature/auth/model/user_app.dart';
import 'package:shopping_app/feature/profile/repository/profile_repository.dart';

class FirebaseProfileRepository extends ProfileRepository {

  FirebaseProfileRepository() {
  }

  @override
  Future<void> logout() {
  }

  @override
  Future<UserData> getUserInfo() async {
  }

  UserData _mapDocumentToUserData(String data) {
  }
}
