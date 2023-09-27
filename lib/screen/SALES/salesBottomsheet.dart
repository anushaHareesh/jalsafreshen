import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';

class SalesBottomSheet {
  sheet(BuildContext context, String itemcount, String netAmt, String discount,
      String tax, String cess, String grosstot, double roundoff) {
    Size size = MediaQuery.of(context).size;
    double total = roundoff + double.parse(netAmt);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          print("order total.........$grosstot..$netAmt");
          return SingleChildScrollView(
            child: Container(
              // height: size.height * 0.9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: P_Settings.extracolor,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        ListTile(
                          // leading: Icon(
                          //   Icons.numbers,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Item count : '),
                              Spacer(),
                              Text(
                                '$itemcount',
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          // leading: Icon(
                          //   Icons.currency_rupee_outlined,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text('Gross total : '),
                              Spacer(),
                              Text(
                                '\u{20B9}${grosstot}',
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          // leading: Icon(
                          //   Icons.discount,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text('Discount : '),
                              Spacer(),
                              Text(
                                '\u{20B9} ${discount}',
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          // leading: Icon(
                          //   Icons.currency_rupee_outlined,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text('Tax : '),
                              Spacer(),
                              Text(
                                '\u{20B9}$tax',
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          // leading: Icon(
                          //   Icons.currency_rupee_outlined,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text('Cess : '),
                              Spacer(),
                              Text(
                                '\u{20B9}${cess}',
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          // leading: Icon(
                          //   Icons.currency_rupee_outlined,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text('Roundoff : '),
                              Spacer(),
                              Text(
                                roundoff.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          // leading: new Icon(
                          //   Icons.currency_rupee_outlined,
                          //   color: P_Settings.salewaveColor,
                          // ),
                          title: Row(
                            children: [
                              Text(
                                'Net amount : ',
                                style: TextStyle(color: P_Settings.extracolor),
                              ),
                              Spacer(),
                              Text(
                                '\u{20B9}${total.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: P_Settings.extracolor,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
