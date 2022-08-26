import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../store/storeview.dart';


class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      Fluttertoast.showToast(
        msg: "Verification Completed",
      );
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      Fluttertoast.showToast(
        msg: exception.toString(),
      );
    };
    PhoneCodeSent? codeSent =
        (String verificationID, [int? forceResnedingtoken]) {
      Fluttertoast.showToast(msg: "Verification Code sent on the phone number");
      setData(verificationID);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      Fluttertoast.showToast(msg: "Time out");
    };
    try {
      await _auth.verifyPhoneNumber(
          timeout: const Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(String verificationId, String smsCode,
      BuildContext context,  String phone) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      if (user != null) {
        var uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection('user').doc(uid).set({
          'number': phone,

        });
     //   Get.offAll(() => BottomNavigationBarView());
        Navigator.push(context, MaterialPageRoute(builder: (_)=> ShopePage()));

        print('success');
      } else {
        Fluttertoast.showToast(msg: 'error');
      }
      // storeTokenAndData(userCredential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => ShopePage()),
              (route) => false);

      showSnackBar(context, "SuccessFully Loggin With Phone Number");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}