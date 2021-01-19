import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resturantapp/Home/HomeScreen.dart';
import 'package:resturantapp/Objects/Order.dart';
import 'package:resturantapp/Shared/Constants.dart';
import 'package:resturantapp/Shared/Database.dart';
import 'package:resturantapp/main.dart';

class OrderDetail extends StatefulWidget {
  Order order;

  OrderDetail({this.order});

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  int size;
  final myController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    size = widget.order.orders.length;
    print(size);
    try{
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color:Colors.red[100],
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
                          color: Colors.red[900],
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

                                      Text(
                                            "R${widget.order.orders[index].price}",
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
                              await Database().orderCompleteShop(widget.order.user, widget.order.orders[i].date);

                              await Database().orderComplete(myController.text,widget.order.orders[i].user,widget.order.orders[i].orderName);
                              //await Database().sendOrderNumber(myController.text, widget.order.docId, widget.order.orders[i].title);
                            }
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyApp())
                            );
                            print("Succesfully Completed");
                          },
                          color: Colors.purple[200],
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
