import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/cards/paymentCard.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/forms/addPayment.dart';
import 'package:twistedtwine_workshop/models/payment_model.dart';
import 'package:intl/intl.dart';

class PaymentsHome extends StatefulWidget {
  @override
  PaymentState createState() {
    return PaymentState();
  }
}

class PaymentState extends State<PaymentsHome> {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        // appBar: AppBar(
        //   backgroundColor: const Color(0xff693b58),
        //   foregroundColor: Colors.white,
        //   title: const Text('Expenses'),
        // ),
        // drawer: MyDrawer(),
        body: FutureBuilder(
          future: DatabaseHelper.instance.getPayment(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PaymentModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  PaymentModel _model = snapshot.data![index];
                  return Column(
                    children: [
                      Container(
                        child: Text(
                          DateFormat("MM-dd-yyyy").format(_model.date),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[350],
                            radius: 30,
                            //child: Image.asset('images/default_image.png'),
                          ),
                          title: Text(_model.fromWhom),
                          subtitle: Text(_model.description),
                          trailing: Text('\$' + _model.amount.toString()),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Payment(),
                            ),
                          ),
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        //margin: ,
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
              child: Text('No Payment added'),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff540E32),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPayment()),
            );
          },
        ),
        // body: ListView.builder(
        //   itemCount: items.length,
        //   itemBuilder: (context, index) {
        //     return ListTile(
        //       title: Text('${items[index]}'),
        //     );
        //   },
        // ),
      ),
    );
  }
}
