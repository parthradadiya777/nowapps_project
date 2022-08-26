import 'package:flutter/material.dart';

class Store_card extends StatelessWidget {
  Store_card(
      {Key? key,
        required this.onTap,
        this.shop_name})
      : super(key: key);

  Function() onTap;
  String? shop_name;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 300,
        // width: 250,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 6, right: 5),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //color: Colors.red,
        child: Stack(children: [
     //     ClipRRect(borderRadius: BorderRadius.circular(10), child: image),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 16, top: 18),
              height: height * .076,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.35),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 0),
                        color: Colors.white.withOpacity(.65),
                        )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(shop_name!, ),
                  const SizedBox(
                    height: 5,
                  ),

                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
