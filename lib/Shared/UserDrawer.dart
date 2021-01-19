import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/Home/PreviousOrders.dart';

class UserDrawer extends StatefulWidget {
  @override
  _UserDrawerState createState() => _UserDrawerState();
}


class _UserDrawerState extends State<UserDrawer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right:80),
      color:Colors.black,
      child: ListView(
        children: <Widget>[
          Container(


            height:300,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),


              accountName: Padding(
                padding: const EdgeInsets.only(bottom:12),
                child: Text(
                    "Current Orders" ?? "Error Loading Current Orders",
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
              ),
              accountEmail: GestureDetector(
                onTap:(){
                  setState(() {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => PreviousOrders()));
                  });
                },
                child: Text(
                "Past Orders"?? "Error Loading Past Orders",
                  style: TextStyle(
                      fontSize: 25
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

          ListTile(
            title:Text(
              "Sign out",
              style: TextStyle(
                  color:Colors.red
              ),
            ),
            onTap: () {
              //Auth().signOut();
              Navigator.of(context).pop(); //closes menu in home pAGE
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => Wrapper())
              //   );
              // },
            },
          ),
          Divider(
            height:5,
            color:Colors.black,
          ),





        ],
      ),
    );
  }
}
