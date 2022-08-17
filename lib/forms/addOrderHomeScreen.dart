import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/forms/addOrder.dart';
import 'package:twistedtwine_workshop/models/order_model.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../home page.dart';

class AddOrderFormHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddOrderState();
  }
}

class AddOrderState extends State<AddOrderFormHomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final orderNameController = TextEditingController();
  final customerContactController = TextEditingController();
  final craftTypeController = TextEditingController();
  final statusController = TextEditingController();
  final descriptionController = TextEditingController();

  String dropdownValue = 'None';

  // void countOrders() async {
  //     int? count = await DatabaseHelper.instance.numberOfOrders();
  //     setState(() {
  //       var pendingOrdersNumber = count;
  //     });
  //     print(pendingOrdersNumber);
  //   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          title: Text('Add Orders Home Screen'),
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
                    controller: orderNameController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  // TextFormField(
                  //   controller: customerContactController,
                  //   keyboardType: TextInputType.text,
                  //   showCursor: true,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Customer Contact',
                  //   ),
                  //   //onChanged: (text) {
                  //   //threadNumberController.text = _generateThreadNumber(text);
                  //   //},
                  // ),
                  TextButton(
                    //title: Text("${contact.name.first}"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FlutterContactsExample()),
                      );

                      setState(() {
                        ListTile(
                          title: Text(""),
                        );
                      });
                    },
                    child: Text('Contact'),
                  ),

                  TextFormField(
                    controller: craftTypeController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Craft Type',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  TextFormField(
                    controller: statusController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      //TODO: dropdown menu
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Saving order')));

                            await DatabaseHelper.instance.addOrder(
                              OrderModel(
                                  description: descriptionController.text,
                                  status: statusController.text,
                                  customer: customerContactController.text,
                                  orderName: orderNameController.text,
                                  craftType: craftTypeController.text),
                            );

                            await DatabaseHelper.instance.numberOfOrders();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          },
                          child: Text("add order"),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String generateOrderNumber(String typeChoice) {
    Random random = new Random();
    int number = random.nextInt(1000000);

    String typeLetter = typeChoice.substring(0, 1);

    String orderNumber = typeLetter + number.toString().padLeft(6, '0');

    return orderNumber;
  }
}

class FlutterContactsExample extends StatefulWidget {
  @override
  _FlutterContactsExampleState createState() => _FlutterContactsExampleState();
}

class _FlutterContactsExampleState extends State<FlutterContactsExample> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          //appBar: AppBar(title: Text('flutter_contacts_example')),
          body: _body()));

  Widget _body() {
    if (_permissionDenied) return Center(child: Text('Permission denied'));
    if (_contacts == null) return Center(child: CircularProgressIndicator());
    return ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, i) => ListTile(
            title: Text(_contacts![i].displayName),
            onTap: () async {
              final fullContact =
                  await FlutterContacts.getContact(_contacts![i].id);
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ContactPage(fullContact!)));
            }));
  }
}

class ContactPage extends StatelessWidget {
  final Contact contact;
  ContactPage(this.contact);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Column(children: [
        Text('First name: ${contact.name.first}'),
        Text('Last name: ${contact.name.last}'),
        Text(
            'Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
        Text(
            'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
      ]));
}
