import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class AuthController extends GetxController {

  RxInt start = 30.obs;
  RxBool wait = false.obs;
  RxString smsCode = "".obs;
  TextEditingController phone = TextEditingController();

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer.periodic(onsec, (timer) {
      if (start.value == 0) {
        timer.cancel();
        wait = false.obs;
        update();
      } else {
        start--;
        update();
      }
    });
  }

 Padding optfield(BuildContext context) {
  return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child:
      OTPTextField(
        length: 6,
        width: MediaQuery
            .of(context)
            .size
            .width - 34 * .2,
        fieldWidth: 58,
        otpFieldStyle: OtpFieldStyle(
          backgroundColor: const Color(0xff1d1d1d),
          borderColor: Colors.white,
        ),
        style: const TextStyle(fontSize: 17, color: Colors.white),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        // fieldStyle: FieldStyle.underline,
        onCompleted: (pin) {
          //print("Completed: " + pin);
          smsCode.value = pin;
        },
      ),

    );
    update();
  }


}
