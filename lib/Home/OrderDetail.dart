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
        body: Column(
          children: [
            SafeArea(
              child: Center(
                child: Text(
                    widget.order.docId,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.underline,

                  ),
                ),
              ),
            ),
            ListView.builder(
                itemCount: size,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                        title: Text(widget.order.orders[index].title),
                        subtitle: Text("R${widget.order.orders[index].price}"),

                      )
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: myController,
                decoration: textInputDecoration.copyWith(hintText: "Order number"),
                //initialValue: "Order Number",
              ),
            ),
            SizedBox(
              height:60,
            ),
            Center(
              child: FlatButton(
                child: Text("Order Registered"),
                onPressed: ()async{

                  for(int i=0;i<widget.order.orders.length;i++){

                    await Database().orderComplete(myController.text,widget.order.orders[i].docId,widget.order.orders[i].title);
                    //await Database().sendOrderNumber(myController.text, widget.order.docId, widget.order.orders[i].title);
                  }
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp())
                  );
                  print("Succesfully Completed");
                },
                color: Colors.green,
              ),
            ),
          ],

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
