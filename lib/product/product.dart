import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/store/widgets/backgroundwidget.dart';

import '../addtocart/addtocart.dart';
import 'controller/productcontroller.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  static const id = '/product';
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

  ProductController controller = ProductController();


  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    var whole = data['whole'];
    var image = whole['prodImage'];
    var name = whole['prodName'];
    var price = whole['prodPrice'];

    double q = double.parse(price);
  //  controller.q.value = price;
    //p1(price);
     double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbar,
        title: Text('Product'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height*.12,),
          Container(
              height: height * .3,
              width: width,
              child: Image.network(image)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('Product Name: $name',style: style),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('Product Price: $price',style: style,),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            // Text(p.toString()),
        IconButton(onPressed: (){
              controller.increment();

                }, icon: Icon(Icons.add,color: textColor,)),
                Obx(()=> Text(controller.p.toString(),style: style)),
                IconButton(onPressed: (){
                 controller.Decrement();
                }, icon: Icon(Icons.remove,color: textColor,))
              ],


          ),
        Obx(() =>   controller.p.value>0?  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Text("Price: ${q * controller.p.value }",style: style),
            Text("Quntity "+controller.p.toString(),style: style),
            InkWell(
              onTap: (){
                Get.to(()=>AddtoCartPage(),arguments: {
                  'price':q,
                  'quntity':controller.p,
                  'image':image,
                });},
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: width*.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey,
                ),
                child: Text('Add To Cart',style: style),

              ),
            ),
          ],
        ) : Container() )


        ],
      ),
    );
  }
}
