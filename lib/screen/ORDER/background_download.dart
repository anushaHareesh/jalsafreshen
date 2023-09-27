// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:orderapp/main.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../controller/controller.dart';

// // doSomethingHeavy(BuildContext context) {
// //   AutoDownload down = AutoDownload();
// //   Timer(
// //     const Duration(seconds: 3),
// //     () {
// //       print("done");

// //       down.DownloadData(context);

// //       // Navigate to your favorite place
// //     },
// //   );
// // }

// class AutoDownload {
//   DownloadData(BuildContext context) async {
//     print("inside manager");
//     String? formattedDate;
//     List s = [];
//     DateTime date = DateTime.now();
//     formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
//     s = formattedDate.split(" ");
//     String? cid;
//     String? userType;
//     String? sid;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     cid = prefs.getString("cid");
//     userType = prefs.getString("userType");
//     sid = prefs.getString("sid");
//     print("cid.. sid...userType  $cid $userType $sid");
//     Future.delayed(const Duration(seconds: 2), () {
//       print("download acount heads ");
//       Provider.of<Controller>(context, listen: false)
//           .getaccountHeadsDetails(context, s[0], cid!);
//     });

//     Future.delayed(const Duration(milliseconds: 500), () {
//       print("download product details ");

//       Provider.of<Controller>(context, listen: false).getProductDetails(cid!);
//     });
//     Future.delayed(const Duration(seconds: 1), () {
//       print("download product category ");

//       Provider.of<Controller>(context, listen: false).getProductCategory(cid!);
//     });

//     Future.delayed(const Duration(milliseconds: 800), () {
//       print("download product wallet ");

//       Provider.of<Controller>(context, listen: false).getWallet(context);
//     });
//     Future.delayed(const Duration(milliseconds: 1000), () {
//       print("download product company ");

//       Provider.of<Controller>(context, listen: false).getProductCompany(cid!);
//     });
//   }
// }
