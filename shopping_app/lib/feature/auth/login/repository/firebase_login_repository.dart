
import 'package:shopping_app/feature/auth/login/repository/login_repository.dart';
import 'package:shopping_app/feature/auth/model/user_app.dart';

class FirebaseLoginRepository extends LoginRepository{


  FirebaseLoginRepository(){
  }

  @override
  Future<bool> isSignedIn() async{
  }

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      print('$email - $password');
    } on Exception catch(e) {
      print(e);
      return false;
    }
  }

  Future<void> updateUserData(UserData userData) async {
  }

  Future<bool> register(UserData userData) async {

  }

}