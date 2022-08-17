import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/cards/projectCard.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/models/projects_model.dart';

class ProjectList extends StatefulWidget {
  @override
  _ProjectListState createState() {
    return _ProjectListState();
  }
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper.instance.getProject(),
      builder: (context, AsyncSnapshot<List<ProjectsModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ProjectsModel _model = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[350],
                      radius: 30,
                    ),
                    title: Text(_model.projectTitle),
                    subtitle:
                        Text(_model.craftType /*+ "\n" + _model.description*/),
                    trailing: Text(_model.status),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Project(),
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: Text('No Projects added'),
          );
        }
      },
    );
  }
}
