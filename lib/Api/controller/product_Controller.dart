import 'package:get/get.dart';
import 'package:project1/product_details/productslist.dart';
import '../serices/product_services.dart';

class ProductApiController extends GetxController with StateMixin {


  void ProductApiList(){
    ProductServices().ProductServiceList().then((resp){
      Get.log("Success");
   //   log(resp.toString());

      change(resp, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error());
      Get.log("Fail");
    }
    );
  }


}