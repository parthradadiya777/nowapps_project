import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project1/store/widgets/backgroundwidget.dart';
import '../model/sqflite_model.dart';
import '../product/product.dart';
import '../product_details/productslist.dart';
import '../sqflite_service/sqflite_service.dart';
import '../store/storeview.dart';
import 'controller/addtocartcontroller.dart';

class AddtoCartPage extends StatefulWidget {
   AddtoCartPage({Key? key,}) : super(key: key);

  @override
  State<AddtoCartPage> createState() => _AddtoCartPageState();
}

class _AddtoCartPageState extends State<AddtoCartPage> {
  int count = 0;
  List<dynamic> p = [];
  var l;
  var shareindex;
  var k;
var s;

m()async {
  s = await SharedPreferences.getInstance();
}

Image? image;
  loadImageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final imageKeyValue = prefs.getString('image');
    if (imageKeyValue != null) {
      final imageString = await ImageSharedPrefs.loadImageFromPrefs();
      setState(() {
        image = ImageSharedPrefs.imageFrom64BaseString(imageString!);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImageFromPrefs();
  }
  @override
  Widget build(BuildContext context) {
  m();
    AddCartController controller = Get.put(AddCartController());
    double height1 = MediaQuery
        .of(context)
        .size
        .height;
    double width1 = MediaQuery
        .of(context)
        .size
        .width;

  final dbhelper = Producthelper.instance;
  //Uint8List bytes = base64Decode(s.getString("image").toString());
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(onPressed: ()async{
        Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back)),
        backgroundColor: appbar,
        title: const Text('Add to Cart Page',),
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context, builder: (_){
              return AlertDialog(
                title: Text('Are You Sure Delete All Products'),
                content: Text('Are you sure delete'),
                actions: [
                  TextButton(onPressed: (){
                    Get.back();
                 //   Get.offNamed(Product_quntity.id);
                    dbhelper.deleteAll();
                  //  Navigator.pushNamedAndRemoveUntil(context, ProductList.id, (route) => false);
                    Fluttertoast.showToast(msg: 'Go Back And Come');

                  }, child: Text('Yes')),
                  TextButton(onPressed: (){
                    Get.back();

                  }, child: Text('No')),

                ],
              );
            });
          }, icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: SizedBox(
        height: height1,
        width: width1,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 200,
          width: width1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  width: width1,
                  child: FutureBuilder(
                      future: Producthelper().fetchdata(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    elevation: 10,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height1 * 0.15,
                                              color: Colors.lightBlue,
                                              width: width1,
                                             child: image
                                             // child:k ==null ?  CircularProgressIndicator():Image.network('${k[index]}')
                                            )),

                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Text('Product : ${snapshot
                                                    .data[index].name}'),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    const Text('Price'),
                                                    Text(snapshot.data![index]
                                                        .price.toString()),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    const Text('Quantity'),
                                IconButton(onPressed: () async{
                                                     ////  share =  SharedPreferences.getInstance();
                                                      // s =  SharedPreferences.getInstance();



                                                      setState(() {
                                                        l = s.getInt('quantity');
                                                       p.add(l);
                                                        p[index] = p[index]+1;
                                                      });
                                                    s.setInt('value', p[index]);
                                                    }, icon: const Icon(Icons.add)),
                                              p.length > index ?     Text(p[index].toString()): Text(s.getInt('quantity').toString()),
                                                    IconButton(onPressed: () {
                                                      setState(() {
                                                        if(p[index]!=0) {
                                                          p[index]--;
                                                        }
                                                      });
                                                    }, icon: const Icon(Icons.remove))
                                                  ],
                                                ),

                                                IconButton(onPressed: () {
                                                  Get.back();
                                                  Fluttertoast
                                                      .showToast(
                                                      msg: 'Product Deleted Successfully');
                                                  Producthelper()
                                                      .deleteNote(
                                                      snapshot
                                                          .data[index]
                                                          .id);

                                                }, icon: const Icon(Icons.delete))
                                              ],
                                            ))
                                      ],
                                    )
                                );
                              });
                        } else {
                          return const Center(child:  CircularProgressIndicator());
                        }
                      }
                  ),
                ),),
              Row(
                children: [
                  Container(
                    width: width1 * .6,
                    height: height1 * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
                    ),
                    child: Row(
                      children: [
                  FutureBuilder(
                  future: Producthelper().fetchdata(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround,
                  children: [
                    Text('Total Products : ${snapshot.data
                        .length}',style: const TextStyle(fontWeight: FontWeight.bold),),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),);
              }
            }
        ),
                        Row(
                          children: [
                            //   Text('Total Item : ${snapshot.data.length}'),
                            Obx(() => Text(
                                ' Total : ${controller.totalprice.value}',style: const TextStyle(fontWeight: FontWeight.bold))),
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (_){
                        return AlertDialog(
                          title: const Text('Confirm'),
                          content: const Text('Check Out In this Store'),
                          actions: [
                            TextButton(onPressed: (){
                              Get.back();
                              // Get.off(ShopePage());
                              Navigator.pushNamedAndRemoveUntil(context, ShopePage.id, (route) => false);

                            }, child: Text('Yes')),
                            TextButton(onPressed: (){
                              Get.back();

                            }, child: Text('No')),

                          ],
                        );
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white,
borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                             Text('Confirm',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                          ],
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),


      ),
    );
  }

}





class ImageSharedPrefs {
  static Future<bool> saveImageToPrefs(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.setString('image', value);
  }

  static Future<bool> emptyPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.clear();
  }

  static Future<String?> loadImageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('image');
  }

  // encodes bytes list as string
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  // decode bytes from a string
  static imageFrom64BaseString(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }
}