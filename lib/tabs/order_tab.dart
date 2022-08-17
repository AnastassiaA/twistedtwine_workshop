import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/cards/order_card.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/models/order_model.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() {
    return _OrderListState();
  }
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.getOrder(),
      builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                OrderModel _model = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[350],
                      radius: 30,
                    ),
                    title: Text(_model.orderName),
                    subtitle: Text(_model.customer),
                    trailing: Text(_model.status),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Orders(),
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: Text('No Orders added'),
          );
        }
      },
    );
  }
}
