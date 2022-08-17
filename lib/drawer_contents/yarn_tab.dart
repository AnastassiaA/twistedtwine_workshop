import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/cards/yarnCard.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/forms/addYarn.dart';
import 'package:twistedtwine_workshop/models/yarn_model.dart';

import '../drawer.dart';

class YarnTab extends StatefulWidget {
  @override
  _YarnTabState createState() {
    return _YarnTabState();
  }
}

class _YarnTabState extends State<YarnTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Yarn'),
        ),
        body: FutureBuilder(
          future: DatabaseHelper.instance.getYarn(),
          builder: (context, AsyncSnapshot<List<YarnModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  YarnModel _model = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[350],
                        radius: 30,
                        //child: Image.asset('images/default_image.png'),
                      ),
                      title: Text(_model.yarnColor),
                      subtitle: Text(_model.brand),
                      trailing: Text(_model.availableWeight.toString() + ' g'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Yarn(),
                        ),
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
              child: Text('No Yarn added'),
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
              MaterialPageRoute(builder: (context) => AddYarn()),
            );
          },
        ),
      ),
    );
  }
}
