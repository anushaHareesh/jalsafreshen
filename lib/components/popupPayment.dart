import 'package:flutter/material.dart';
import 'package:salesapp/components/common_popup.dart';
import 'package:salesapp/components/commoncolor.dart';

class PaymentSelect {
  showpaymentSheet(
    BuildContext context,
    String areaId,
    String areaName,
    String cusid,
    String date,
    String time,
    String ref,
    String reason,
    double baserate,
  ) {
    Size size = MediaQuery.of(context).size;
    String? payment_mode;
    print("base rate..for insert...........$baserate");
    CommonPopup salepopup = CommonPopup();
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: const Text('Cash',style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                            primary: P_Settings.salewaveColor,
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          payment_mode = "-2";
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                salepopup.buildPopupDialog(
                              "sales",
                              context,
                              "Confirm your sale?",
                              areaId,
                              areaName,
                              cusid,
                             date,
                              time,
                              "",
                              "",
                              payment_mode!,
                             
                            ),
                          );
                          print(
                              "payment mode...........$payment_mode...........$baserate");
                        }),
                    SizedBox(
                      width: size.width * 0.06,
                    ),
                    ElevatedButton(
                        child: const Text('Credit',style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                            primary: P_Settings.salewaveColor,
                            textStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          payment_mode = "-3";
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                salepopup.buildPopupDialog(
                              "sales",
                              context,
                              "Confirm your sale?",
                              areaId,
                              areaName,
                              cusid,
                             date,
                              time,
                              "",
                              "",
                              payment_mode!,
                              
                            ),
                          );
                          // print("payment mode...........$payment_mode");
                        }),
                  ],
                ),
                // SizedBox(
                //   height: size.height * 0.03,
                // ),
                // ElevatedButton(
                //     child: const Text('Done'),
                //     style: ElevatedButton.styleFrom(
                //         primary: Colors.green,
                //         textStyle: TextStyle(
                //             fontSize: 15,
                //             fontWeight:
                //                 FontWeight.bold)),
                //     onPressed: () {
                //       print(
                //           "payment_mode...${payment_mode}");

                //     }),
              ],
            ),
          ),
        );
      },
    );
  }
}
