import 'package:flutter/material.dart';
import 'package:twistedtwine_workshop/cards/knitting_needle_card.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/forms/addKnittingNeedle.dart';
import 'package:twistedtwine_workshop/models/crochethook_model.dart';

import '../drawer.dart';
import '../models/knttingneedles_model.dart';

class KnittingNeedleTab extends StatefulWidget {
  @override
  _KnittingNeedleTabState createState() {
    return _KnittingNeedleTabState();
  }
}

class _KnittingNeedleTabState extends State<KnittingNeedleTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Knitting Needles'),
        ),
        body: FutureBuilder(
          future: DatabaseHelper.instance.getKnittingNeedle(),
          builder:
              (context, AsyncSnapshot<List<KnittingNeedleModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  KnittingNeedleModel _model = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[350],
                        radius: 30,
                        //child: Image.asset('images/default_image.png'),
                      ),
                      title: Text(_model.knittingNeedleSize),
                      trailing: Text(_model.knittingNeedleType),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KnittingNeedle()),
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
              child: Text('No Knitting Needles added'),
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
              MaterialPageRoute(builder: (context) => AddKnittingNeedle()),
            );
          },
        ),
      ),
    );
  }
}
