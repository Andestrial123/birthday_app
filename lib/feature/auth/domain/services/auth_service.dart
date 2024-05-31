import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<void> verifyPhoneNumber(String phoneNumber);

  Future<User?> signInWithPhoneNumber(String otp);

  User? get currentUser;

  void signOut();
}

class AuthServiceImpl implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _verId = "";

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber ?? "",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        _verId = verificationId;
      },
      verificationFailed: (FirebaseAuthException error) {
        if (error.code == 'invalid-phone-number') {
          print(error.message);
        } else {
          print(error.message);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        _verId = verificationId;
      },
    );
  }

  void signOut(){
    _firebaseAuth.signOut();
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInWithPhoneNumber(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verId,
        smsCode: otp ?? '',
      );
      final result = await _firebaseAuth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
