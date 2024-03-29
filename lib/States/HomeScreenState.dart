
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:resturantapp/Authentication/Auth.dart';
import 'package:resturantapp/Objects/Order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundpool/soundpool.dart';
import 'dart:js' as js;


class HomeScreenState with ChangeNotifier{

  //Haven't used changeNotifier yet

HomeScreenState(){

}


// sound for web
void playAudio(String path) {
  // only works for web platform
  print("method called");
  if(kIsWeb) {
    print("Kis web");

    js.context.callMethod('playAudio', [path]);

  }


}
List<Order>_ordersFromShop(QuerySnapshot snapshot){
  List<Order> orders =[];
  Order order ;
  String orderName;
  int quantity;
  double price;
  //doc == each user
  snapshot.documents.forEach((doc) {
    int n=0;
    int inActive=0;
    // value == actual order
    doc.data.values.forEach((value) {

      //place any restrictions here...
      // all active orders

      if (value["active"] ==1 && value['shopSeen'] == "No") {
        inActive++;
        n++;


        //dynamic mealOptions = value['mealOptions'];



        orderName = value["title"];
        price = value["price"].toDouble();
        quantity = value["quantity"];


        if (n == 1) {
          order = Order(
              user: value["user"],
              orderName: orderName,
              price: price.toDouble(),
              quantity: quantity,
              date: value['date'],
              mealOptions: value['mealOptions'] ?? ""

          );
        }

        try {

          order.addOrder(
              orderName: orderName,
              price: price,
              quantity: quantity,
              user: value['user'],
              date: value['date'],
            mealOptions: value['mealOptions'] ?? ""

          );


        }
        catch(e){

          print("Error $e");
        }
      }
    });

    if(inActive>0) {
      orders.add(order);
    }

  });
  print(orders.length);
  notifyListeners();
  return orders;
}



Stream<List<Order>> ordersFromThisShop(String shop){
  //returns snapshot of database and tells us of any changes [provider]
  //Change shop for every different shop
  print(shop);


  try {
    return  Firestore.instance.collection("OrdersShops").document("OrdersShops").collection(shop).snapshots().map(_ordersFromShop);
  } on Exception catch (e) {
    print("Error failed $e");
    // TODO
  }

}

Future<String>getShopName()async{
  DocumentSnapshot doc;
  String shop;
  dynamic uid = await Auth().inputData();
  doc= await  Firestore.instance.collection('Shops').document(uid).get();
  shop = doc.data['shop'];
  return shop;
}

}