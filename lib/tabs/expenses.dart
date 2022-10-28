import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/cards/expense_card.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/forms/addExpense.dart';
import 'package:twistedtwine_workshop/models/expense_model.dart';

class ExpenseHome extends StatefulWidget {
  @override
  ExpenseState createState() {
    return ExpenseState();
  }
}

class ExpenseState extends State<ExpenseHome> {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        body: FutureBuilder(
          future: DatabaseHelper.instance.getExpense(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ExpenseModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ExpenseModel _model = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[350],
                        radius: 30,
                        //child: Image.asset('images/default_image.png'),
                      ),
                      title: Text(_model.expenseName),
                      subtitle: Text(_model.type),
                      trailing: Text('\$' + _model.amount.toString()),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Expense(),
                        ),
                      ),
                    ),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    //margin: ,
                  );
                },
              );
            }
            return Center(
              child: Text('No Expense added'),
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
              MaterialPageRoute(builder: (context) => const AddExpense()),
            );
          },
        ),
      ),
    );
  }
}
