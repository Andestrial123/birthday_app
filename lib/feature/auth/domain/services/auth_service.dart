import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<void> verifyPhoneNumber();
}


class AuthServiceImpl implements AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> verifyPhoneNumber() {
    // TODO: implement verifyPhoneNumber
    throw UnimplementedError();
  }


}
