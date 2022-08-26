import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project1/store/widgets/backgroundwidget.dart';
import 'authclass.dart';
import 'controller/authcontroller.dart';


class PhoneView extends StatefulWidget {
  @override
  _PhoneViewState createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  AuthController controller = AuthController();
  String buttonName = "Send";
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(

        backgroundColor: appbar,
        title: const Text(
          "SignUp",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              textField(),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    const Text(
                      "Enter 6 digit OTP",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
             controller.optfield(context),
                            const SizedBox(
                height: 40,
              ),
              Obx(()=> RichText(
                    text: TextSpan(
                      children: [
                         TextSpan(
                          text: "Send OTP again in ",
                          style:  style,
                        ),

                        TextSpan(
                          text: "00:${controller.start}",
                          style: const TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                         TextSpan(
                          text: " sec ",
                          style: style,
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 150,
              ),
              InkWell(
                onTap: () {
                  authClass.signInwithPhoneNumber(verificationIdFinal,controller.smsCode.value,
                      context, controller.phone.text);
                  },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 70,
                  decoration: BoxDecoration(
                      color:  Colors.white54,
                      borderRadius: BorderRadius.circular(10)),
                  child:  Center(
                    child:  Text(
                      "Lets Go",
                      style: style.copyWith(fontSize: 20)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }




  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller.phone,
        style: const TextStyle(color: Colors.white, fontSize: 17),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone Number",
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 17),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              " (+91) ",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          suffixIcon: Obx(()=>
           InkWell(
              onTap: controller.wait.value
                  ? null
                  : () async {
                  controller.start.value = 30;
                  controller.wait.value = true;

                    buttonName = "Resend";

                await authClass.verifyPhoneNumber(
                    "+91 ${controller.phone.text}", context, setData);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Text(
                  buttonName,
                  style: TextStyle(
                    color: controller.wait.value ? Colors.grey : Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    controller.startTimer();
  }
}