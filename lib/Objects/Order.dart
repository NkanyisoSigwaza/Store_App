

class Order{
  String user;
  String orderName;
  int quantity;
  double price;
  List<Order> orders=[];
  dynamic date;
  String mealOptions;

  Order({this.orderName,this.quantity,this.price,this.user,this.date,this.mealOptions});



  void addOrder({String orderName, double price,int quantity,String user,dynamic date,String mealOptions}){

    try {
      orders.add(Order(
          orderName: orderName,
          quantity: quantity,
          price: price,
          user: user,
          date: date,
          mealOptions: mealOptions

      ));
    }
    catch(e){

    }

}



}