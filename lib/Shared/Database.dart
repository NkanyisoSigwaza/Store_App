import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resturantapp/Objects/Order.dart';
class Database{

  List<Order> _resturantOrders(QuerySnapshot snapshot){
  List<Order> orders =[];
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
          if (value["inActive"] ==1 && value["restaurant"]=="Dine with us" && value["checkOut"]=="Yes" && value["restaurantSeen"] ==null) {
            inActive++;
            n++;


                title = value["title"];
                price = value["price"];
                quantity = value["quantity"];


                if (n == 1) {
                  order = Order(
                      docId: doc.documentID,
                      title: title,
                      price: price,
                      quantity: quantity
                  );
                }

                try {
                  order.addOrder(title, price, quantity, doc.documentID);
                }
                catch(e){
                  print("Buka Nka $e");
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


  Future orderComplete(String orderNumber,String doc,String title) async{
    Firestore.instance.collection("OrdersRefined").document(doc).updateData({
      "$title.restaurantSeen":"Yes",
      "$title.orderNumber": orderNumber
    },);
  }





}