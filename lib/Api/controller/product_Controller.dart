import 'package:get/get.dart';
import '../serices/product_services.dart';

class ProductApiController extends GetxController with StateMixin {
 // RxList data = <ProductElement>[].obs;
  var isLoading = true.obs;

  void enquiryList(){
    ProductServices().enquiryList().then((resp){
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