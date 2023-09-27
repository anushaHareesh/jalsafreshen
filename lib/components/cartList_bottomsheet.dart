// import 'package:flutter/material.dart';
// import 'package:orderapp/controller/controller.dart';
// import 'package:provider/provider.dart';

// class CartBottomsheet{
//   cartSheet(BuildContext context,Size size,int index,){

//       showModalBottomSheet<void>(
//                 isScrollControlled: true,
//                 context: context,
//                 builder: (BuildContext context) {
//                   return Consumer<Controller>(
//                     builder: (context, value, child) {
//                       return SingleChildScrollView(
//                         child: Padding(
//                           padding: MediaQuery.of(context).viewInsets,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Container(
//                               child: Wrap(
//                                 children: [
//                                   SizedBox(
//                                     height: size.height * 0.01,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       IconButton(
//                                         icon: Icon(Icons.close),
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       FloatingActionButton.small(
//                                           backgroundColor: Colors.grey,
//                                           child: Icon(Icons.remove),
//                                           onPressed: () {
//                                             if (value.qtyinc! > 1) {
//                                               value.qtyDecrement();
//                                               value.totalCalculation(value
//                                                   .rateController[index].text);
//                                             }
//                                           }),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 15.0, right: 15),
//                                         child: Text(
//                                           value.qtyinc.toString(),
//                                           style: TextStyle(fontSize: 20),
//                                         ),
//                                       ),
//                                       FloatingActionButton.small(
//                                           backgroundColor: Colors.grey,
//                                           child: Icon(Icons.add),
//                                           onPressed: () {
//                                             value.qtyIncrement();
//                                             value.totalCalculation(value
//                                                 .rateController[index].text);
//                                           }),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: size.height * 0.02,
//                                   ),
//                                   Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .settingsList1[0]["set_value"] ==
//                                           "YES"
//                                       ? Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 8.0, bottom: 8),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Rate :",
//                                                 style: TextStyle(fontSize: 17),
//                                               ),
//                                               Container(
//                                                 width: size.width * 0.2,
//                                                 child: TextField(
//                                                   onTap: () {
//                                                     value.rateController[index]
//                                                             .selection =
//                                                         TextSelection(
//                                                             baseOffset: 0,
//                                                             extentOffset: value
//                                                                 .rateController[
//                                                                     index]
//                                                                 .value
//                                                                 .text
//                                                                 .length);
//                                                   },
//                                                   keyboardType:
//                                                       TextInputType.number,
//                                                   onSubmitted: (values) {
//                                                     value.totalCalculation(
//                                                         values);
//                                                   },
//                                                   textAlign: TextAlign.right,
//                                                   controller: value
//                                                       .rateController[index],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         )
//                                       : Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 8.0, bottom: 8),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Rate :",
//                                                 style: TextStyle(fontSize: 17),
//                                               ),
//                                               Flexible(
//                                                 child: Text(
//                                                   "\u{20B9}${rate}",
//                                                   style:
//                                                       TextStyle(fontSize: 17),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                   Divider(
//                                     thickness: 1,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 8.0, bottom: 8),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Total Price :",
//                                           style: TextStyle(
//                                               fontSize: 17,
//                                               color: P_Settings.extracolor),
//                                         ),
//                                         Flexible(
//                                           child: Text(
//                                             "\u{20B9}${value.priceval}",
//                                             style: TextStyle(
//                                                 fontSize: 17,
//                                                 color: P_Settings.extracolor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: size.height * 0.02,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             Provider.of<Controller>(context,
//                                                     listen: false)
//                                                 .updateQty(
//                                                     value.qtyinc.toString(),
//                                                     cartrowno,
//                                                     widget.custmerId,
//                                                     value.rateController[index]
//                                                         .text);
//                                             Provider.of<Controller>(context,
//                                                     listen: false)
//                                                 .calculateorderTotal(widget.os,
//                                                     widget.custmerId);
//                                             // Provider.of<Controller>(context,
//                                             //         listen: false)
//                                             //     .getBagDetails(
//                                             //         widget.custmerId,
//                                             //         widget.os);
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text("continue"))
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//   }
// }






