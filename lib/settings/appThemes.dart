import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const PREF_KEY = "pref_key";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(PREF_KEY) ?? false;
  }
}

class AppThemes extends StatefulWidget {
  @override
  _AppThemesState createState() => _AppThemesState();
}

class _AppThemesState extends State<AppThemes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE9DCE5),
      appBar: AppBar(
        backgroundColor: const Color(0xff693b58),
        foregroundColor: Colors.white,
        title: const Text('Theme'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              title: const Text('Dark Theme'),
              leading: Radio(
                value: null,
                groupValue: null,
                onChanged: (Null? value) {},
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Light Theme'),
              leading: Radio(
                groupValue: null,
                value: null,
                onChanged: (Null? value) {},
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Aubergine'),
              leading: Radio(
                groupValue: null,
                value: null,
                onChanged: (Null? value) {},
              ),
              trailing: CircleAvatar(
                backgroundColor: const Color(0xff693b58),
                radius: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
