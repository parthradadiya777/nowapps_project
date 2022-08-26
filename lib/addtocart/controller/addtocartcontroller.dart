import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../store/widgets/backgroundwidget.dart';


class AddCartController extends GetxController{

  Alignment alignment = Alignment.center;
  Curve curve = Curves.ease;
  Color c = Colors.yellow.withOpacity(0.5);
  RxDouble height = 90.00.obs;
  RxDouble width = 200.00.obs;
  TextStyle style1 = TextStyle(fontSize: 20,color: textColor);
  RxDouble size = 20.00.obs;


}