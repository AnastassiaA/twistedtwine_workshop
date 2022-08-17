import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/models/expense_model.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();

  final expenseNameController = TextEditingController();
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final paidToController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Expense Type"), value: "Expense Type"),
      DropdownMenuItem(child: Text("Transfer Out"), value: "Transfer Out"),
      DropdownMenuItem(child: Text("Materials"), value: "Materials"),
      DropdownMenuItem(child: Text("Tools"), value: "Tools"),
      DropdownMenuItem(child: Text("Transportation"), value: "Transportation"),
    ];

    return menuItems;
  }

  void dispose() {
    super.dispose();
    expenseNameController.dispose();
    dateController.dispose();
    amountController.dispose();
    paidToController.dispose();
  }

  String selectedValue = "Expense Type";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          title: Text('Add Expense'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: expenseNameController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Expense Description',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  Stack(
                    children: [
                      DateTimePicker(
                        controller: dateController,
                        initialValue: null,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Date',
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      )
                    ],
                  ),
                  DropdownButtonFormField(
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: dropdownItems),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                    ),
                  ),
                  TextFormField(
                    controller: paidToController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Paid To',
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        //style: ,
                        onPressed:
                            //TODO: Refresh list tile on pressed
                            () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text('Saving Expense')));

                          await DatabaseHelper.instance.addExpense(
                            ExpenseModel(
                                expenseName: expenseNameController.text,
                                date: DateTime.parse(dateController.text),
                                type: selectedValue,
                                amount: double.parse(amountController.text),
                                paidTo: paidToController.text),
                          );
                          Navigator.pop(context);
                        },
                        child: Text("add expense"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
