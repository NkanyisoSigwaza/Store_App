
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetailState with ChangeNotifier{
  String shop;

  OrderDetail(){

  }

  // writes to OrdersRefined
  Future orderComplete(String orderNumber,String user,String orderName) async{
    Firestore.instance.collection("OrdersRefined").document(user).updateData({
      "$orderName.shopSeen":"Yes",
      "$orderName.orderNumber": orderNumber
    },);
  }

  // writes to OrdersShop
  Future orderCompleteShop(String user,dynamic date) async{

    String d = date.toDate().toString();
    int index= d.indexOf('.');
    String time = d.substring(0,index);
    Firestore.instance.collection("OrdersShops").document("OrdersShops").collection(shop).document(user).updateData({
      "$time.shopSeen":"Yes",
    },);
  }
}
