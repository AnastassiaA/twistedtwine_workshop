import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import '../drawer.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';

//class to define the data model
class ProductItem {
  final String productPictureUrl;
  final int productId;
  final String productName;
  final String productType;
  final num productPrice;

  ProductItem({
    required this.productPictureUrl,
    required this.productId,
    required this.productName,
    required this.productType,
    required this.productPrice,
  });

  //make a map of the data model that matches
// columns in the database
  Map<String, dynamic> toMap() {
    return {
      //single quotes are the exact names of the columns
      'Image': productPictureUrl,
      'ID': productId,
      'Name': productName,
      'Craft Type': productType,
      'Price': productPrice,
    };
  }

  String toString() {
    return 'Product{Image: $productPictureUrl, ID : $productId, Name : $productName, Craft Type : $productType, Price : $productPrice}';
  }
}

//Opens the database
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      openDatabase(join(await getDatabasesPath(), 'TTwineCommissions.db'));

  //add
  Future<void> insertProductItem(ProductItem prodItem) async {
    final db = await database;

    await db.insert(
      'Product Catalogue',
      prodItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

class Product extends StatefulWidget {
  @override
  ProductState createState() {
    return ProductState();
  }
}

class ProductState extends State<Product> {
  String dropdownValue = '-';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  TextEditingController _controller = TextEditingController();

  final itemID = TextEditingController();
  final itemName = TextEditingController();
  final itemPrice = TextEditingController();

  final ProductItem prodItem = new ProductItem(
      productPictureUrl: productPictureUrl,
      productId: productId,
      productName: productName,
      productType: productType,
      productPrice: productPrice);

  static get productPrice => null;
  static get productType => null;
  static get productName => null;
  static get productId => null;
  static get productPictureUrl => null;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths!.first.extension);
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    itemID.dispose();
    itemName.dispose();
    itemPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE9DCE5),
        appBar: AppBar(
          backgroundColor: const Color(0xff693b58),
          foregroundColor: Colors.white,
          title: const Text('Product Catalogue'),
        ),
        drawer: MyDrawer(),
        body: GridView.builder(
          primary: false,
          padding: const EdgeInsets.all(20),
          //itemCount: options.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          itemBuilder: (BuildContext context, int index) {
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff997ABD),
          foregroundColor: Colors.black,
          onPressed: () {
            //==========Add Item Form begins=========//
            Alert(
                context: context,
                title: "Add New Item",
                content: Column(
                  children: <Widget>[
                    Container(
                        child: TextButton.icon(
                      onPressed: () {
                        //FilePickerDemo();
                        _openFileExplorer();
                      },
                      icon: Icon(Icons.add, size: 18),
                      label: Text("Add Image"),
                    )),
                    Container(
                      child: TextField(
                        controller: itemID,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Item ID',
                        ),
                      ),
                    ),
                    Container(
                      child: TextField(
                        controller: itemName,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Item Name',
                        ),
                      ),
                    ),
                    Container(
                      child: TextField(
                        controller: itemPrice,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Item Price',
                        ),
                      ),
                    ),
                    Container(
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['-', 'Knit', 'Crochet']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {
                      setState(() {
                        itemID.text;
                        itemName.text;
                        itemPrice.text;
                      });
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
            //=============Add Item Form ends===========//
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  //void setState(Null Function() param0) {}
}

//===============================================//
