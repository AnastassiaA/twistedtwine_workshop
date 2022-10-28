import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:twistedtwine_workshop/models/crafttype_model.dart';
import 'package:twistedtwine_workshop/models/crochethook_model.dart';
import 'package:twistedtwine_workshop/models/crochetthread_model.dart';
import 'package:twistedtwine_workshop/models/expense_model.dart';
import 'package:twistedtwine_workshop/models/knttingneedles_model.dart';
import 'package:twistedtwine_workshop/models/order_model.dart';
import 'package:twistedtwine_workshop/models/payment_model.dart';
import 'package:twistedtwine_workshop/models/projects_model.dart';
import 'package:twistedtwine_workshop/models/yarn_model.dart';

class DatabaseHelper extends ChangeNotifier {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ttwinecommissions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    //---ORDERS TABLE---//
    await db.execute(
        '''CREATE TABLE orders(ordernumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ordername TEXT,
      crafttype TEXT,
      customer TEXT,
      status TEXT,
      description TEXT
      )''');

    //--CRAFT TYPE TABLE--//
    await db.execute('''
    CREATE TABLE crafttypedropdown(
    crafttypenumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    crafttype TEXT)''');

    //--BRAND TABLE--//
    await db.execute('''
    CREATE TABLE brand(
    brandnumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    brandname TEXT,
    type TEXT,
    rating REAL)''');

    //--CROCHET THREAD TABLE--//
    await db.execute('''
    CREATE TABLE crochetthread(
      threadNumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      threadcolor TEXT,  
      brand TEXT,
      material TEXT,
      size TEXT,
      availableweight REAL,
      pricepergram REAL,
      weight REAL,
      recchookneedle TEXT,
      cost REAL
    )''');

    //--YARN TABLE--//
    await db.execute('''CREATE TABLE yarn(
    yarnnumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    yarncolor TEXT,
    brand TEXT,
    material TEXT,
    size TEXT,
    availableweight REAL,
    pricepergram REAL,
    weight REAL,
    recchookneedle TEXT,
    cost REAL)''');

    //--CROCHETHOOK TABLE--//
    await db.execute('''
    CREATE TABLE crochethook(
    crochethooknumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    hooksize TEXT,
    hooktype  TEXT)
    ''');

    //--KNITTING NEEDLE TABLE--//
    await db.execute('''
    CREATE TABLE knittingneedle(
    knittingneedlenumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    knittingneedlesize TEXT,
    knittingneedletype  TEXT)
    ''');

    //--EXPENSE TABLE--//
    await db.execute('''
    CREATE TABLE expenses(
    expenseid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    expensename TEXT,
    date TEXT,
    type TEXT,
    amount REAL,
    paidto TEXT
      )''');

    //---PAYMENT TABLE---//
    await db.execute('''
    CREATE TABLE payment(
    paymentnumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    date TEXT,
    type TEXT,
    fromwhom TEXT,
    amount REAL,
    description TEXT
    )''');

    //---PAYMENT-ORDER TABLE---//

    //---PROJECTS TABLE---//
    await db.execute('''
    CREATE TABLE project(
    projectnumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    projecttitle TEXT,
    datestarted TEXT,
    datecompleted TEXT,
    crafttype TEXT,
    status TEXT,
    description TEXT
    )''');

    await db.execute('''CREATE TABLE crafttypelist(
    crafttypenumber INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    crafttypename TEXT
    )''');

    /*When a timer is started on a particular project or order, the timer table should log
    * its ID, start date and time hh:mm:ss. Stopping the timer records the end date and time
    * hh:mm:ss*/

