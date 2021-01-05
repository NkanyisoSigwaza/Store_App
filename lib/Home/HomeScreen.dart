import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:resturantapp/Home/OrderDetail.dart';
import 'package:resturantapp/Objects/Order.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context);
   // print(orders);
    if (orders == null) {
      return Container(
          child: Text("")
      );
    }
    else {


    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {

              return Card(
                child: ListTile(

                  title: Text("${orders[index].docId}"),
                  onTap: () {
                    //Navigator.of(context).pop();//closes menu in home pAGE
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderDetail(order: orders[index]))
                    );

                  },
                ),

              );
            }),
      ),

    );
  }
}
}
