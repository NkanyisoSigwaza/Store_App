import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:resturantapp/Home/OrderDetail.dart';
import 'package:resturantapp/Objects/CustomerOrder.dart';
import 'package:resturantapp/Objects/Order.dart';
import 'package:resturantapp/Shared/UserDrawer.dart';
import 'package:soundpool/soundpool.dart';
import 'package:screen/screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  Playsound()async{

    Soundpool pool = Soundpool(streamType: StreamType.notification);

    int soundId = await rootBundle.load("sounds/01-macklemore-aint_gonna_die_tonight.mp3").then((ByteData soundData) {
      return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }

  @override
  Widget build(BuildContext context) {
    Screen.keepOn(true);// keeps screen alive 
    final orders = Provider.of<List<Order>>(context);
   // print(orders);
    if (orders == null) {
      return Container(
          child: Text("")
      );
    }
    else {
      Playsound();



    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: Text("Orders"),
          centerTitle: true,
          backgroundColor: Colors.red[900],
        ),
      ),
      drawer: UserDrawer(),
      body: Container(
        color: Colors.red[900],
        child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(

                      title: Text("Order ${index}"),
                      onTap: () {




                        //Navigator.of(context).pop();//closes menu in home pAGE
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderDetail(order: orders[index]))
                        );

                      },
                    ),
                  ),

                ),
              );
            }),
      ),

    );
  }
}
}
