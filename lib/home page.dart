import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_code/databaseUtilities.dart';
import 'drawer.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<int>(
          create: (context) => DatabaseHelper.instance.numberOfOrders(),
          initialData: 0,
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => DatabaseHelper.instance,
        ),
        ChangeNotifierProvider(
          create: (context) => DatabaseHelper.instance,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

@immutable
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double businessWalletBalance = 0.00;
  double totalExpense = 0.00;
  double totalPayment = 0.00;
  int pendingOrdersNumber = 0;
  double transferOut = 0.00;
  double transferIn = 0.00;

  void refreshHomeScreen() async {
    int? count = await DatabaseHelper.instance.numberOfOrders();
    setState(() {
      pendingOrdersNumber = count;
    });
  }

  // FutureBuilder(
  // future: DatabaseHelper.instance.numberOfOrders(),
  // builder:
  // (context, AsyncSnapshot<dynamic> snapshot) {
  // //if (snapshot.hasData) {
  // return MyHomePage();
  // //}
  // },
  // );

  void businessWallet() async {
    double? payments = 0.0;
    double? expense = 0.0;
    double? outTransfers = 0.0;
    double? inTransfers = 0.0;

    payments = (await DatabaseHelper.instance.calculateTotalFromPayments())[0]
        ['TotalPayments'];
    expense = (await DatabaseHelper.instance.calculateTotalFromExpense())[0]
        ['TotalExpense'];
    outTransfers = (await DatabaseHelper.instance
        .transferOutFromTotalExpense())[0]['TransferOut'];
    inTransfers = (await DatabaseHelper.instance
        .transferInFromTotalPayment())[0]['TransferIn'];

    setState(() {
      if (payments != null && expense == null && inTransfers != null) {
        businessWalletBalance = payments;
        totalPayment = payments - inTransfers;
        transferIn = inTransfers;
      } else {
        if (payments != null &&
            expense != null &&
            outTransfers != null &&
            inTransfers != null) {
          if (payments <= expense) {
            businessWalletBalance = 0.0;
          } else {
            businessWalletBalance = (payments - expense);
          }
          totalPayment = payments - inTransfers;
          totalExpense = expense - outTransfers;
          transferIn = inTransfers;
          transferOut = outTransfers;
        } else {
          if (payments == null && expense != null && outTransfers != null) {
            totalExpense = expense - outTransfers;
            transferOut = outTransfers;
          }
        }
      }
    });

    print('Business Wallet: $businessWalletBalance');
    print('totalExpense: $totalExpense');
    print('totalpayments $totalPayment');
  }

  @override
  void initState() {
    super.initState();
    //countOrders();
    businessWallet();
  }

  @override
  Widget build(BuildContext context) {
    int pendingOrdersNumber = Provider.of<int>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff693b58),
        drawer: MyDrawer(),
        body: Column(
          children: [
            Column(
              children: [
                Row(
                  //header with title and home
                  children: [
                    const SizedBox(
                      height: 110,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Twisted Twine Workshop",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Home",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.account_balance_wallet_rounded,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.attach_money,
                            color: Colors.white,
                          ),
                          Text('$businessWalletBalance',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text('$pendingOrdersNumber',
                            style:
                                TextStyle(fontSize: 120, color: Colors.white)),
                        Text('Orders Pending',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(height: 40),
                        Container(
                          height: 70,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff4d8a64),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Income",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                  '$totalPayment',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff4d8a64),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(
                                      color: Colors.white,
                                      Icons.attach_money,
                                    ),
                                  ),
                                  Text("Transfer In ",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text('$transferIn',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff4d8a64),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text("Expense",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      )),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text('$totalExpense',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff4d8a64),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text("Transfer out",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text('$transferOut',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
