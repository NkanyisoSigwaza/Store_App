import 'package:firebase_auth/firebase_auth.dart';
class Auth {
  //allows us to use firebase authentication -- line below

  final FirebaseAuth _auth = FirebaseAuth
      .instance; //_ means private in variable auth

  String uid;


  bool showSignIn = true;


  Stream<FirebaseUser> get user {
    //tells us each time user signs in / out
    return _auth.onAuthStateChanged;
  }


  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch (e) {
      return null;
    }
  }

  Future inputData() async {
    final FirebaseUser user = await _auth.currentUser();

    return user.uid;
    // here you write the codes to input the data into firestore
  }

}