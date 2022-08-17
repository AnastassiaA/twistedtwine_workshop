import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/models/projects_model.dart';

class AddProjectsForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProjectState();
  }
}

class AddProjectState extends State<AddProjectsForm> {
  final _formKey = GlobalKey<FormState>();

  final projectTitleController = TextEditingController();
  final dateStartedController = TextEditingController();
  final dateCompletedController = TextEditingController();
  final craftTypeController = TextEditingController();
  final statusController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffE9DCE5),
      appBar: AppBar(
        backgroundColor: const Color(0xff693b58),
        title: Text('Add Project'),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: projectTitleController,
                  keyboardType: TextInputType.text,
                  showCursor: true,
                  decoration: const InputDecoration(
                    labelText: 'Project Title',
                  ),
                ),
                Stack(
                  children: [
                    DateTimePicker(
                      controller: dateStartedController,
                      initialValue: null,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Date Started',
                      onChanged: (val) => print(val),
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    )
                  ],
                ),
                Stack(
                  children: [
                    DateTimePicker(
                      controller: dateCompletedController,
                      initialValue: null,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Date Completed',
                      onChanged: (val) => print(val),
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    )
                  ],
                ),
                TextFormField(
                  controller: craftTypeController,
                  keyboardType: TextInputType.text,
                  showCursor: true,
                  decoration: const InputDecoration(
                    labelText: 'Craft Type',
                  ),
                ),
                TextFormField(
                  controller: statusController,
                  keyboardType: TextInputType.text,
                  showCursor: true,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    //TODO: dropdown menu
                  ),
                  //onChanged: (text) {
                  //threadNumberController.text = _generateThreadNumber(text);
                  //},
                ),
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  showCursor: true,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  //onChanged: (text) {
                  //threadNumberController.text = _generateThreadNumber(text);
                  //},
                ),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Saving project')));

                          await DatabaseHelper.instance.addProject(
                            ProjectsModel(
                                projectTitle: projectTitleController.text,
                                dateStarted:
                                    DateTime.parse(dateStartedController.text),
                                dateCompleted: DateTime.parse(
                                    dateCompletedController.text),
                                description: descriptionController.text,
                                status: statusController.text,
                                craftType: craftTypeController.text),
                          );

                          Navigator.pop(context);
                        },
                        child: Text("add order"),
                      )),
                )
              ],
            ),
          ))),
    ));
  }
}
