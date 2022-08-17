import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/forms/addOrder.dart';
import 'package:twistedtwine_workshop/tabs/order_tab.dart';
import '../drawer.dart';
//===============================================//

class OrderHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Orders'),
        ),
        drawer: MyDrawer(),
        body: OrderList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff997ABD),
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddOrderForm()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
