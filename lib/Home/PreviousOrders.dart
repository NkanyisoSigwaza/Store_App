import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturantapp/Objects/Order.dart';

import 'package:provider/provider.dart';
import 'package:resturantapp/Objects/PastOrder.dart';
import 'package:resturantapp/Shared/Loading.dart';
import 'package:resturantapp/States/PreviousOrdersState.dart';

class PreviousOrders extends StatefulWidget {
  String shop;
  PreviousOrders({this.shop});
  @override
  _PreviousOrdersState createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends State<PreviousOrders> {
  

  @override
  Widget build(BuildContext context) {

    final pastOrders = Provider.of<List<PastOrder>>(context);



    return pastOrders==null ? Loading(

    ): Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:Text(
            "Previous Orders",
          style: TextStyle(
            fontSize: 25,
           // color: Colors.red[200],
            color:Colors.white,
            letterSpacing: 3,
          ),
        )
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        //color: Colors.red[100],
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                 // color: Colors.red[200],
                  color:Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                            "Total number of orders: ${pastOrders.length}",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 2
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            "Total amount: R${PreviousOrdersState().totalAmount(pastOrders).toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 2
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height/1.5,
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount:pastOrders.length,
                    itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Date: ${pastOrders[index].date.day.toString()} ${pastOrders[index].date.month.toString()} ${pastOrders[index].date.year.toString()}'),
                            SizedBox(height: 5),
                            Text('Order: ${pastOrders[index].orderName}'),
                            SizedBox(height: 5),
                            Text("price: ${pastOrders[index].price.toString()}"),
                            SizedBox(height: 5),
                            Text("quantity: ${pastOrders[index].quantity.toString()}")

                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      )
    );
  }
}
