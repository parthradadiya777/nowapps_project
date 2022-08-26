import 'package:flutter/material.dart';
import 'package:project1/product_details/productslist.dart';
import 'package:project1/store/widgets/backgroundwidget.dart';
import 'package:project1/store/widgets/store_card.dart';




class ShopePage extends StatefulWidget {
  const ShopePage({Key? key}) : super(key: key);

  @override
  State<ShopePage> createState() => _ShopePageState();
}

class _ShopePageState extends State<ShopePage> {

  List p = [
    'Reliance',
    'D-Mart',
    'TATA',
    'Whole Mart'
  ];


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbar,title: Text('Store List',style: style.copyWith(fontSize:20 ),),),
      body: SizedBox(
        height: height,
        width: width,
        child:  Container(
        padding: const EdgeInsets.only(
        left: 25,
        right: 33,
          top: 20
    ),
    height: height * .79,
    // color: Colors.red,
    child: ListView.builder(
    itemCount: 4,
    itemBuilder: (context, index) {
    return Store_card(
    shop_name: p[index],
    onTap: () {
      Navigator.pushNamed(context, ProductList.id,arguments: {
        'shop': p[index]
      });
    },
    );
    }),

      ),
      )
    );
  }
}
