import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/sqflite_model.dart';

// First step



class Producthelper extends GetxController with StateMixin {
  static Producthelper? _producthelper;
  static Database? _database;
  String productTable = 'Product_table';
  String colId = 'id';
  String colname = 'name';
  String colprice = 'price';
  String colimage = 'image';
  String colcount = 'count';
RxInt count = 0.obs;
  Producthelper._createInstance();

  static final Producthelper instance = Producthelper._createInstance();

  /// Second step
  factory Producthelper() {
    // ignore: prefer_conditional_assignment
    if (_producthelper == null) {
      _producthelper = Producthelper._createInstance();
    }
    return _producthelper!;
  }

  // Third setp
  Future<Database> get database async {
    // ignore: prefer_conditional_assignment
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  // forth step
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'product.db';

    var notesdatabase =
    await openDatabase(path, version: 1, onCreate: _createdb);

    return notesdatabase;
  }

// fifth setp
  void _createdb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $productTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colname TEXT, $colprice TEXT, $colimage TEXT,$colcount TEXT)');
  }

// Sixth step (query)
  Future<List<Map<String, dynamic>>> getProductMapList() async {
    // ignore: unnecessary_this
    Database db = await this.database;
    var result;
    try {
     result = await db.query(productTable);
    }catch (e){
      print(e.toString());

    }
    return result;
  }

// seventh step (insert)
  Future<int> insertProduct(Product product) async {
    // ignore: unnecessary_this
    Database db = await this.database;

    var result = db.insert(productTable, product.tomap());

    return result;
  }


  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result;

     result = await db.rawDelete('DELETE FROM $productTable where $colId = $id');
    return result;
  }

   calculateTotal() async {
    Database db = await this.database;
    var result;
    try {
       result = await db.rawQuery("SELECT SUM($colprice) as Total FROM $productTable");
      print(result.toList());
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
    return result;
  }





  fetchdata()async{
    Database db = await this.database;

    final List<Map<String,dynamic>> qr = await db.query(productTable);
    count.value = qr.length;
    return qr.map((e) => Product.fromMapObject(e)).toList();
  }

  deleteAll() async {
    Database db = await instance.database;
    return await db.rawDelete("Delete from $productTable");
  }
}