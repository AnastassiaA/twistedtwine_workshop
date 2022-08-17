import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/misc_drawer_category/craftType.dart';
import 'package:twistedtwine_workshop/settings/appThemes.dart';

import '../misc_drawer_category/brands.dart';
import '../drawer.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Settings'),
        ),
        drawer: MyDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
              title: Text('Change Theme'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppThemes()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
