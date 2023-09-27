import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';

class CustomSnackbar {
  showSnackbar(BuildContext context, String content, String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type == "sale order"
            ? P_Settings.wavecolor
            : type == "sales"
                ? P_Settings.salewaveColor
                : P_Settings.extracolor,
        duration: const Duration(seconds: 1),
        content: Text("${content}"),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Color.fromARGB(255, 246, 246, 247),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
