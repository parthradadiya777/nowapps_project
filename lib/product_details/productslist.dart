import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/Api/serices/product_services.dart';
import 'package:project1/product/product.dart';
import 'package:project1/store/widgets/backgroundwidget.dart';

import '../Api/controller/product_Controller.dart';
import '../addtocart/addtocart.dart';
import '../sqflite_service/sqflite_service.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);
  static const id = '/productList';
  @override
  State<ProductList> createState() => _ProductListState();
}
int count=0;


class _ProductListState extends State<ProductList> {



  ProductApiController productApiController = ProductApiController();
  Producthelper helper = Producthelper();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    //counttotal();
    Producthelper().fetchdata();
    autoReload();
  }
  @override
  void autoReload() {
    setState(() {
      helper.count;
    });
  }

  // void counttotal(){
  // var sum = helper.fetchdata();
  // setState(() {
  //   count = sum;
  // });
  // }

  @override

  Widget build(BuildContext context) {

  productApiController.ProductApiList();

  final data = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
 var name = data['shop'];
    double height =MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;



    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbar,
        title: Text(name),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Stack(
              children: [
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> AddtoCartPage()));
                }, icon: const Icon(Icons.add_shopping_cart),),
                Positioned(
                  top: 0,
                    right: 10,
                    child: Obx(()=> Text(helper.count.toString()))),

              ],
            ),
          ),
         // helper.obx((q)=> Text(q.toString())),



        ],
      ),

      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
                height: height *.897,
                width:width,
           //     color: Colors.blueGrey,
              padding: const EdgeInsets.symmetric(vertical: 7, ),
                child:
                    productApiController.obx((enq)=>ListView.builder(
                      itemCount: enq.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10,top: 5 ),
                          child: Card(
                            child: ListTile(
                              onTap: (){
                                Navigator.pushNamed(context,Product_quntity.id,arguments: {
                                  'whole':enq[index]
                                } );
                              },

                              leading: Container(
                                height: 50,
                                width: 50 ,
                                decoration: BoxDecoration(
                                  image:DecorationImage(image: NetworkImage(enq[index]['thumbnail'],),),
                                ),
                              ),
                              title:  Text(enq[index]['title']),
                           //   trailing: Text(enq[index]['price']),
                            ),
                          ),
                        );
                      }),
                    ),)
          ],
        ),
      ),
    );
  }
}
