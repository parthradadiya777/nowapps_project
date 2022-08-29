
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../store/widgets/backgroundwidget.dart';


class AddCartController extends GetxController{

  Alignment alignment = Alignment.center;
  Curve curve = Curves.ease;
  Color c = Colors.yellow.withOpacity(0.5);
  RxDouble height = 90.00.obs;
  RxDouble width = 200.00.obs;
  TextStyle style1 = TextStyle(fontSize: 20,color: textColor);
  RxDouble size = 20.00.obs;


  RxList list = [].obs;
  
  RxInt p = 0.obs;


   incrementvalue(index,data){
    //var count = snap1.data!.docs[index]['products'].length;
// list = [].obs;

       p.value = data['quantity']++;
        print(data['quantity']);
        print("ppppp"+p.value.toString());
      

       // list[index][p.value];

        // list.add(p.value);
        //
        // list.join();


      //  return p.value;
      //   print(temp[index]);
//   print(index);

   // print(index);
    //list.join();
    // print(list.join());
 // //p.value = temp[index]['quantity'];
 // print(temp);
//  print(p.value);
   // temp['quantity'][index] = p.value;
   update();

 //   data1(data);
  }

  void decrementvalue(data) {
    list = [].obs;
    if(data['quantity'] >0) {
      list.add(data['quantity']--);
    }
    list.join();
    print(list.join());

    update();
    //   data1(data);
  }

}