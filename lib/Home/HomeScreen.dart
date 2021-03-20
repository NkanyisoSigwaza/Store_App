import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:resturantapp/Home/OrderDetail.dart';
import 'package:resturantapp/Objects/CustomerOrder.dart';
import 'package:resturantapp/Objects/Order.dart';
import 'package:resturantapp/Objects/PastOrder.dart';
import 'package:resturantapp/Shared/UserDrawer.dart';
import 'package:resturantapp/States/HomeScreenState.dart';
import 'package:resturantapp/States/PreviousOrdersState.dart';

import 'package:screen/screen.dart';


class HomeScreen extends StatefulWidget {
  String shop;
  HomeScreen({this.shop});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {





  @override
  Widget build(BuildContext context) {
    Screen.keepOn(true);// keeps screen alive 
    final orders = Provider.of<List<Order>>(context);
   // print(orders);
    if (orders == null) {
      return Container(
          child: Text("")
      );
    }
    else {
      HomeScreenState().playAudio("sounds/weDemBoys.mp3");
      HomeScreenState().Playsound();




    return StreamProvider<List<PastOrder>>.value(
        value:PreviousOrdersState().previousOrders(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            title: Text("Orders"),
            centerTitle: true,
            //backgroundColor: Colors.red[900],
            backgroundColor: Colors.black,
          ),
        ),
        drawer: UserDrawer(widget.shop),
        body: Container(
          //color: Colors.red[900],
          color: Colors.black,
          child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    //color: Colors.grey[300],
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(

                        title: Text("Order ${index}"),
                        onTap: () {




                          //Navigator.of(context).pop();//closes menu in home pAGE
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrderDetail(order: orders[index],shop: widget.shop,))
                          );

                        },
                      ),
                    ),

                  ),
                );
              }),
        ),

      ),
    );
  }
}
}
