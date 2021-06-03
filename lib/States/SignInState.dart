import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInState with ChangeNotifier {


  bool loading = false;
  final _formKey = GlobalKey<
      FormState>(); // will allow us to validate our form make sure the user doesnt f up
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String error = "";
  String email = "";
  String password = "";


  //GETTERS
  GlobalKey<FormState> get formKey => _formKey;


  SignInState() {

  }

  String validateEmail(String email) {
    if (email.isEmpty) {
      //user didn't enter email
      notifyListeners();
      return "Enter email";
    }
    //user entered email correctly
    notifyListeners();
    return null;
  }

  // ensures user types correct password
  String validatePassword(String password) {
    if (password.length < 6) {
      //user didn't enter valid password
      notifyListeners();
      return "Enter password 6 characters long";
    }
    notifyListeners();
    //user entered valid password
    return null;
  }


  signInClicked() async {
    if (_formKey.currentState.validate()) {
      // after validating if entered correct entries
      //true:false if email and correct type password entered
      loading = true;
      dynamic result = await signInWithEmailAndPassword(
          email, password); //used dynamic because could either get user or null
      if (result == null) {
        //error = "Could not sign in with those credentials";
        loading = false;
      }
    }
    notifyListeners();
  }

  // // Returns user object which contains firebaseID
  // User _userFromFireBaseUser(FirebaseUser user){
  //   return user!=null ? User(userId: user.uid) : null;
  // }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser fb_user = result.user;

      if (fb_user.isEmailVerified) {
        return fb_user;
      }
      error = "Verify Email!";
      notifyListeners();
      return null;
    }
    catch (e) {

      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
          error = "Email already registered, sign in.";
          break;

        case "ERROR_INVALID_EMAIL":
          error = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          error = "You have entered an incorrect password";
          break;
        case "ERROR_USER_NOT_FOUND":
          error = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          error = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          error = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          error = "Signing in with Email and Password is not enabled.";
          break;
        case "ERROR_NETWORK_REQUEST_FAILED":
          error = "Please check your internet connection";
          break;

        default:
          error = "An undefined Error happened. Please try again";
      }
      notifyListeners();
      return null;
    }
  }

}





