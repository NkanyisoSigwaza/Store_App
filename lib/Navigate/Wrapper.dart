
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp/Authentication/SignIn.dart';
import 'package:resturantapp/Home/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resturantapp/Objects/Order.dart';
import 'package:resturantapp/Objects/PastOrder.dart';
import 'package:resturantapp/Shared/Loading.dart';
import 'package:resturantapp/States/HomeScreenState.dart';
import 'package:resturantapp/States/PreviousOrdersState.dart';
import 'package:resturantapp/States/SignInState.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String shop;
  int n = 0;

  @override
  Widget build(BuildContext context) {






    dynamic user = Provider.of<FirebaseUser>(context); // acessing user data from




      if (user==null){
        // user not signed in
        return ChangeNotifierProvider.value(
          value: SignInState(),
            child: SignIn()
        );
      }
      else{
        if(n ==0){
          HomeScreenState().getShopName().then((value){
            setState(() {
              print("value: $value");
              shop = value;
            });
          });

        }


        print('shop is : $shop');
        // Bastard signed in!
        if(shop !=null){
          setState(() {
            n=1;
          });
        return  MultiProvider(
            providers: [
              StreamProvider<List<Order>>.value(value:HomeScreenState().ordersFromThisShop(shop)),

            ],
            child: HomeScreen(shop: shop,)
        );}
        else{
          print("Said null : $shop");
          return Loading();
        }
      }


  }
}
