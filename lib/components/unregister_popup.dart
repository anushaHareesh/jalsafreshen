import 'package:flutter/material.dart';
import 'package:salesapp/screen/ORDER/1_companyRegistrationScreen.dart';

class Unreg {
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => RegistrationScreen()));
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => RegistrationScreen()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Do you want to unregister!!",
        style: TextStyle(fontSize: 14),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
