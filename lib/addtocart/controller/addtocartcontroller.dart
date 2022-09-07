
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project1/sqflite_service/sqflite_service.dart';
import '../../model/sqflite_model.dart';
import '../../store/widgets/backgroundwidget.dart';


class AddCartController extends GetxController{


  RxDouble totalprice = 0.0.obs;

  void calcTotal() async{
    double total = (await Producthelper().calculateTotal())[0]['Total'];
    print(total);
    totalprice.value = total;
    print(totalprice);
    update();
  }

  var total=0.0.obs;
  void increment(double price)=>total.value+=price;
  void decrement(int price)=>total.value-=price;





  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    calcTotal();

  }


}