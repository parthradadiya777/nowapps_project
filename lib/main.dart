import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/product/product.dart';
import 'package:project1/product_details/productslist.dart';
import 'package:project1/store/storeview.dart';
import 'addtocart/addtocart.dart';
import 'loginscreen/loginscreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhoneView(),
      routes: {
       //AddtoCartPage.id:(context)=> AddtoCartPage(),
        Product.id: (context)=> Product(),
        ProductList.id : (context) => ProductList(),
      },
    );
  }
}

