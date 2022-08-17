import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/tabs/payments.dart';

import '../drawer.dart';
import '../tabs/expenses.dart';

class AccountingDashboard extends StatefulWidget {
  @override
  AccDashboard createState() {
    return AccDashboard();
  }
}

class AccDashboard extends State<AccountingDashboard> {
  final pageviewController = PageController(
    initialPage: 1,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            backgroundColor: const Color(0xffE9DCE5),
            appBar: AppBar(
              backgroundColor: const Color(0xff693b58),
              foregroundColor: Colors.white,
              title: const Text('Accounting'),
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Expense'),
                  Tab(text: 'Payments'),
                ],
              ),
            ),
            drawer: MyDrawer(),
            body: TabBarView(
              children: [
                ExpenseHome(),
                PaymentsHome(),
              ],
            )),
      ),
    );
  }
}
