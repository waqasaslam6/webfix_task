import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticationProvider {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //Constuctor to initalize the FirebaseAuth instance

    final fbAuth = FacebookAuth.instance;
  //Using Stream to listen to Authentication State
  Stream<User> get authState => firebaseAuth.idTokenChanges();

  Future<Map<String,dynamic>> get userData => fbAuth.getUserData();


  //SIGN IN METHOD
  //Future<UserCredential>
   signInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(result.token);
    // Once signed in, return the UserCredential
    await firebaseAuth.signInWithCredential(facebookAuthCredential);
    return "Signed in!";
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

}