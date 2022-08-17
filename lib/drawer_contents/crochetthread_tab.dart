import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/forms/addCrochetThread.dart';

import '../cards/crochet_thread_card.dart';
import '../drawer.dart';
import '../models/crochetthread_model.dart';

class CrochetThreadTab extends StatefulWidget with ChangeNotifier {
  @override
  _CrochetThreadTabState createState() {
    return _CrochetThreadTabState();
  }
}

class _CrochetThreadTabState extends State<CrochetThreadTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Crochet Thread'),
        ),
        body: FutureBuilder(
          future: DatabaseHelper.instance.getCrochetThread(),
          builder: (context, AsyncSnapshot<List<CrochetThreadModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  CrochetThreadModel _model = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[350],
                        radius: 30,
                        //child: Image.asset('images/default_image.png'),
                      ),
                      title: Text(_model.threadColor),
                      subtitle: Text(_model.brand),
                      trailing: Text(_model.availableWeight.toString() + ' g'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CrochetThread(),
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
              child: Text('No Crochet Thread added'),
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
              MaterialPageRoute(builder: (context) => AddCrochetThread()),
            );
          },
        ),
      ),
    );
  }
}
