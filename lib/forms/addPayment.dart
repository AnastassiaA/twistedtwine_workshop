import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/models/expense_model.dart';
import 'package:twistedtwine_workshop/models/payment_model.dart';

class AddPayment extends StatefulWidget {
  @override
  _AddPaymentState createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final fromWhomController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Payment Type"), value: "Payment Type"),
      DropdownMenuItem(child: Text("Transfer In"), value: "Transfer In"),
      DropdownMenuItem(child: Text("Deposit"), value: "Deposit"),
      DropdownMenuItem(child: Text("Order Payment"), value: "Order Payment"),
    ];

    return menuItems;
  }

  void dispose() {
    super.dispose();
    descriptionController.dispose();
    dateController.dispose();

    amountController.dispose();
    fromWhomController.dispose();
  }

  String selectedValue = "Payment Type";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          title: Text('Add Payment'),
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
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Payment Description',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  // TextFormField(
                  //   controller: dateController,
                  //   keyboardType: TextInputType.datetime,
                  //   showCursor: true,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Date',
                  //   ),
                  // ),
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
                    controller: fromWhomController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'From:',
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
                                  content: Text('Saving Payment')));

                          await DatabaseHelper.instance.addPayment(
                            PaymentModel(
                                description: descriptionController.text,
                                date: DateTime.parse(dateController.text),
                                type: selectedValue,
                                amount: double.parse(amountController.text),
                                fromWhom: fromWhomController.text),
                          );
                          if (!mounted) return;
                          Navigator.pop(context);
                        },
                        child: Text("add payment"),
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
