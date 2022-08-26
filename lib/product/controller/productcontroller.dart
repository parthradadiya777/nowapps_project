import 'package:get/get.dart';

class ProductController extends GetxController{
  RxInt p = 0.obs;


  void increment(){
    p++;
    update();
  }

  void Decrement(){
    if(p>0){
      p--;
    }
    update();
  }



}