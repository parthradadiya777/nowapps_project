import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project1/product_details/productslist.dart';
import '../store/widgets/backgroundwidget.dart';
import 'controller/checkincontroller.dart';

class CheckIn extends GetView<CheckInController>{

static const id = '/checkin';
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() =>CheckInController());
    double height1 = MediaQuery.of(context).size.height;
    double width1 = MediaQuery.of(context).size.width;
final data = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
var name = data['shop'];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appbar,
        title:  Text('$name : CheckIn'),
      ),
      body:SizedBox(
        height: height1,
        width: width1,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
        RichText(text: TextSpan(children:[
          TextSpan(
            text: 'Note:',
            style: style.copyWith(color: Colors.redAccent,fontSize: 20)
          ),

           TextSpan(
            text: '  After CheckIn CheckOut Not possible',
            style: style.copyWith(fontWeight: FontWeight.bold)
          ),

        ])),
            SizedBox(
              height: 10,
            ),
            Container(
              height: height1 * 0.08,
              width: width1 * 0.5,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(10)
              ),
              child: MaterialButton(onPressed: (){
                showDialog(context: context, builder: (_){
                  return AlertDialog(
                    title: Text('Are you Sure purchased'),
                  content: Text('After Check In Can not Go Back'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, ProductList.id, (route) => false,arguments: {
                          'shop': name
                        });
                      }, child: Text('Yes')),
                      TextButton(onPressed: (){
                       Navigator.pop(context);
                      }, child: Text('No')),
                    ],

                  );

                });

              },
               child: Text('Check In',style: style,),
              ),
            )

          ],
        )
      ),
    );
  }
}