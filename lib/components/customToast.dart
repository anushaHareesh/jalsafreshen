import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  Future<bool?> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        // timeInSecForIos: 4,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
