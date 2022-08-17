import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CraftType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Craft Type'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Crochet"), //${brandName}
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
