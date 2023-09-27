// import 'package:flutter/material.dart';
// import 'package:orderapp/components/commoncolor.dart';
// import 'package:orderapp/controller/controller.dart';
// import 'package:orderapp/db_helper.dart';
// import 'package:provider/provider.dart';

// class SaleItemDetails {
//   List rawCalcResult = [];
//   showsalesMoadlBottomsheet(
//     String item,
//     String code,
//     String hsn,
//     double qty,
//     double rate,
//     double dis_per,
//     double dis_amt,
//     double tax_per,
//     double tax_amt,
//     double cess_per,
//     double cess_amt,
//     double net_amt,
//     double gross,
//     BuildContext context,
//     Size size,
//     int index,
//     String customerId,
//     String os,
//   ) {
//     return showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           print("param---$qty----$dis_per--$dis_amt--$net_amt--$tax_amt");
//           // rawCalcResult = Provider.of<Controller>(context,listen: false).rawCalculation(rate,qty.toDouble(), 0.0, 100,tax_per, 0.0, "0", 0);
//           return Consumer<Controller>(
//             builder: (context, value, child) {
//               // value.discount_prercent[index].text = dis_per.toString();
//               // value.discount_amount[index].text = dis_amt.toString();
//               // value.salesqty[index].text = qty.toString();
//               return SingleChildScrollView(
//                 child: Container(
//                   // height: size.height * 0.96,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).viewInsets.bottom,
//                     ),
//                     child: Column(
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             IconButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 icon: Icon(
//                                   Icons.close,
//                                   color: P_Settings.extracolor,
//                                 )),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   item,
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.green),
//                                 ),
//                                 Text("-"),
//                                 Text(
//                                   "( $code)",
//                                   style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 20, right: 20),
//                               child: Divider(
//                                 thickness: 2,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [],
//                         ),
//                         ListTile(
//                           title: Row(
//                             children: [
//                               Text(
//                                 "Hsn",
//                               ),
//                               Spacer(),
//                               Text(
//                                 hsn,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           title: Row(
//                             children: [
//                               Text(
//                                 "Qty",
//                               ),
//                               Spacer(),
//                               Container(
//                                 width: size.width * 0.2,
//                                 child: TextField(
//                                   keyboardType: TextInputType.number,
//                                   onSubmitted: (values) {
//                                     print("values----$values");
//                                     double valueqty = 0.0;
//                                     // value.discount_amount[index].text=;
//                                     if (values.isNotEmpty) {
//                                       print("emtyyyy");
//                                       valueqty = double.parse(values);
//                                     } else {
//                                       valueqty = 0.00;
//                                     }
//                                     Provider.of<Controller>(context,
//                                             listen: false)
//                                         .fromDb = false;
//                                     Provider.of<Controller>(context,
//                                             listen: false)
//                                         .rawCalculation(
//                                             double.parse(
//                                                 value.salesrate[index].text),
//                                             valueqty,
//                                             dis_per,
//                                             dis_amt,
//                                             tax_per,
//                                             0.0,
//                                             value.settingsList1[5]['set_value']
//                                                 .toString(),
//                                             0,
//                                             index,
//                                             true,
//                                             "qty");
//                                   },
//                                   textAlign: TextAlign.right,
//                                   // decoration: InputDecoration(
//                                   //   border: InputBorder.none,
//                                   // ),
//                                   controller: value.salesqty[index],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Provider.of<Controller>(context, listen: false)
//                                     .settingsList1[0]["set_value"] ==
//                                 "YES"
//                             ? ListTile(
//                                 title: Row(
//                                   children: [
//                                     Text(
//                                       "Rate",
//                                     ),
//                                     Spacer(),
//                                     Container(
//                                       width: size.width * 0.2,
//                                       child: TextField(
//                                         keyboardType: TextInputType.number,
//                                         onSubmitted: (values) {
//                                           print("values----$values");
//                                           double valuerate = 0.0;
//                                           // value.discount_amount[index].text=;
//                                           if (values.isNotEmpty) {
//                                             print("emtyyyy");
//                                             valuerate = double.parse(values);
//                                           } else {
//                                             valuerate = 0.00;
//                                           }
//                                           Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .fromDb = false;

