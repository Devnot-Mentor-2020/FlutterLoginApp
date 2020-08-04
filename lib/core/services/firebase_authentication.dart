import 'package:firebase_auth/firebase_auth.dart';
import 'file:///C:/Users/Alperen/IdeaProjects/loginapp/lib/core/services/base_authentication.dart';

class FirebaseAuthentication implements BaseAuthentication {
  static FirebaseAuthentication _instance = FirebaseAuthentication._private();
  FirebaseAuth _firebaseAuth;

  FirebaseAuthentication._private(){
    _firebaseAuth = FirebaseAuth.instance;
  }

  static FirebaseAuthentication get instance => _instance;

  Future<String> signIn(String email, String password) async {
    _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password).then((value){
          print(value);
    }).catchError((e){
      print(e);
    });
    try{
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    }
    catch(e){
      print(e);
    }

    print("burda calıstı");

  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}