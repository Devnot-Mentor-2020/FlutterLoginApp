import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignHelper{
  static GoogleSignHelper _instance = GoogleSignHelper._private();
  GoogleSignHelper._private();

  static GoogleSignHelper get instance => _instance;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Future<GoogleSignInAccount> signIn() async {
    final user = await _googleSignIn.signIn();
    if(user != null){
      print(user.email);
      return user;
    }
    else{
      return null;
    }
  }

  Future<GoogleSignInAuthentication> googleAuthenticate() async {
    if(await _googleSignIn.isSignedIn()){
      final user = _googleSignIn.currentUser;
      final userData = await user.authentication;
      print(userData.accessToken);
      return userData;
    }
    return null;
  }

  Future<GoogleSignInAccount> signOut() async {
    final user = await _googleSignIn.signOut();
    if(user != null){
      print(user.email);
      return user;
    }
    else{
      return null;
    }
  }

  Future<bool> isSignedIn() async{
    final bool = _googleSignIn.isSignedIn();
    print(bool);
    return bool;
  }
}