import 'package:flutter/material.dart';
import 'package:resturantapp/Authentication/ResetPassword.dart';
import 'package:resturantapp/Shared/Constants.dart';
import 'package:resturantapp/Shared/Loading.dart';
import 'package:resturantapp/States/SignInState.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
class SignIn extends StatefulWidget {



  SignIn();

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  Widget build(BuildContext context) {

    final singInState = Provider.of<SignInState>(context);


    //if loading is true  return loading widget
    return singInState.loading? Loading() :Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: HexColor("#393939"),
      body: Align(
        alignment: Alignment.center
        ,
        child: SingleChildScrollView(
          child: Container(

            padding:EdgeInsets.symmetric(vertical:0,horizontal: 50),
            child: Column(
              children: [



                Container(
                    height: MediaQuery.of(context).size.height*0.5,
                    width: MediaQuery.of(context).size.width*0.6,

                    child:Image(
                      image:AssetImage(
                          "Picture/HalaLogo.jpeg"
                      ),
                    )
                ),

                Form(
                  key:singInState.formKey,
                  child:Column(
                    children: <Widget>[
                      SizedBox(
                        height:20,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Email") ,
                        validator: (val){
                          return singInState.validateEmail(val);
                        },
                        onChanged: (val){
                          //returns a value each time the user types or deletes something
                          setState(() {
                            singInState.email = val;
                          });
                        },

                      ),
                      SizedBox(
                          height:20
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Password"),
                        validator: (val) {
                          return singInState.validatePassword(val);
                        },
                        obscureText: true,// encrypts password
                        onChanged: (val){
                          //returns a value each time the user types or deletes something
                          setState(() {
                            singInState.password = val;
                          });
                        },

                      ),
                      SizedBox(
                        height:25,

                      ),
                      Text(
                        singInState.error,
                        style:TextStyle(
                          color:Colors.red,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height:25,

                      ),
                      OutlineButton(
                        borderSide: BorderSide(
                            color:Colors.grey
                        ),

                        shape:RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed:() async{

                          singInState.signInClicked();

                        },
                        color:Colors.black,
                        child:Text(
                          "Sign in",
                          style:TextStyle(
                            color:Colors.white,
                          ),
                        ),
                      ),



                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: FlatButton(
                      color: HexColor("#393939"),
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                      } , child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        color:Colors.amber
                    ),
                  )),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