//                                           Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .rawCalculation(
//                                                   valuerate,
//                                                   double.parse(value
//                                                       .salesqty[index].text),
//                                                   dis_per,
//                                                   dis_amt,
//                                                   tax_per,
//                                                   0.0,
//                                                   value.settingsList1[5]
//                                                           ['set_value']
//                                                       .toString(),
//                                                   0,
//                                                   index,
//                                                   true,
//                                                   "qty");
//                                         },
//                                         textAlign: TextAlign.right,
//                                         // decoration: InputDecoration(
//                                         //   border: InputBorder.none,
//                                         // ),
//                                         controller: value.salesrate[index],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             : ListTile(
//                                 title: Row(
//                                   children: [
//                                     Text(
//                                       "Rate",
//                                     ),
//                                     Spacer(),
//                                     Text("\u{20B9}${rate.toStringAsFixed(2)}")
//                                   ],
//                                 ),
//                               ),
//                         ListTile(
//                           title: Row(
//                             children: [
//                               Text(
//                                 "Gross value",
//                               ),
//                               Spacer(),
//                               Text(
//                                 value.fromDb!
//                                     ? "\u{20B9}${gross.toStringAsFixed(2)}"
//                                     : "\u{20B9}${value.gross.toStringAsFixed(2)}",
//                               )
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           title: Row(
//                             children: [
//                               Text(
//                                 "Discount %",
//                               ),
//                               Spacer(),
//                               Container(
//                                 width: size.width * 0.2,
//                                 child: TextField(
//                                   keyboardType: TextInputType.number,
//                                   onSubmitted: (values) {
//                                     double valuediscper = 0.0;
//                                     print("values---$values");
//                                     if (values.isNotEmpty) {
//                                       print("emtyyyy");
//                                       valuediscper = double.parse(values);
//                                     } else {
//                                       valuediscper = 0.00;
//                                     }
//                                     Provider.of<Controller>(context,
//                                             listen: false)
//                                         .fromDb = false;

//                                     Provider.of<Controller>(context,
//                                             listen: false)
//                                         .rawCalculation(
//                                             double.parse(
//                                                 value.salesrate[index].text),
//                                             double.parse(
//                                                 value.salesqty[index].text),
//                                             valuediscper,
//                                             double.parse(value
//                                                 .discount_amount[index].text),
//                                             tax_per,
//                                             0.0,
//                                             value.settingsList1[5]['set_value']
//                                                 .toString(),
//                                             0,
//                                             index,
//                                             true,
//                                             "disc_per");
//                                   },
//                                   controller: value.discount_prercent[index],
//                                   textAlign: TextAlign.right,
//                                   // decoration: InputDecoration(
//                                   //   border: InputBorder.none,
//                                   // ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           title: Row(
//                             children: [
//                               Text(
//                                 "Discount Amount",
//                               ),
//                               Spacer(),
//                               Container(
//                                 width: size.width * 0.2,
//                                 child: TextField(
//                                   keyboardType: TextInputType.number,
//                                   onSubmitted: (values) {
//                                     double valuediscamt = 0.0;
//                                     // value.discount_amount[index].text=;
//                                     if (values.isNotEmpty) {
//                                       print("emtyyyy");
//                                       valuediscamt = double.parse(values);
//                                     } else {
//                                       valuediscamt = 0.0000;
//                                     }
//                                     Provider.of<Controller>(context,
//                                             listen: false)
//                                         .fromDb = false;
//                                     print(
//                                         "discount amount..........$valuediscamt");
//                                     Provider.of<Controller>(context,
//                                             listen: false)
//                                         .rawCalculation(
//                                             double.parse(
//                                                 value.salesrate[index].text),
//                                             double.parse(
//                                                 value.salesqty[index].text),
//                                             double.parse(value
//                                                 .discount_prercent[index].text),
//                                             valuediscamt,
//                                             tax_per,
//                                             0.0,
//                                             value.settingsList1[5]['set_value']
//                                                 .toString(),
//                                             0,
//                                             index,
//                                             true,
//                                             "disc_amt");
//                                   },
//                                   controller: value.discount_amount[index],
//                                   textAlign: TextAlign.right,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           title: Row(
//                             children: [
//                               Text(
//                                 "Tax %",
//                               ),
//                               Spacer(),
//                               Text(tax_per.toStringAsFixed(2))
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           title: Row(
//                             children: [
//                               Text(
//                                 "Tax amount",
//                               ),
//                               Spacer(),
//                               tax_amt < 0.00
//                                   ? Text(
//                                       "\u{20B9}0.00",
//                                     )
//                                   : Text(value.fromDb!
//                                       ? "\u{20B9}${tax_amt.toStringAsFixed(2)}"
//                                       : "\u{20B9}${value.tax.toStringAsFixed(2)}")
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           title: Row(
//                             children: [
//                               Text(
//                                 "Cess %",
//                               ),
//                               Spacer(),
//                               Text(cess_per.toStringAsFixed(2))
//                             ],
//                           ),
//                         ),
//                         ListTile(
//                           title: Row(
//                             children: [
//                               Text(
//                                 "Cess amount",
//                               ),
//                               Spacer(),
//                               cess_amt < 0.00
//                                   ? Text(
//                                       "\u{20B9}0.00",
//                                     )
//                                   : Text(value.fromDb!
//                                       ? "\u{20B9}${cess_amt.toStringAsFixed(2)}"
//                                       : "\u{20B9}${value.cess.toStringAsFixed(2)}")
//                             ],
//                           ),
//                         ),
//                         Divider(
//                           thickness: 1,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                           child: ListTile(
//                             title: Row(children: [
//                               Text(
//                                 "Net Amount",
//                                 style: TextStyle(color: P_Settings.extracolor),
//                               ),
//                               Spacer(),
//                               net_amt < 0.00
//                                   ? Text("\u{20B9}0.00",
//                                       style: TextStyle(
//                                           color: P_Settings.extracolor))
//                                   : Text(
//                                       value.fromDb!
//                                           ? "\u{20B9}${net_amt.toStringAsFixed(2)}"
//                                           : "\u{20B9}${value.net_amt.toStringAsFixed(2)}",
//                                       style: TextStyle(
//                                           color: P_Settings.extracolor),
//                                     ),
//                             ]),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                   width: size.width * 0.4,
//                                   child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                         primary: P_Settings.salewaveColor,
//                                       ),
//                                       onPressed: () async {
//                                         int indexCalc = index + 1;
//                                         print(
//                                             "indexxxxxx.${value.discount_amount[index].text}");
//                                         await OrderAppDB.instance.upadteCommonQuery(
//                                             "salesBagTable",
//                                             "rate=${value.salesrate[index].text},unit_rate=${value.taxable_rate},net_amt=${value.net_amt},discount_per=${value.discount_prercent[index].text},discount_amt=${value.discount_amount[index].text},qty=${value.salesqty[index].text},totalamount=${value.gross},tax_amt=${value.tax},cgst_amt=${value.cgst_amt},sgst_amt=${value.sgst_amt},igst_amt=${value.igst_amt}",
//                                             "code='$code' and customerid='$customerId'");
//                                         print("calculate new total");
//                                         await Provider.of<Controller>(context,
//                                                 listen: false)
//                                             .calculatesalesTotal(
//                                                 os, customerId);
//                                         Provider.of<Controller>(context,
//                                                 listen: false)
//                                             .getSaleBagDetails(customerId, os);

//                                         Navigator.pop(context);
//                                       },
//                                       child: Text("Apply")))
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         });
//   }
// }
