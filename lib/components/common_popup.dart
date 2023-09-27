import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:salesapp/screen/ORDER/0_dashnew.dart';
import 'package:salesapp/screen/ORDER/5_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonPopup {
  int sales_id = 0;
  String? cid;
  String? gen_condition;
  String? sid;
  Widget buildPopupDialog(
    String type,
    BuildContext context,
    String content,
    String areaid,
    String areaname,
    String custmerId,
    String date,
    String time,
    String ref,
    String reason,
    String payment_mode,
    // double baserate,
  ) {
    Timer? _timer;

    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${content}"),
        ],
      ),
      actions: [
        Consumer<Controller>(
          builder: (context, value, child) {
            return ElevatedButton(
                onPressed: () async {
                  sid = await Provider.of<Controller>(context, listen: false)
                      .setStaffid(value.sname!);
                  final prefs = await SharedPreferences.getInstance();
                  String? sid1 = await prefs.getString('sid');
                  cid = await prefs.getString('cid');
                  print("Sid........${value.sname}$sid1");

                  String? os = await prefs.getString('os');
                  String? gen_area =
                      Provider.of<Controller>(context, listen: false)
                          .areaidFrompopup;
                  if (gen_area != null) {
                    gen_condition = " and accountHeadsTable.area_id=$gen_area";
                  } else {
                    gen_condition = " ";
                  }
////////////////////////////////////////////////////////////////////////////////////////////////////
                  if (type == "sales") {
                    print("fkjsdfj");
                    // Provider.of<Controller>(context, listen: false)
                    //     .calculatesalesTotal(os!, custmerId);

                    // if (Provider.of<Controller>(context, listen: false)
                    //         .salebagList
                    //         .length >
                    //     0) {
                    //   String? sOs = "$os";
                    //   sales_id =
                    //       await Provider.of<Controller>(context, listen: false)
                    //           .insertToSalesbagAndMaster(
                    //               sOs,
                    //               date,
                    //               time,
                    //               custmerId,
                    //               sid1!,
                    //               areaid,
                    //               value.salesTotal,
                    //               value.gross_tot,
                    //               value.tax_tot,
                    //               value.dis_tot,
                    //               value.cess_tot,
                    //               context,
                    //               payment_mode,
                    //               value.roundoff,
                    //               "",
                    //               "");
                    // }
                    // Provider.of<Controller>(context, listen: false)
                    //     .todaySales(date, gen_condition!, "");
                  }

                  ////////////////////////////////////////////////////////////////////////////////
                  else if (type == "sale order") {
                    // String? sOs = "O" + "$os";
                    print("inside order.......");
                    if (Provider.of<Controller>(context, listen: false)
                            .bagList
                            .length >
                        0) {
                      Provider.of<Controller>(context, listen: false)
                          .insertToOrderbagAndMaster(
                        os!,
                        date,
                        time,
                        custmerId,
                        sid1!,
                        areaid,
                        double.parse(value.orderTotal1!),
                        context,
                      );
                    }

                    // if (Provider.of<Controller>(context, listen: false)
                    //         .settingsList1[1]["set_value"] ==
                    //     "YES") {
                    //   print("upload----");
                    //   Provider.of<Controller>(context, listen: false)
                    //       .uploadOrdersData(cid!, context, 0, "comomn popup");
                    // }

                    Provider.of<Controller>(context, listen: false)
                        .todayOrder(date, gen_condition!);
                  } else if (type == "return") {
                    if (Provider.of<Controller>(context, listen: false)
                            .returnbagList
                            .length >
                        0) {
                      String? sOs = "R" + "$os";
                      Provider.of<Controller>(context, listen: false)
                          .insertreturnMasterandDetailsTable(
                        sOs,
                        date,
                        time,
                        custmerId,
                        sid1!,
                        areaid,
                        value.returnTotal,
                        ref,
                        reason,
                        context,
                      );
                      Provider.of<Controller>(context, listen: false)
                          .returnCount = 0;

                      // if (Provider.of<Controller>(context, listen: false)
                      //         .settingsList1[0]["set_value"] ==
                      //     "YES") {
                      //   print("upload----");
                      //   Provider.of<Controller>(context, listen: false)
                      //       .uploadReturnData(cid!, context, 0, "comomn popup");
                      // }
                    }
                  }

                  Provider.of<Controller>(context, listen: false)
                      .clearList(value.areDetails);

                  // return  showDialog(context: context, builder: builder)
                  if (type == "sales") {
                    Provider.of<Controller>(context, listen: false)
                        .calculatesalesTotal(os!, custmerId);

                    if (Provider.of<Controller>(context, listen: false)
                            .salebagList
                            .length >
                        0) {
                      String? sOs = "$os";
                      sales_id =
                          await Provider.of<Controller>(context, listen: false)
                              .insertToSalesbagAndMaster(
                                  sOs,
                                  date,
                                  time,
                                  custmerId,
                                  sid1!,
                                  areaid,
                                  value.salesTotal,
                                  value.gross_tot,
                                  value.tax_tot,
                                  value.dis_tot,
                                  value.cess_tot,
                                  context,
                                  payment_mode,
                                  value.roundoff,
                                  "",
                                  "");
                    }

                    Provider.of<Controller>(context, listen: false)
                        .deleteFromSalesBagTable(custmerId);
                    // Provider.of<Controller>(context, listen: false)
                    //     .todaySales(date, gen_condition!, "");
                    return showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          Size size = MediaQuery.of(context).size;

                          // Future.delayed(Duration(seconds: 2), () {
                          //   Navigator.of(context).pop(true);

                          //   Navigator.of(context).push(
                          //     PageRouteBuilder(
                          //         opaque: false, // set to false
                          //         pageBuilder: (_, __, ___) => Dashboard(
                          //             type: "return from cartList",
                          //             areaName: areaname)
                          //         // OrderForm(widget.areaname,"return"),
                          //         ),
                          //   );
                          // });
                          return AlertDialog(
                              backgroundColor: Colors.white,
                              content: Container(
                                height: 150,
                                child: Column(
                                  children: [
                                    Text("Do you want to print"),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            List<Map<String, dynamic>> result =
                                                await OrderAppDB.instance
                                                    .printcurrentData(sales_id);
                                            print(
                                                "resulttytydghkdj......$result");
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .printSales(
                                                    cid!,
                                                    context,
                                                    result[0],
                                                    areaname,
                                                    "not cancelled");
                                            // Navigator.pop(context);

                                            // Sunmi printer = Sunmi();
                                            // printer.printReceipt(
                                            //     value.printSalesData,
                                            //     result[0]["payment_mode"]);
                                            //   Navigator.of(context).push(
                                            //   PageRouteBuilder(
                                            //       opaque: false, // set to false
                                            //       pageBuilder: (_, __, ___) =>
                                            //           Dashboard(
                                            //               type: "",
                                            //               areaName: areaname)
                                            //       // OrderForm(widget.areaname,"return"),
                                            //       ),
                                            // );
                                            // _timer?.cancel();
                                            // await EasyLoading.show(
                                            //   status: 'printing...',
                                            //   maskType: EasyLoadingMaskType.black,
                                            // );
                                            // Future.delayed(
                                            //     const Duration(milliseconds: 500));
                                            // await EasyLoading.dismiss();

                                            // Future.delayed(
                                            //     const Duration(milliseconds: 500),
                                            //     () {
                                            //   Navigator.of(context).push(
                                            //     PageRouteBuilder(
                                            //         opaque: false, // set to false
                                            //         pageBuilder: (_, __, ___) =>
                                            //             Dashboard(
                                            //                 type: "",
                                            //                 areaName: areaname)
                                            //         // OrderForm(widget.areaname,"return"),
                                            //         ),
                                            //   );
                                            // });
                                            // await EasyLoading.dismiss();
                                          },
                                          child: Text(
                                            "Yes",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: P_Settings.salewaveColor,
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.03,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  Size size =
                                                      MediaQuery.of(context)
                                                          .size;

                                                  Future.delayed(
                                                      Duration(seconds: 2), () {
                                                    Navigator.of(context)
                                                        .pop(true);

                                                    Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                          opaque:
                                                              false, // set to false
                                                          pageBuilder: (_, __,
                                                                  ___) =>
                                                              Dashboard(
                                                                  type:
                                                                      "return from sales",
                                                                  areaName:
                                                                      areaname)
                                                          // OrderForm(widget.areaname,"return"),
                                                          ),
                                                    );
                                                  });
                                                  return AlertDialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      content: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            '$type  Placed!!!!',
                                                            style: TextStyle(
                                                                color: P_Settings
                                                                    .extracolor),
                                                          ),
                                                          Icon(
                                                            Icons.done,
                                                            color: Colors.green,
                                                          )
                                                        ],
                                                      ));
                                                });

                                            // Navigator.pop(context);
                                          },
                                          child: Text(
                                            "No",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: P_Settings.salewaveColor,
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),

                                    // Text(
                                    //   '$type  Placed!!!!',
                                    //   style:
                                    //       TextStyle(color: P_Settings.extracolor),
                                    // ),
                                    // Icon(
                                    //   Icons.done,
                                    //   color: Colors.green,
                                    // )
                                  ],
                                ),
                              ));
                        });
                  } else {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          Size size = MediaQuery.of(context).size;

                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).pop(true);
                            if (type == "sale order") {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                    opaque: false, // set to false
                                    pageBuilder: (_, __, ___) =>
                                        Dashboard(type: " ", areaName: areaname)
                                    // OrderForm(widget.areaname,"return"),
                                    ),
                              );
                            } else if (type == 'return') {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                    opaque: false, // set to false
                                    pageBuilder: (_, __, ___) => Dashboard(
                                        type: "return from return",
                                        areaName: areaname)
                                    // OrderForm(widget.areaname,"return"),
                                    ),
                              );
                            }
                          });
                          return AlertDialog(
                              backgroundColor: Colors.white,
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '$type  Placed!!!!',
                                    style:
                                        TextStyle(color: P_Settings.extracolor),
                                  ),
                                  Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                ],
                              ));
                        });
                  }

                  // Provider.of<Controller>(context, listen: false).count = "0";

                  // Navigator.of(context).pop();
                },
                child: Text("Ok"));
          },
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
      ],
    );
  }
}
