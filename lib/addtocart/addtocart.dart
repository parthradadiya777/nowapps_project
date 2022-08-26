import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/store/widgets/backgroundwidget.dart';
import '../store/storeview.dart';
import 'controller/addtocartcontroller.dart';

class AddtoCartPage extends GetView<AddCartController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() =>AddCartController());
    final data = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    double height1 = MediaQuery.of(context).size.height;
    double width1 = MediaQuery.of(context).size.width;
    var price = data['price'];
    var quntity = data['quntity'];
    var image = data['image'];


    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text('Add to Cart Page',),
      ),
      body:SizedBox(
        height: height1,
        width: width1,
        child: ListView(
            children: [
              Obx(
            ()=> AnimatedContainer(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: controller.height.value,
                  width: controller.width.value,
                  decoration: BoxDecoration(
                    color: controller.c,),
                  duration: const Duration(seconds: 2),
                  // alignment: alignment,
                  curve: controller.curve,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 150,
                        width: 100 ,
                        decoration: BoxDecoration(
                            image:DecorationImage(image: NetworkImage(image),)
                        ),
                      ),
                      Text(
                        'Price: $price'
                        ,style: controller.style1,),
                      Text('quntity: $quntity',style: controller.style1,),
                      IconButton(onPressed: (){
                          controller.curve = Curves.easeInBack;
                          controller.c = Colors.red;
                          controller.height.value = 0.0;
                          controller.width.value = 0.0;
                          controller.style1 = const TextStyle(fontSize: 0);
                          controller.size.value = 0.0;



                      }, icon: Icon(Icons.delete,size: controller.size.value,color: textColor,))
                    ],
                  ),
                ),
              ),
              Obx(() =>
              controller.height.value!=0.0?  MaterialButton(onPressed: (){
                showDialog(context: context, builder: (_){
                  return AlertDialog(
                    title: const Text('Are you Sure Confirm Order'),
                    content: Text('Your Quantity: $quntity and Price: $price'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> const ShopePage()));
                      }, child: const Text('Yes')),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: const Text('No')),

                    ],
                  );
                });
              },child: Text('Confirm',style: style,),) : Center(child: Text('No Data',style: style,)),
              )]
        ),
      ),
    );
  }
}



// class AddtoCartPage extends StatefulWidget {
//
//  static const id = '/addcartpage';
//
//   const AddtoCartPage({Key? key}) : super(key: key);
//
//   @override
//   State<AddtoCartPage> createState() => _AddtoCartPageState();
// }
//
// class _AddtoCartPageState extends State<AddtoCartPage> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final data = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
//     double height1 = MediaQuery.of(context).size.height;
//     double width1 = MediaQuery.of(context).size.width;
//     var price = data['price'];
//     var quntity = data['quntity'];
//     var image = data['image'];
//
//
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: appbar,
//         title: const Text('Add to Cart Page',),
//       ),
//       body:SizedBox(
//         height: height1,
//         width: width1,
//         child: ListView(
//           children: [
//             AnimatedContainer(
//               margin: const EdgeInsets.symmetric(vertical: 20),
//               height: height,
//               width: width,
//               decoration: BoxDecoration(
//               color: c,),
//               duration: const Duration(seconds: 2),
//               // alignment: alignment,
//               curve: curve,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     height: 150,
//                     width: 100 ,
//                     decoration: BoxDecoration(
//                         image:DecorationImage(image: NetworkImage(image),)
//                     ),
//                   ),
//                   Text(
//                     'Price: $price'
//                   ,style: style1,),
//                   Text('quntity: $quntity',style: style1,),
//                   IconButton(onPressed: (){
//                     setState(() {
//                       curve = Curves.easeInBack;
//                       c = Colors.red;
//                       height = 0.0;
//                       width = 0.0;
//                       style1 = const TextStyle(fontSize: 0);
//                       size = 0.0;
//
//
//                     });
//                   }, icon: Icon(Icons.delete,size: size,color: textColor,))
//                 ],
//               ),
//             ),
//           height!=0.0?  MaterialButton(onPressed: (){
//               showDialog(context: context, builder: (_){
//                 return AlertDialog(
//                   title: const Text('Are you Sure Confirm Order'),
//                   content: Text('Your Quantity: $quntity and Price: $price'),
//                   actions: [
//                     TextButton(onPressed: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (_)=> const ShopePage()));
//                     }, child: const Text('Yes')),
//                     TextButton(onPressed: (){
//                       Navigator.pop(context);
//                     }, child: const Text('No')),
//
//                   ],
//                 );
//               });
//             },child: Text('Confirm',style: style,),) : Center(child: Text('No Data',style: style,)),
//           ]
//         ),
//       ),
//     );
//   }
// }
