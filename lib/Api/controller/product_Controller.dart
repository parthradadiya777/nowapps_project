import 'package:get/get.dart';
import '../../sqflite_service/sqflite_service.dart';
import '../serices/product_services.dart';

class ProductApiController extends GetxController with StateMixin {


  void ProductApiList(){
    ProductServices().ProductServiceList().then((resp){
      Get.log("Success");
   //  log(resp.toString());
      change(resp, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error());
      Get.log("Fail");
    }
    );
  }


  RxList list = [].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Producthelper().fetchdata();
  }
}