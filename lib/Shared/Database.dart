import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:resturantapp/Objects/CustomerOrder.dart';
import 'package:resturantapp/Objects/Order.dart';
import 'package:resturantapp/Objects/PastOrder.dart';
import 'package:soundpool/soundpool.dart';
class Database{

  List<Order> _resturantOrders(QuerySnapshot snapshot){
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
          // I AM HARD CODED FIXXXX  ME!!!!!!!!!!!!
          if (value["inActive"] ==1 && value["restaurant"]=="Dine with us" && value["checkOut"]=="Yes" && value["restaurantSeen"] ==null) {

            inActive++;
            n++;


                orderName = value["title"];
                price = value["price"];
                quantity = value["quantity"];


                if (n == 1) {
                  order = Order(
                      user: doc.documentID,
                      orderName: orderName,
                      price: price,
                      quantity: quantity
                  );
                }

                try {
                 // order.addOrder(orderName, price, quantity, doc.documentID);
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
    return orders;

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
        // I AM HARD CODED FIXXXX  ME!!!!!!!!!!!!
        if (value["active"] ==1) {
          inActive++;
          n++;



          orderName = value["title"];
          price = value["price"];
          quantity = value["quantity"];


          if (n == 1) {
            order = Order(
                user: value["user"],
                orderName: orderName,
                price: price,
                quantity: quantity,
                date: value['date']
            );
          }

          try {
            order.addOrder(
              orderName: orderName,
              price: price,
              quantity: quantity,
              user: value['user'],
              date: value['date']
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
    return orders;
  }

  Stream<List<Order>> ordersFromResturant(){
    //returns snapshot of database and tells us of any changes [provider]
    return Firestore.instance.collection("OrdersRefined").snapshots().map(_resturantOrders);
  }

  Stream<List<Order>> ordersFromThisShop(){
    //returns snapshot of database and tells us of any changes [provider]
    return Firestore.instance.collection("OrdersShops").document("OrdersShops").collection("Food and Connect").snapshots().map(_ordersFromShop);

  }

  Future orderComplete(String orderNumber,String user,String orderName) async{
    Firestore.instance.collection("OrdersRefined").document(user).updateData({
      "$orderName.restaurantSeen":"Yes",
      "$orderName.orderNumber": orderNumber
    },);
  }

  Future orderCompleteShop(String user,dynamic date) async{

    String d = date.toDate().toString();
    int index= d.indexOf('.');
    String time = d.substring(0,index);
    Firestore.instance.collection("OrdersShops").document("OrdersShops").collection("Food and Connect").document(user).updateData({
      "$time.active":0,
    },);
  }


  List<PastOrder>_pastOrders(QuerySnapshot snapshot){
    List<PastOrder> pastOrders = [];


    Order order ;
    String title;
    int quantity;
    double price;
    //doc == each user
    snapshot.documents.forEach((doc) {
      int n=0;
      int inActive=0;
      // value == actual order
      doc.data.values.forEach((value) {

        //place any restrictions here...
        // I AM HARD CODED FIXXXX  ME!!!!!!!!!!!!
        if (value["inActive"] ==0 && value["shop"]=="Food and Connect" && value["checkOut"]=="Yes" && value["restaurantSeen"] =="Yes") {
          print("hello");
          inActive++;
          n++;

          title = value["title"];
          price = value["price"];
          quantity = value["quantity"];



          pastOrders.add(
            PastOrder(
              orderName: title,
              price:price,
              quantity: quantity,
              date:value['date'].toDate()
            )
          );



        }


      });







    });
    print(pastOrders.length);
    return pastOrders;


  }

  Stream<List<PastOrder>> previousOrders(){
    return Firestore.instance.collection("OrdersRefined").snapshots().map(_pastOrders);

  }





}