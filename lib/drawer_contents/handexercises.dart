import 'package:flutter/material.dart';
import '../drawer.dart';

class HandExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Hand Exercises'),
        ),
        drawer: MyDrawer(),
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage("images/ttc_icon.jpg"),
              ),
            ),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
