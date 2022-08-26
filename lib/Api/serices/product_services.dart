import 'package:get/get.dart';

class ProductServices extends GetConnect{

 Future enquiryList() async {
  final response = await get('https://jsonkeeper.com/b/YIDG');
  return response.body['data']['products'];
 }

}