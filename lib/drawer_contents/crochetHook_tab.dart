import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/cards/crochet_hook_card.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/forms/addCrochetHook.dart';
import 'package:twistedtwine_workshop/models/crochethook_model.dart';

import '../drawer.dart';

class CrochetHookTab extends StatefulWidget {
  @override
  _CrochetHookTabState createState() {
    return _CrochetHookTabState();
  }
}

class _CrochetHookTabState extends State<CrochetHookTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE9DCE5),
      appBar: AppBar(
        backgroundColor: const Color(0xff693b58),
        foregroundColor: Colors.white,
        title: const Text('Crochet Hook'),
      ),
      body: FutureBuilder(
        future: DatabaseHelper.instance.getCrochetHook(),
        builder: (context, AsyncSnapshot<List<CrochetHookModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CrochetHookModel _model = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[350],
                      radius: 30,
                      //child: Image.asset('images/default_image.png'),
                    ),
                    title: Text(_model.hookSize),
                    trailing: Text(_model.hookType),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CrochetHook()),
                    ),
                  ),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  //margin: ,
                );
              },
            );
          }
          return Center(
            child: Text('No Crochet Hook added'),
          );
        },
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff540E32),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCrochetHook()),
          );
        },
      ),
    );
  }
}
