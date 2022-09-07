import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project1/store/widgets/backgroundwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/controller/product_Controller.dart';
import '../addtocart/addtocart.dart';
import '../model/sqflite_model.dart';
import '../sqflite_service/sqflite_service.dart';
import 'controller/productcontroller.dart';

class Product_quntity extends StatefulWidget {

  static const id = '/product';
  @override
  State<Product_quntity> createState() => _Product_quntityState();
}

class _Product_quntityState extends State<Product_quntity> {

  ProductController controller = ProductController();


  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() =>ProductApiController());
    final dbhelper = Producthelper.instance;

    final data = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    var whole = data['whole'];
    var image = whole['thumbnail'];
    var name = whole['title'];
    var price = whole['price'];
    double totalPrice = double.parse(price.toString());
     double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text('Product'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height*.12,),
          Container(
              height: height * .3,
              width: width,
              child: Image.network(image)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('Product Name: $name',style: style),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('Product Price: $price',style: style,),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            // Text(p.toString()),
        IconButton(onPressed: (){
              controller.increment();

                }, icon: Icon(Icons.add,color: textColor,)),
                Obx(()=> Text(controller.quantity.toString(),style: style)),
                IconButton(onPressed: (){
                 controller.decrement();
                }, icon: Icon(Icons.remove,color: textColor,))
              ],
          ),
        Obx(() =>   controller.quantity.value>0?  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Price: ${totalPrice * controller.quantity.value}",style: style),
            Text("Quantity ${controller.quantity}",style: style),
            InkWell(
               onTap: () {
                 showDialog(context: context, builder: (_){
                   return AlertDialog(
                     title: const Text('Add Product'),
                     content: const Text('Are You Sure Add Cart Page'),
                     actions: [
                       TextButton(onPressed: ()async{
                         Get.back();
                         FirebaseFirestore.instance.collection('iamge').doc(FirebaseAuth.instance.currentUser!.uid).set({
                           'images':FieldValue.arrayUnion([
                             image,
                           ])
                         });
                         Fluttertoast.showToast(msg: 'Your Product Added Successfully');
                         dbhelper.insertProduct(Product.fromMapObject({
                           dbhelper.colname:  name,
                           dbhelper.colprice: (totalPrice * controller.quantity.value).toString(),
                           dbhelper.colimage:image
                         }));
                         SharedPreferences s =await SharedPreferences.getInstance();
                         s.setInt('quantity', controller.quantity.value);
                        // String base64Image = base64Encode(image);
                        //  s.setString("image", base64Image);
                      //   ImageSharedPrefs.saveImageToPrefs(image);
                         String source = 'Błonie';

                         List<int> list = utf8.encode(source);
                         Uint8List bytes = Uint8List.fromList(list);
                         String outcome = utf8.decode(bytes);

                         ImageSharedPrefs.saveImageToPrefs(image);


                       }, child: const Text('Yes')),
                       TextButton(onPressed: (){
                         Get.back();
                       }, child: const Text('No')),
                     ],
                   );
                 });
               },


              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: width*.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey,
                ),
                child: Text('Add To Cart',style: style),

              ),
            )
          ],
        ) : Container() )


        ],
      ),
    );
  }
}
