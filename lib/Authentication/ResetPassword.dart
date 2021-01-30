import 'package:flutter/material.dart';
import 'package:resturantapp/Authentication/SignIn.dart';
import 'package:resturantapp/Shared/Constants.dart';
import 'package:resturantapp/States/ResetPasswordState.dart';

import '../main.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  ResetPasswordState _resetPasswordState = ResetPasswordState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Reset Password"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text("Forgot your password?"),
            ),
            TextFormField(
              decoration:
              textInputDecoration.copyWith(hintText: "Email"),
              controller: _resetPasswordState.email,


            ),
            FlatButton(
              child: Text("Submit"),
              onPressed: ()async{
                await _resetPasswordState.resetPassword();
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>MyApp()
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

