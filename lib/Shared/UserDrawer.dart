import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/Authentication/Auth.dart';
import 'package:resturantapp/Home/PreviousOrders.dart';
import 'package:resturantapp/Objects/PastOrder.dart';
import 'package:resturantapp/States/PreviousOrdersState.dart';
import 'package:provider/provider.dart';

class UserDrawer extends StatefulWidget {
  String shop;
  UserDrawer(this.shop);
  @override
  _UserDrawerState createState() => _UserDrawerState();
}


class _UserDrawerState extends State<UserDrawer> {
  PreviousOrdersState previousOrdersState = PreviousOrdersState();

  @override
  Widget build(BuildContext context) {
    previousOrdersState.shop = widget.shop;
    return Container(
      margin: EdgeInsets.only(right:80),
      color:Colors.black,
      child: ListView(
        children: <Widget>[
          Container(


            height:300,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                //color: Colors.red,
                color:Colors.white
              ),


              accountName: Padding(
                padding: const EdgeInsets.only(bottom:12),
                child: Text(
                    "Current Orders" ?? "Error Loading Current Orders",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black
                  ),
                ),
              ),
              accountEmail: GestureDetector(
                onTap:(){
                  setState(() {

                   Navigator.push(context, MaterialPageRoute(builder: (context){

                     return StreamProvider<List<PastOrder>>.value(
                       value:previousOrdersState.previousOrders(),
                         child: PreviousOrders()
                     );}));
                  });
                },
                child: Text(
                "Past Orders"?? "Error Loading Past Orders",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black
                  ),
                ),
              ),
              // currentAccountPicture:CircleAvatar(
              //   radius:50,
              //   backgroundImage:AssetImage("Picture/avatar.png") ,
              //   backgroundColor: Colors.grey[400],
              //
              //
              // ),
            ),
          ),


          Divider(
            height:5,
            color:Colors.black,
          ),
          FlatButton(
              onPressed: ()async{
                Navigator.pop(context);
                await Auth().signOut();
              },
              child: Text(
                  "Sign out",
                style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 20
                ),
              )
          ),





        ],
      ),
    );
  }
}
