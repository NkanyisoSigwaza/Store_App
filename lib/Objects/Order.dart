

class Order{
  String docId;
  String title;
  int quantity;
  double price;
  List<Order> orders=[];

  Order({this.title,this.quantity,this.price,this.docId});



  void addOrder(String title, double price,int quantity,docId){

    try {
      orders.add(Order(
          title: title,
          quantity: quantity,
          price: price,
          docId: docId
      ));
    }
    catch(e){
      print("This side $e");
    }

}



}