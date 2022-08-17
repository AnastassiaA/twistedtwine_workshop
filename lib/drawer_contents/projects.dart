import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/cards/order_card.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/forms/addOrder.dart';
import 'package:twistedtwine_workshop/forms/addProject.dart';
import 'package:twistedtwine_workshop/tabs/order_tab.dart';
import 'package:twistedtwine_workshop/tabs/projects_tab.dart';
import '../drawer.dart';
//===============================================//

class ProjectHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {},
            )
          ],
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Projects'),
        ),
        drawer: MyDrawer(),
        body: ProjectList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff997ABD),
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProjectsForm()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
