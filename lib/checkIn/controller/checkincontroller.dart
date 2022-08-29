import 'package:get/get.dart';

class CheckInController extends GetxController{

  RxBool value = false.obs;


  void toggle(){
    value.value = value.value ? false : true;
  }


}