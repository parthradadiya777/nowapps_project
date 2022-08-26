import 'package:get/get.dart';

class ProductController extends GetxController{
  RxInt quantity = 0.obs;


  void increment(){
    quantity++;
    update();
  }

  void Decrement(){
    if(quantity>0){
      quantity--;
    }
    update();
  }



}