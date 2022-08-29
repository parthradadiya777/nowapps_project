import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/store/widgets/backgroundwidget.dart';
import '../store/storeview.dart';
import 'controller/addtocartcontroller.dart';

class AddtoCartPage extends GetView<AddCartController> {


  FirebaseAuth auth = FirebaseAuth.instance;

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
                  SizedBox(
                    height: height1 * 0.8,
                     // color: Colors.red,
                    child: ListView.builder(
                        itemCount: snap1.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: height1 * .8,
                                width: 500,
                              //  color: Colors.yellow,
                                child: ListView.builder(
                                    itemCount: snap1.data!.docs[index]['products'].length,
                                    itemBuilder: (context, i) {
                                      var data = snap1.data!.docs[index]['products'][i];
                                      return Card(
                                        child: ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50 ,
                                            decoration: BoxDecoration(
                                                image:DecorationImage(image: NetworkImage(data['image'],),)
                                            ),
                                          ),
                                          title: Text(data['name']),
                                          subtitle: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                              controller.incrementvalue(i,data);
                                              }, icon: const Icon(Icons.add)),
                                          Obx(()=> Text(controller.p.value.toString())),
                                              IconButton(onPressed: () {
                                                controller.decrementvalue(data);

                                              }, icon: const Icon(Icons.minimize)),
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
                                              }, icon: const Icon(Icons.delete)),
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
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),

      ),
    );
  }
}



