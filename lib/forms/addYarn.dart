import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twistedtwine_workshop/db_code/databaseUtilities.dart';
import 'package:twistedtwine_workshop/models/yarn_model.dart';

class AddYarn extends StatefulWidget {
  @override
  _AddYarnState createState() => _AddYarnState();
}

class _AddYarnState extends State<AddYarn> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'None';

  //final yarnNumberController = TextEditingController();

  final yarnColorController = TextEditingController();

  final brandController = TextEditingController();

  final materialController = TextEditingController();

  final sizeController = TextEditingController();

  final availableWeightController = TextEditingController();

  final priceController = TextEditingController();

  final weightController = TextEditingController();

  final hooknNeedleController = TextEditingController();

  final costController = TextEditingController();

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

    //threadNumberController.dispose();

    yarnColorController.dispose();

    brandController.dispose();

    materialController.dispose();

    sizeController.dispose();

    availableWeightController.dispose();

    priceController.dispose();

    weightController.dispose();

    hooknNeedleController.dispose();

    costController.dispose();
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
          title: Text('Add Yarn'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // TextField(
                  //   controller: threadNumberController,
                  //   showCursor: true,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Thread Number',
                  //   ),
                  // ),
                  TextFormField(
                    controller: yarnColorController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Yarn Color',
                    ),
                    //onChanged: (text) {
                    //threadNumberController.text = _generateThreadNumber(text);
                    //},
                  ),
                  Container(
                    child: printText(),
                    // Image.file(
                    //     io.File(
                    //       _paths!.first.path.toString(),
                    //     ),
                    //     width: 100,
                    //     height: 100,
                    //     fit: BoxFit.fill)
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _openFileExplorer();
                        path = _paths!
                            .map((e) => e.path)
                            .toList()[index]
                            .toString();
                      },
                      child: Card(
                        color: const Color(0xffE9DCE5),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.camera_alt,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.image),
                            ),
                            Text('IMAGE', textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: brandController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Brand',
                    ),
                  ),
                  TextFormField(
                    controller: materialController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Material',
                    ),
                  ),
                  TextFormField(
                    controller: sizeController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Size',
                    ),
                  ),
                  TextFormField(
                    controller: availableWeightController,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Available Weight (g)',
                    ),
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Price per gram',
                    ),
                  ),
                  TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Weight',
                    ),
                  ),
                  TextFormField(
                    controller: hooknNeedleController,
                    keyboardType: TextInputType.text,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Recc Hook/Needle',
                    ),
                  ),
                  TextFormField(
                    controller: costController,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    decoration: const InputDecoration(
                      labelText: 'Cost',
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
                              const SnackBar(content: Text('Saving yarn')));

                          await DatabaseHelper.instance.addYarn(
                            YarnModel(
                              //threadNumber: threadNumberController.text,
                              yarnColor: yarnColorController.text,
                              //image: path,
                              brand: brandController.text,
                              material: materialController.text,
                              size: sizeController.text,
                              availableWeight:
                                  double.parse(availableWeightController.text),
                              pricePerGram: double.parse(priceController.text),
                              weight: double.parse(weightController.text),
                              reccHookNeedle: hooknNeedleController.text,
                              cost: double.parse(costController.text),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text("add yarn"),
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
