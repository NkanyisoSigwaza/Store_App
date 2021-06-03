import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resturantapp/Home/HomeScreen.dart';
import 'package:resturantapp/Navigate/Wrapper.dart';
import 'package:resturantapp/Objects/Order.dart';
import 'package:resturantapp/Shared/Constants.dart';

import 'package:resturantapp/States/HomeScreenState.dart';
import 'package:resturantapp/States/OrderDetailState.dart';
import 'package:resturantapp/main.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  Order order;
  String shop;

  OrderDetail({this.order,this.shop});

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  int size;
  final myController = TextEditingController();

  OrderDetailState orderDetailState = OrderDetailState();


  @override
  Widget build(BuildContext context) {
    orderDetailState.shop = widget.shop;
    size = widget.order.orders.length;

    try{
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          //color:Colors.red[100],
          color: Colors.black,
          child: SingleChildScrollView(

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SafeArea(
                    child: Center(
                      child: Text(
                          "New Order ;)",
                        style: TextStyle(
                          fontSize: 30,
                          //color: Colors.red[900],
                          color: Colors.white,
                          letterSpacing: 3,


                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height:MediaQuery.of(context).size.height/2,
                  width: double.infinity,
                  child: ListView.builder(

                      itemCount: size,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(

                            child: Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child:Text(
                                            widget.order.orders[index].orderName,
                                          style:TextStyle(
                                            fontSize: MediaQuery.of(context).size.width/16
                                          )
                                        ),
                            ),
                                      for(String option in widget.order.orders[index].mealOptions.split(","))
                                        if(widget.order.orders[index].mealOptions.split(",").length>1)
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                              option ?? '',
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width/22
                                            ),
                                          ),
                                        ),
                                      //Text(),




                                      Text(
                                            "R${(widget.order.orders[index].price*widget.order.orders[index].quantity).toStringAsFixed(2)}",
                                            style:TextStyle(
                                                fontSize: MediaQuery.of(context).size.width/18
                                            )
                                        ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                        "quantity: ${widget.order.orders[index].quantity}",
                                        style:TextStyle(
                                            fontSize: MediaQuery.of(context).size.width/18
                                        )
                                    ),




                                  ],
                                )
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: myController,
                          decoration: textInputDecoration.copyWith(hintText: "Order number"),

                        ),
                      ),
                      SizedBox(
                        height:MediaQuery.of(context).size.height/70,
                      ),
                      Center(
                        child: FlatButton(
                          child: Text("Order Registered"),
                          onPressed: ()async{

                            for(int i=0;i<widget.order.orders.length;i++){
                              await orderDetailState.orderCompleteShop(widget.order.user, widget.order.orders[i].date);

                              await orderDetailState.orderComplete(myController.text,widget.order.orders[i].user,widget.order.orders[i].orderName);
                              //await Database().sendOrderNumber(myController.text, widget.order.docId, widget.order.orders[i].title);
                            }
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                             MaterialPageRoute(builder: (context) => StreamProvider<List<Order>>.value(
                               value:HomeScreenState().ordersFromThisShop(widget.shop),
                                 child: HomeScreen())
                             )
                            );

                          },
                          //color: Colors.purple[200],
                          color: Colors.white,
                        ),
                      ),
                      // SizedBox(
                      //   height:MediaQuery.of(context).size.height/50,
                      // ),

                    ],
                  ),
                ),


              ],

            ),
          ),
        ),
      );
    }
    catch(e){

        return Container(
            child:Text("Waaahhh")
        );

    }
  }
}
