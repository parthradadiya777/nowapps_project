import 'package:get/get.dart';

class ProductServices extends GetConnect{

 Future ProductServiceList() async {
  final response = await get('https://dummyjson.com/products');
  return response.body['products'];
 }

}