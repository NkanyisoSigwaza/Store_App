
import 'package:flutter/cupertino.dart';
import 'package:resturantapp/Objects/Order.dart';
import 'package:resturantapp/Objects/PastOrder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PreviousOrdersState with ChangeNotifier{
  double answer;
  String shop;

  PreviousOrdersState(){


  }

  // calculates price of all past orders
  double totalAmount(List<PastOrder> orders){
    answer = 0;
    for(int i=0;i<orders.length;i++){
      answer+=orders[i].price*orders[i].quantity;
    }
    notifyListeners();
    return answer;
  }

  List<PastOrder>_pastOrders(QuerySnapshot snapshot){
    List<PastOrder> pastOrders = [];


    Order order ;
    String title;
    int quantity;
    double price;
    //doc == each user
    try {
      snapshot.documents.forEach((doc) {
        int n = 0;
        int inActive = 0;
        // value == actual order
        doc.data.values.forEach((value) {
          //place any restrictions here...
          // CHANGE SHOP HERE!
          print("active: ${value["active"]}, shop: $shop");
          if (value["active"] == 0 && value["shop"] == shop) {
            inActive++;
            n++;

            title = value["title"];
            price = value["price"];
            quantity = value["quantity"];
            pastOrders.add(
                PastOrder(
                    orderName: title,
                    price: price,
                    quantity: quantity,
                    date: value['date'].toDate()
                )
            );
            print(" Added past order: $title");
          }
        });
      });
    }
    catch(e){
      print(e);
    }

   print(" These are the past orders ${pastOrders}");
    return pastOrders;
  }

  Stream<List<PastOrder>> previousOrders(){
    print("Entered stream");
    return Firestore.instance.collection("OrdersRefined").snapshots().map(_pastOrders);

  }

}
