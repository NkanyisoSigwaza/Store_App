

class Order{
  String user;
  String orderName;
  int quantity;
  double price;
  List<Order> orders=[];
  dynamic date;

  Order({this.orderName,this.quantity,this.price,this.user,this.date});



  void addOrder({String orderName, double price,int quantity,String user,dynamic date}){

    try {
      orders.add(Order(
          orderName: orderName,
          quantity: quantity,
          price: price,
          user: user,
          date: date
      ));
    }
    catch(e){
      print("This side $e");
    }

}



}