    await db.execute('''CREATE TABLE timer(
    itemid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    startdatetime TEXT
    enddatetime TEXT
    )''');
  }

  //--------- CRAFT TYPE LIST DB FUNCTIONS---------//
  Future<void> addCraftType(CraftTypeModel craftType) async {
    Database db = await instance.database;

    await db.insert(
      'crafttypedropdown',
      craftType.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<CraftTypeModel>> getCraftType() async {
    Database db = await instance.database;

    var craftType = await db.query('crafttypedropdown');

    List<CraftTypeModel> craftTypeList = craftType.isNotEmpty
        ? craftType.map((e) => CraftTypeModel.fromMap(e)).toList()
        : [];

    return craftTypeList;
  }

  //---------PROJECT DB FUNCTIONS---------//
  Future<void> addProject(ProjectsModel project) async {
    Database db = await instance.database;

    await db.insert(
      'project',
      project.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<ProjectsModel>> getProject() async {
    Database db = await instance.database;

    var project = await db.query('project');

    List<ProjectsModel> projectList = project.isNotEmpty
        ? project.map((e) => ProjectsModel.fromMap(e)).toList()
        : [];

    return projectList;
  }

  Future<void> updateProject(ProjectsModel project) async {
    Database db = await instance.database;

    await db.update(
      'project',
      project.toMap(),
      where: 'projectnumber = ?',
      whereArgs: [
        ['projectnumber'],
      ],
    );
  }

  Future<void> deleteProject(String description) async {
    Database db = await instance.database;

    await db.delete(
      'project',
      where: 'projectnumber = ?',
      whereArgs: [
        ['projectnumber'],
      ],
    );
  }

  //---------EXPENSE DB FUNCTIONS---------//
  Future<void> addExpense(ExpenseModel expense) async {
    Database db = await instance.database;

    await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<ExpenseModel>> getExpense() async {
    Database db = await instance.database;

    var expense = await db.query('expenses');

    List<ExpenseModel> expenseList = expense.isNotEmpty
        ? expense.map((e) => ExpenseModel.fromMap(e)).toList()
        : [];
    return expenseList;
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    // Get a reference to the database.
    Database db = await instance.database;

    // Update the given expense.
    await db.update(
      'expenses',
      expense.toMap(),
      // Ensure that the expense has a matching id.
      where: 'expenseid = ?',
      // Pass the expense's id as a whereArg to prevent SQL injection.
      whereArgs: ['expenseid'],
    );
  }

  Future<void> deleteExpense(int expenseid) async {
    // Get a reference to the database.
    Database db = await instance.database;

    // Remove the Dog from the database.
    await db.delete(
      'expenses',
      // Use a `where` clause to delete a specific expense.
      where: 'expenseid = ?',
      // Pass the expense's id as a whereArg to prevent SQL injection.
      whereArgs: ['expenseid'],
    );
  }

  //---------PAYMENT DB FUNCTIONS---------//
  Future<void> addPayment(PaymentModel payment) async {
    Database db = await instance.database;

    await db.insert('payment', payment.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<PaymentModel>> getPayment() async {
    Database db = await instance.database;

    var payment = await db.rawQuery('SELECT * FROM payment ORDER BY date');

    List<PaymentModel> paymentList = payment.isNotEmpty
        ? payment.map((e) => PaymentModel.fromMap(e)).toList()
        : [];

    return paymentList;
  }

  Future calculateTotalFromPayments() async {
    Database db = await instance.database;

    var ttlpayment =
        await db.rawQuery("SELECT SUM(amount) as TotalPayments FROM payment");
    print(ttlpayment.toList());
    return ttlpayment.toList();
  }

  Future<int> numberOfOrders() async {
    final db = await database;

    final numOrders;

    final count = await db
        .rawQuery('SELECT COUNT(*) FROM orders WHERE status LIKE "%pending%"');

    numOrders = Sqflite.firstIntValue(count);

    print('total orders = $numOrders');

    notifyListeners();
    return numOrders;
  }

  Future<int> numberOfInProgressOrders() async {
    final db = await database;

    final numInProgress;

    final count = await db.rawQuery(
        'SELECT COUNT(*) FROM ORDERS WHERE status LIKE "%in progress%"');

    numInProgress = Sqflite.firstIntValue(count);

    print('total in progress = $numInProgress');

    notifyListeners();
    return numInProgress;
  }

  Future calculateTotalFromExpense() async {
    Database db = await instance.database;
    var ttlexpense =
        await db.rawQuery("SELECT SUM(amount) as TotalExpense FROM expenses");
    print(ttlexpense.toList());
    return ttlexpense.toList();
  }

  Future transferOutFromTotalExpense() async {
    Database db = await instance.database;
    var transferOut = await db.rawQuery(
        'SELECT SUM(amount) as TransferOut FROM expenses WHERE type LIKE "%Transfer Out%"');
    print(transferOut.toList());
    return transferOut.toList();
  }

  Future transferInFromTotalPayment() async {
    Database db = await instance.database;
    var transferIn = await db.rawQuery(
        'SELECT SUM(amount) as TransferIn FROM payment WHERE type LIKE "%Transfer In%"');
    print(transferIn.toList());
    return transferIn.toList();
  }

  Future<void> updatePayment(PaymentModel payment) async {
    Database db = await instance.database;

    await db.update(
      'payment',
      payment.toMap(),
      where: 'paymentnumber = ?',
      whereArgs: [
        ['paymentnumber'],
      ],
    );
  }

  Future<void> deletePayment(String description) async {
    Database db = await instance.database;

    await db.delete('payment', where: 'paymentnumber = ?', whereArgs: [
      ['paymentnumber']
    ]);
  }

  //---------KNITTING NEEDLE DB FUNCTIONS---------//
  Future<void> addKnittingNeedle(KnittingNeedleModel needle) async {
    Database db = await instance.database;

    await db.insert('knittingneedle', needle.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<KnittingNeedleModel>> getKnittingNeedle() async {
    Database db = await instance.database;

    var knittingNeedle = await db.query('knittingneedle');

    List<KnittingNeedleModel> needleList = knittingNeedle.isNotEmpty
        ? knittingNeedle.map((e) => KnittingNeedleModel.fromMap(e)).toList()
        : [];
    return needleList;
  }

  Future<void> updateKnittingNeedle(KnittingNeedleModel needle) async {
    final db = await database;

    await db.update(
      'knittingneedle',
      needle.toMap(),
      where: 'knittingneedlenumber = ?',
      whereArgs: [
        ['knittingneedlenumber'],
      ],
    );
  }

  Future<void> deleteKnittingNeedle(String knittingNeedleSize) async {
    final db = await database;

    await db.delete('knittingneedle',
        where: 'knittingneedlenumber = ?',
        whereArgs: [
          ['knittingneedlenumber']
        ]);
  }

  //---------CROCHET HOOK DB FUNCTIONS---------//
  Future<void> addCrochetHook(CrochetHookModel hook) async {
    Database db = await instance.database;

    await db.insert('crochethook', hook.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<CrochetHookModel>> getCrochetHook() async {
    Database db = await instance.database;

    var crochetHook = await db.query('crochethook');

    List<CrochetHookModel> hookList = crochetHook.isNotEmpty
        ? crochetHook.map((e) => CrochetHookModel.fromMap(e)).toList()
        : [];
    return hookList;
  }

  Future<void> updateCrochetHook(CrochetHookModel hook) async {
    final db = await database;

    await db.update(
      'crochethook',
      hook.toMap(),
      where: 'crochethooknumber = ?',
      whereArgs: [
        ['crochethooknumber'],
      ],
    );
  }

  Future<void> deleteCrochetHook(String hookSize) async {
    final db = await database;

    await db.delete('crochethook', where: 'crochethooknumber = ?', whereArgs: [
      ['crochethooknumber']
    ]);
  }

  //---------ORDER DB FUNCTIONS---------//
  Future<void> addOrder(OrderModel order) async {
    Database db = await instance.database;

    await db.insert('orders', order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);

    notifyListeners();
  }

  Future<List<OrderModel>> getOrder() async {
    Database db = await instance.database;

    var order = await db.query('orders');

    List<OrderModel> orderList = order.isNotEmpty
        ? order.map((e) => OrderModel.fromMap(e)).toList()
        : [];

    notifyListeners();
    return orderList;
  }

  Future<void> updateOrder(OrderModel order) async {
    final db = await database;

    await db.update(
      'orders',
      order.toMap(),
      where: 'ordernumber = ?',
      whereArgs: [
        ['ordernumber'],
      ],
    );

    notifyListeners();
  }

  Future<void> deleteOrder(String orderNumber) async {
    final db = await database;

    await db.delete('orders', where: 'ordernumber = ?', whereArgs: [
      [orderNumber]
    ]);
  }

//---------CROCHET THREAD DB FUNCTIONS---------//
  Future<void> addCrochetThread(CrochetThreadModel crochetThread) async {
    Database db = await instance.database;

    await db.insert('crochetthread', crochetThread.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<CrochetThreadModel>> getCrochetThread() async {
    Database db = await instance.database;

    var crochetThread = await db.query('crochetthread');

    List<CrochetThreadModel> crochetThreadList = crochetThread.isNotEmpty
        ? crochetThread.map((e) => CrochetThreadModel.fromMap(e)).toList()
        : [];

    return crochetThreadList;
  }

  Future<void> updateCrochetThread(CrochetThreadModel crochetThread) async {
    final db = await database;

    await db.update(
      'crochetthread',
      crochetThread.toMap(),
      where: 'threadnumber = ?',
      whereArgs: [
        ['threadnumber']
      ], // Pass the id as a whereArg to prevent SQL injection.
    );
  }

  Future<void> deleteCrochetThread(String threadNumber) async {
    final db = await database;

    await db.delete(
      'crochetthread',
      where: 'threadnumber = ?',
      whereArgs: [
        threadNumber
      ], // Pass the id as a whereArg to prevent SQL injection.
    );
  }

//---------YARN DB FUNCTIONS---------//
  Future<void> addYarn(YarnModel yarn) async {
    Database db = await instance.database;

    await db.insert('yarn', yarn.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<YarnModel>> getYarn() async {
    Database db = await instance.database;

    var yarn = await db.query('yarn');

    List<YarnModel> yarnList =
        yarn.isNotEmpty ? yarn.map((e) => YarnModel.fromMap(e)).toList() : [];
    return yarnList;
  }

  Future<void> deleteYarn(int yarnNumber) async {
    final db = await database;

    await db.delete(
      'yarn',
      where: 'yarnnumber = ?',
      whereArgs: [
        'yarnnumber'
      ], // Pass the id as a whereArg to prevent SQL injection.
    );
    //notifyListeners();
  }
}
