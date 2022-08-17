import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/models/crafttype_model.dart';

class CraftypeList extends StatefulWidget {
  _CraftypeListState createState() {
    return _CraftypeListState();
  }
}

class _CraftypeListState extends State<CraftypeList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.getCraftType(),
      builder: (context, AsyncSnapshot<List<CraftTypeModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CraftTypeModel _model = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(_model.craftTypeName),
                  ),
                );
              });
        } else {
          return Center(
            child: Text('Nothing'),
          );
        }
      },
    );
  }
}
