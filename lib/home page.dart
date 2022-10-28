import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_code/databaseUtilities.dart';
import 'drawer.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<int>(
          create: (context) => DatabaseHelper.instance.numberOfOrders(),
          initialData: 0,
        ),
        // FutureProvider<int>(
        //   create: (context) =>
        //       DatabaseHelper.instance.numberOfInProgressOrders(),
        //   initialData: 0,
        // ),

        ChangeNotifierProvider(
          create: (context) => DatabaseHelper.instance,
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

@immutable
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  double businessWalletBalance = 0.00;
  double totalExpense = 0.00;
  double totalPayment = 0.00;
  int pendingOrdersNumber = 0;
  int inProgressNumber = 0;
  double transferOut = 0.00;
  double transferIn = 0.00;

  void businessWallet() async {
    double payments;
    double expense;
    double outTransfers;
    double inTransfers;

    payments = (await DatabaseHelper.instance.calculateTotalFromPayments())[0]
        ['TotalPayments'];
    expense = (await DatabaseHelper.instance.calculateTotalFromExpense())[0]
        ['TotalExpense'];
    outTransfers = (await DatabaseHelper.instance
        .transferOutFromTotalExpense())[0]['TransferOut'];
    inTransfers = (await DatabaseHelper.instance
        .transferInFromTotalPayment())[0]['TransferIn'];

    setState(() {
      if (payments == null) payments = 0.0;
      if (expense == null) expense = 0.0;
      if (inTransfers == null) inTransfers = 0.0;
      if (outTransfers == null) outTransfers = 0.0;

      totalPayment = payments - inTransfers;
      totalExpense = expense - outTransfers;
      transferIn = inTransfers;
      transferOut = outTransfers;
      businessWalletBalance =
          totalPayment + transferIn - totalExpense - transferOut;
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
    int inProgressNumber;

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
                      padding: const EdgeInsets.only(left: 16, right: 16),
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
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.account_balance_wallet_rounded,
                            color: Colors.white,
                          ),
                          const Icon(
                            Icons.attach_money,
                            color: Colors.white,
                          ),
                          Text('$businessWalletBalance',
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Text('$pendingOrdersNumber',
                              style: const TextStyle(
                                  fontSize: 120, color: Colors.white)),
                          const Text('Orders Pending',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ]),
                        // VerticalDivider(
                        //   color: Colors.white,
                        //   thickness: 40.0,
                        //   width: 40.0,
                        // ),
                        Column(
                          children: [
                            Text('$pendingOrdersNumber',
                                style: const TextStyle(
                                    fontSize: 120, color: Colors.white)),
                            const Text('In Progress(fix this)',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment
                          .end, //set something to double infinite for this to work
                      children: [
                        const SizedBox(height: 40),
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
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
                                    child: const Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    "Income",
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Text(
                                  '$totalPayment',
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
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
                                  const Text("Transfer In ",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Text('$transferIn',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
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
                                    child: const Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text("Expense",
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      )),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Text('$totalExpense',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
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
                                    child: const Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text("Transfer out",
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Text('$transferOut',
                                    style: const TextStyle(
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
