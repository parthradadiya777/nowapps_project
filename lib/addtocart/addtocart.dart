import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/store/widgets/backgroundwidget.dart';
import '../store/storeview.dart';
import 'controller/addtocartcontroller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddtoCartPage extends GetView<AddCartController> {
  FirebaseAuth auth = FirebaseAuth.instance;

  List list = [];
  List temp = [];
  String p = '';
  int p1 = 0;
  List q = ['p','q'];
  var l=0;
  void data1 (data){
     list = [];
    list.add(data);
    list.join();
  }
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() =>AddCartController());
    double height1 = MediaQuery.of(context).size.height;
    double width1 = MediaQuery.of(context).size.width;



    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text('Add to Cart Page',),
      ),
      body:SizedBox(
        height: height1,
        width: width1,
        child: StreamBuilder(
          stream:FirebaseFirestore.instance.collection('user').snapshots() ,
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData) {
              var snap1 = snapshot;
              return Column(
                children: [
                  Container(
                    height: height1 * 0.8,
                     // color: Colors.red,
                    child: ListView.builder(
                        itemCount: snap1.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                height: height1 * .8,
                                width: 500,
                              //  color: Colors.yellow,
                                child: ListView.builder(
                                    itemCount: snap1.data!.docs[index]['products'].length,
                                    itemBuilder: (context, i) {
                                      var data = snap1.data!.docs[index]['products'][i];
                                      print("print data" + data.toString());
                                      controller.p.value = data['quantity'];
                                      temp = snap1.data!.docs[index]['products'];
                                      return Card(
                                        child: ListTile(
                                          leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  '${data['image']}')),
                                          title: Text(data['name']),
                                          subtitle: Row(
                                            children: [
                                              IconButton(

                                                  onPressed: () {
                                                // var list2 = [{
                                                //   'image': data['image'],
                                                //   'name': data['name'],
                                                //   'price': data['price'],
                                                //   'quantity': data['quantity'],
                                                // }];
                                            //   list.add(list2);
                                            //     list = [];
                                            //     list.add(data['quantity']++);
                                            //
                                            //     print(list.join());
                                            //     data1(data);


                                                 //   i=0

                                                 //   data['quantity'];

                                              controller.incrementvalue(i,data);

                                               //
                                               // FirebaseFirestore.instance
                                               //     .collection('user')
                                               //     .doc(auth.currentUser!.uid)
                                               //     .update({
                                               //   'products': FieldValue.arrayUnion([{
                                               //     'quantity': controller.p.value,
                                               //   }
                                               //   ]),
                                               // },);

                                                // print('index'+index.toString());
                                                // print(i.toString());
                                             //   p = list.join();
                                              //  String l = list.join();
                                             //   p = l.toString();
                                                //Text(list.toString());
                                                //  p = list
                                                //     .map((val) => val)
                                                //     .join(',');
                                                // print(p);
                                              }, icon: Icon(Icons.add)),
                                          Obx(()=> Text(controller.p.value.toString())),
                                          //    Obx(()=> Text((.toString()))),
                                              IconButton(onPressed: () {
                                                controller.decrementvalue(data);

                                              }, icon: Icon(Icons.minimize)),
                                              IconButton(onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection('user').doc(
                                                    auth.currentUser!.uid).set({
                                                  'products': FieldValue.arrayRemove([{
                                                    'image': data['image'],
                                                    'name': data['name'],
                                                    'price': data['price'],
                                                    'quantity': data['quantity'],
                                                  }
                                                  ],)
                                                },
                                                    SetOptions(merge: true)
                                                );
                                              }, icon: Icon(Icons.delete)),
                                            ],
                                          ),
                                          trailing: Text(
                                              data['price'].toString()),
                                        ),
                                      );
                                    }
                                ),
                              )

                            ],
                          );
                        }),
                  ),
                  MaterialButton(onPressed: () {
                    showDialog(context: context, builder: (_) {
                      return AlertDialog(
                        title: const Text('Are you Sure Confirm Order'),
                        //   content: Text('Your Quantity: $quantity and Price: $price'),
                        actions: [
                          TextButton(onPressed: () async {
                            Navigator.pop(context);
                          }, child: const Text('No')),
                          TextButton(onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, ShopePage.id, (route) => false);
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (_) => const ShopePage()));
                          }, child: const Text('Check Out')),

                        ],
                      );
                    });
                  },
                    child: Text('Confirm', style: style.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 20),),)
                ],
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),

      ),
    );
  }
}



