import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/product/product.dart';
import 'package:project1/store/widgets/backgroundwidget.dart';

import '../Api/controller/product_Controller.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);
  static const id = '/productList';

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {



  ProductApiController p1 = ProductApiController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  p1.enquiryList();

  final data = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
 var name = data['shop'];

    double height =MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbar,
        title: Text(name),

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
                    p1.obx((enq)=>ListView.builder(
                      itemCount: enq.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10,top: 5 ),
                          child: Card(
                            child: ListTile(
                              onTap: (){
                                Navigator.pushNamed(context,Product.id,arguments: {
                                  'whole':enq[index]
                                } );
                              },

                              leading: Container(
                                height: 50,
                                width: 50 ,
                                decoration: BoxDecoration(
                                  image:DecorationImage(image: NetworkImage(enq[index]['prodImage'],),)
                                ),
                              ),
                              title:                             Text(enq[index]['prodName']),
                              trailing: Text(enq[index]['prodPrice']),
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
