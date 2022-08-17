import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/drawer_contents/knittingneedles_tab.dart';
  
import 'package:twistedtwine_workshop/models/crochethook_model.dart';
import 'package:twistedtwine_workshop/models/crochetthread_model.dart';
import 'package:twistedtwine_workshop/models/knttingneedles_model.dart';
import 'package:twistedtwine_workshop/models/yarn_model.dart';

class AddKnittingNeedle extends StatefulWidget {
  @override
  _AddKnittingNeedleState createState() => _AddKnittingNeedleState();
}

class _AddKnittingNeedleState extends State<AddKnittingNeedle> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'None';

  final knittingNeedleSizeController = TextEditingController();

  final knittingNeedleTypeController = TextEditingController();

  bool _loadingPath = false;
  String? _directoryPath;
  List<PlatformFile>? _paths;
  String? _extension;
  String? _fileName;
  FilePickerResult? pickedFile;
  int index = 0;
  late final path;

  // String _generateThreadNumber(String threadColor) {
  //   Random random = new Random();
  //   int number = random.nextInt(10);
  //
  //   String color = threadColor.substring(0, 3).toUpperCase();
  //
  //   String threadNumber = color + number.toString().padLeft(4, '0');
  //   return threadNumber;
  // }

  void dispose() {
    super.dispose();

    //crochetHookNumberController.dispose();

    knittingNeedleSizeController.dispose();

    knittingNeedleTypeController.dispose();
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;

      // String img = _paths!.first.path.toString();
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  Widget printText() {
    if (_fileName == null) {
      return Text('');
    } else {
      return Text('$_fileName');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          title: Text('Add Knitting Needle'),
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
                    controller: knittingNeedleSizeController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Knitting Needle Size',
                    ),
                  ),
                  TextFormField(
                    controller: knittingNeedleTypeController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Knitting Needle Type',
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        //style: ,
                        onPressed:
                            //TODO: Refresh list tile on pressed
                            () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Saving knitting needle')));

                          await DatabaseHelper.instance.addKnittingNeedle(
                            KnittingNeedleModel(
                              knittingNeedleSize:
                                  knittingNeedleSizeController.text,
                              knittingNeedleType:
                                  knittingNeedleTypeController.text,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text("add knitting needle"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
