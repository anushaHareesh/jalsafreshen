// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:orderapp/components/commoncolor.dart';
// import 'package:orderapp/components/customSearchTile.dart';
// import 'package:orderapp/components/customSnackbar.dart';
// import 'package:orderapp/components/showMoadal.dart';
// import 'package:orderapp/controller/controller.dart';
// import 'package:orderapp/db_helper.dart';
// import 'package:badges/badges.dart';
// import 'package:orderapp/screen/ORDER/8_cartList.dart';
// import 'package:orderapp/screen/ORDER/filterProduct.dart';
// import 'package:provider/provider.dart';

// class ItemSelection extends StatefulWidget {
//   // List<Map<String,dynamic>>  products;
//   String customerId;
//   String os;
//   String areaId;
//   String areaName;
//   String type;
//   bool _isLoading = false;

//   ItemSelection(
//       {required this.customerId,
//       required this.areaId,
//       required this.os,
//       required this.areaName,
//       required this.type});

//   @override
//   State<ItemSelection> createState() => _ItemSelectionState();
// }

// class _ItemSelectionState extends State<ItemSelection> {
//   String rate1 = "1";
//   TextEditingController searchcontroll = TextEditingController();
//   ShowModal showModal = ShowModal();
//   List<Map<String, dynamic>> products = [];
//   SearchTile search = SearchTile();
//   DateTime now = DateTime.now();
//   List<String> s = [];
//   String? date;
//   bool loading = true;
//   bool loading1 = false;
//   CustomSnackbar snackbar = CustomSnackbar();
//   bool _isLoading = false;
//   bool isSelected = false;
//   @override
//   void dispose() {
//     super.dispose();
//     searchcontroll.dispose();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print("widget.os===${widget.os}");
//     print("areaId---${widget.customerId}");
//     products = Provider.of<Controller>(context, listen: false).productName;
//     print("products---${products}");
//     Provider.of<Controller>(context, listen: false).newList = products;
//     Provider.of<Controller>(context, listen: false).getOrderno();
//     date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
//     s = date!.split(" ");
//     // Provider.of<Controller>(context, listen: false)
//     //     .getProductList(widget.customerId);
//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: P_Settings.wavecolor,
//         actions: [
//           Badge(
//             animationType: BadgeAnimationType.scale,
//             toAnimate: true,
//             badgeColor: Colors.white,
//             badgeContent: Consumer<Controller>(
//               builder: (context, value, child) {
//                 if (value.count == null) {
//                   return SpinKitChasingDots(
//                       color: P_Settings.wavecolor, size: 9);
//                 } else {
//                   return Text(
//                     "${value.count}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//                   );
//                 }
//               },
//             ),
//             position: BadgePosition(start: 33, bottom: 25),
//             child: IconButton(
//               onPressed: () async {
//                 // String oos = "O" + "${widget.os}";

//                 if (widget.customerId == null || widget.customerId.isEmpty) {
//                 } else {
//                   FocusManager.instance.primaryFocus?.unfocus();

//                   Provider.of<Controller>(context, listen: false)
//                       .selectSettings(
//                           "set_code in('SO_RATE_EDIT','SO_UPLOAD_DIRECT')");
//                   Provider.of<Controller>(context, listen: false)
//                       .getBagDetails(widget.customerId, widget.os);

//                   // await OrderAppDB.instance.selectAllcommon(
//                   //     'settingsTable', "set_code='SO_RATE_EDIT'");

//                   Navigator.of(context).push(
//                     PageRouteBuilder(
//                       opaque: false, // set to false
//                       pageBuilder: (_, __, ___) => CartList(
//                         areaId: widget.areaId,
//                         custmerId: widget.customerId,
//                         os: widget.os,
//                         areaname: widget.areaName,
//                         type: widget.type,
//                       ),
//                     ),
//                   );
//                 }
//               },
//               icon: const Icon(Icons.shopping_cart),
//             ),
//           ),
//           const SizedBox(
//             width: 3.0,
//           ),
//           Consumer<Controller>(
//             builder: (context, _value, child) {
//               return PopupMenuButton<String>(
//                 onSelected: (value) {
//                   Provider.of<Controller>(context, listen: false)
//                       .filteredeValue = value;

//                   if (value == "0") {
//                     setState(() {
//                       Provider.of<Controller>(context, listen: false)
//                           .filterCompany = false;
//                     });

//                     Provider.of<Controller>(context, listen: false)
//                         .filteredProductList
//                         .clear();
//                     Provider.of<Controller>(context, listen: false)
//                         .getProductList(widget.customerId);
//                   } else {
//                     print("value---$value");
//                     Provider.of<Controller>(context, listen: false)
//                         .filterCompany = true;
//                     Provider.of<Controller>(context, listen: false)
//                         .filterwithCompany(
//                             widget.customerId, value, "sale order");
//                   }
//                 },
//                 itemBuilder: (context) => _value.productcompanyList
//                     .map((item) => PopupMenuItem<String>(
//                           value: item["comid"],
//                           child: Text(
//                             item["comanme"],
//                           ),
//                         ))
//                     .toList(),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Consumer<Controller>(
//         builder: (context, value, child) {
//           // Provider.of<Controller>(context, listen: false)
//           //     .getProductList(widget.customerId);
//           print("value.returnirtemExists------${value.returnirtemExists}");
//           return Column(
//             children: [
//               // GestureDetector(
//               //   onTap: () {
//               //     String oos = "O" + "${widget.os}";
//               //     String ros = "R" + "${widget.os}";
//               //     if (widget.type == "sale order") {
//               //       Provider.of<Controller>(context, listen: false)
//               //           .getBagDetails(widget.customerId, oos);
//               //       Navigator.of(context).push(
//               //         PageRouteBuilder(
//               //           opaque: false, // set to false
//               //           pageBuilder: (_, __, ___) => CartList(
//               //             areaId: widget.areaId,
//               //             custmerId: widget.customerId,
//               //             os: oos,
//               //             areaname: widget.areaName,
//               //             type: widget.type,
//               //           ),
//               //         ),
//               //       );
//               //     } else if (widget.type == "return") {
//               //       Navigator.of(context).push(
//               //         PageRouteBuilder(
//               //           opaque: false, // set to false
//               //           pageBuilder: (_, __, ___) => ReturnCart(
//               //             areaId: widget.areaId,
//               //             custmerId: widget.customerId,
//               //             os: widget.os,
//               //             areaname: widget.areaName,
//               //             type: widget.type,
//               //           ),
//               //         ),
//               //       );
//               //     }
//               //   },
//               //   child: Container(
//               //       alignment: Alignment.center,
//               //       height: size.height * 0.045,
//               //       width: size.width * 0.2,
//               //       child: value.isLoading
//               //           ? Center(
//               //               child: SpinKitThreeBounce(
//               //               color: widget.type == "sale order"
//               //                   ? P_Settings.wavecolor
//               //                   : P_Settings.returnbuttnColor,
//               //               size: 15,
//               //             ))
//               //           : Text(
//               //               widget.type == "sale order"
//               //                   ? "${value.count}"
//               //                   : "${value.returnCount}",
//               //               style: TextStyle(
//               //                   fontSize: 19, fontWeight: FontWeight.bold),
//               //             ),
//               //       decoration: BoxDecoration(
//               //         color: widget.type == "sale order"
//               //             ? P_Settings.roundedButtonColor
//               //             : P_Settings.returncountColor,
//               //         borderRadius: BorderRadius.only(
//               //           bottomLeft: Radius.circular(50),
//               //           bottomRight: Radius.circular(50),
//               //         ),
//               //       )),
//               // ),
//               SizedBox(
//                 height: size.height * 0.01,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Container(
//                   width: size.width * 0.95,
//                   height: size.height * 0.09,
//                   child: TextField(
//                     controller: searchcontroll,
//                     onChanged: (value) {
//                       Provider.of<Controller>(context, listen: false)
//                           .setisVisible(true);
//                       value = searchcontroll.text;
//                     },
//                     decoration: InputDecoration(
//                       hintText: "Search with  Product code/Name/category",
//                       hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
//                       suffixIcon: value.isVisible
//                           ? Wrap(
//                               children: [
//                                 IconButton(
//                                     icon: Icon(
//                                       Icons.done,
//                                       size: 20,
//                                     ),
//                                     onPressed: () async {
//                                       // String oos="O"+"${widget.os}";
//                                       Provider.of<Controller>(context,
//                                               listen: false)
//                                           .searchkey = searchcontroll.text;
//                                       Provider.of<Controller>(context,
//                                               listen: false)
//                                           .setIssearch(true);
//                                       Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .filterCompany
//                                           ? Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .searchProcess1(
//                                                   widget.customerId,
//                                                   widget.os,
//                                                   Provider.of<Controller>(
//                                                           context,
//                                                           listen: false)
//                                                       .filteredeValue!,
//                                                   "sale order",
//                                                   value.productName)
//                                           : Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .searchProcess1(
//                                                   widget.customerId,
//                                                   widget.os,
//                                                   "",
//                                                   "sale order",
//                                                   value.productName);
//                                     }),
//                                 IconButton(
//                                     icon: Icon(
//                                       Icons.close,
//                                       size: 20,
//                                     ),
//                                     onPressed: () {
//                                       Provider.of<Controller>(context,
//                                               listen: false)
//                                           .getProductList(widget.customerId);

//                                       Provider.of<Controller>(context,
//                                               listen: false)
//                                           .setIssearch(false);

//                                       value.setisVisible(false);
//                                       Provider.of<Controller>(context,
//                                               listen: false)
//                                           .newList
//                                           .clear();
//                                        searchcontroll.clear();
//                                       print(
//                                           "rtsyt----${Provider.of<Controller>(context, listen: false).returnirtemExists}");
//                                     }),
//                               ],
//                             )
//                           : Icon(
//                               Icons.search,
//                               size: 20,
//                             ),
//                     ),
//                   ),
//                 ),
//               ),
//               value.isLoading
//                   ? Container(
//                       child: CircularProgressIndicator(
//                           color: widget.type == "sale order"
//                               ? P_Settings.wavecolor
//                               : P_Settings.returnbuttnColor))
//                   : value.prodctItems.length == 0
//                       ? _isLoading
//                           ? CircularProgressIndicator()
//                           : Container(
//                               height: size.height * 0.6,
//                               child: Text(
//                                 "No Products !!!",
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                             )
//                       : Expanded(
//                           child: value.isSearch
//                               ? value.isListLoading
//                                   ? Center(
//                                       child: SpinKitCircle(
//                                         color: widget.type == "sale order"
//                                             ? P_Settings.wavecolor
//                                             : P_Settings.returnbuttnColor,
//                                         size: 40,
//                                       ),
//                                     )
//                                   : value.newList.length == 0
//                                       ? Container(
//                                           child: Text("No data Found!!!!"),
//                                         )
//                                       : ListView.builder(
//                                           itemExtent: 70,
//                                           shrinkWrap: true,
//                                           itemCount: value.newList.length,
//                                           itemBuilder:
//                                               (BuildContext context, index) {
//                                             return Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 0.4, right: 0.4),
//                                               child: Card(
//                                                 child: ListTile(
//                                                   title: Text(
//                                                     '${value.newList[index]["code"]}' +
//                                                         '-' +
//                                                         '${value.newList[index]["item"]}',
//                                                     style: TextStyle(
//                                                         color: value.newList[
//                                                                         index][
//                                                                     "cartrowno"] ==
//                                                                 null
//                                                             ? value.selected[
//                                                                     index]
//                                                                 ? Colors.green
//                                                                 : Colors
//                                                                     .grey[700]
//                                                             : Colors.green,
//                                                         fontSize: 14),
//                                                   ),
//                                                   subtitle: Text(
//                                                     '\u{20B9}${value.newList[index]["rate1"]}',
//                                                     style: TextStyle(
//                                                       color:
//                                                           P_Settings.ratecolor,
//                                                       fontStyle:
//                                                           FontStyle.italic,
//                                                     ),
//                                                   ),
//                                                   trailing: Row(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: [
//                                                       Container(
//                                                           width:
//                                                               size.width * 0.06,
//                                                           child: TextFormField(
//                                                             controller: value
//                                                                 .qty[index],
//                                                             keyboardType:
//                                                                 TextInputType
//                                                                     .number,
//                                                             decoration:
//                                                                 InputDecoration(
//                                                                     border:
//                                                                         InputBorder
//                                                                             .none,
//                                                                     hintText:
//                                                                         "1"),
//                                                           )),
//                                                       SizedBox(
//                                                         width: 10,
//                                                       ),
//                                                       IconButton(
//                                                         icon: Icon(
//                                                           Icons.add,
//                                                         ),
//                                                         onPressed: () async {
//                                                           Provider.of<Controller>(
//                                                                   context,
//                                                                   listen: false)
//                                                               .selectSettings(
//                                                                   "set_code in('SO_RATE_EDIT','SO_UPLOAD_DIRECT')");
//                                                           String oos = "O" +
//                                                               "${value.ordernum[0]["os"]}";

//                                                           setState(() {
//                                                             if (value.selected[
//                                                                     index] ==
//                                                                 false) {
//                                                               value.selected[
//                                                                   index] = !value
//                                                                       .selected[
//                                                                   index];
//                                                               // selected = index;
//                                                             }

//                                                             if (value.qty[index]
//                                                                         .text ==
//                                                                     null ||
//                                                                 value
//                                                                     .qty[index]
//                                                                     .text
//                                                                     .isEmpty) {
//                                                               value.qty[index]
//                                                                   .text = "1";
//                                                             }
//                                                           });
//                                                           print(
//                                                               "quantity noyyyyyyyyyyyy......${value.qty[index].text}");
//                                                           if (widget.type ==
//                                                               "sale order") {
//                                                             int max = await OrderAppDB
//                                                                 .instance
//                                                                 .getMaxCommonQuery(
//                                                                     'orderBagTable',
//                                                                     'cartrowno',
//                                                                     "os='${oos}' AND customerid='${widget.customerId}'");

//                                                             print(
//                                                                 "max----$max");
//                                                             // print("value.qty[index].text---${value.qty[index].text}");

//                                                             rate1 = value
//                                                                     .newList[
//                                                                 index]["rate1"];
//                                                             var total = double
//                                                                     .parse(
//                                                                         rate1) *
//                                                                 double.parse(value
//                                                                     .qty[index]
//                                                                     .text);
//                                                             print(
//                                                                 "total rate $total");
//                                                             var res = await OrderAppDB
//                                                                 .instance
//                                                                 .insertorderBagTable(
//                                                                     products[index]
//                                                                         [
//                                                                         "item"],
//                                                                     s[0],
//                                                                     s[1],
//                                                                     oos,
//                                                                     widget
//                                                                         .customerId,
//                                                                     max,
//                                                                     products[
//                                                                             index]
//                                                                         [
//                                                                         "code"],
//                                                                     double.parse(value
//                                                                         .qty[
//                                                                             index]
//                                                                         .text),
//                                                                     rate1,
//                                                                     total
//                                                                         .toString(),
//                                                                     0,
//                                                                     "",
//                                                                     0.0,
//                                                                     0.0,
//                                                                     0);

//                                                             snackbar.showSnackbar(
//                                                                 context,
//                                                                 "${products[index]["code"] + "-" + (products[index]['item'])} - Added to cart",
//                                                                 "sale order");
//                                                             Provider.of<Controller>(
//                                                                     context,
//                                                                     listen:
//                                                                         false)
//                                                                 .countFromTable(
//                                                               "orderBagTable",
//                                                               oos,
//                                                               widget.customerId,
//                                                             );
//                                                           }

//                                                           /////////////////////////
//                                                           (widget.customerId.isNotEmpty ||
//                                                                       widget.customerId !=
//                                                                           null) &&
//                                                                   (products[index][
//                                                                               "code"]
//                                                                           .isNotEmpty ||
//                                                                       products[index]
//                                                                               [
//                                                                               "code"] !=
//                                                                           null)
//                                                               ? Provider.of<
//                                                                           Controller>(
//                                                                       context,
//                                                                       listen:
//                                                                           false)
//                                                                   .calculateorderTotal(
//                                                                       oos,
//                                                                       widget
//                                                                           .customerId)
//                                                               : Text("No data");
//                                                         },
//                                                         color: Colors.black,
//                                                       ),
//                                                       IconButton(
//                                                           icon: Icon(
//                                                             Icons.delete,
//                                                             size: 18,
//                                                             // color: Colors.redAccent,
//                                                           ),
//                                                           onPressed: value.newList[
//                                                                           index]
//                                                                       [
//                                                                       "cartrowno"] ==
//                                                                   null
//                                                               ? value.selected[
//                                                                       index]
//                                                                   ? () async {
//                                                                       String
//                                                                           oos =
//                                                                           "O" +
//                                                                               "${widget.os}";
//                                                                       String
//                                                                           ros =
//                                                                           "R" +
//                                                                               "${widget.os}";
//                                                                       String
//                                                                           item =
//                                                                           products[index]["code"] +
//                                                                               products[index]["item"];
//                                                                       showModal.showMoadlBottomsheet(
//                                                                           oos,
//                                                                           widget
//                                                                               .customerId,
//                                                                           item,
//                                                                           size,
//                                                                           context,
//                                                                           "just added",
//                                                                           products[index]
//                                                                               [
//                                                                               "code"],
//                                                                           index,
//                                                                           "no filter",
//                                                                           "",
//                                                                           value.qty[
//                                                                               index],
//                                                                           "sale order");
//                                                                     }
//                                                                   : null
//                                                               : () async {
//                                                                   String oos = "O" +
//                                                                       "${widget.os}";
//                                                                   String item = products[
//                                                                               index]
//                                                                           [
//                                                                           "code"] +
//                                                                       products[
//                                                                               index]
//                                                                           [
//                                                                           "item"];
//                                                                   showModal.showMoadlBottomsheet(
//                                                                       oos,
//                                                                       widget
//                                                                           .customerId,
//                                                                       item,
//                                                                       size,
//                                                                       context,
//                                                                       "already in cart",
//                                                                       products[
//                                                                               index]
//                                                                           [
//                                                                           "code"],
//                                                                       index,
//                                                                       "no filter",
//                                                                       "",
//                                                                       value.qty[
//                                                                           index],
//                                                                       "sale order");
//                                                                 })
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         )
//                               : value.filterCompany
//                                   ? FilteredProduct(
//                                       type: widget.type,
//                                       customerId: widget.customerId,
//                                       os: widget.os,
//                                       s: s,
//                                       value: Provider.of<Controller>(context,
//                                               listen: false)
//                                           .filteredeValue)
//                                   : value.isLoading
//                                       ? CircularProgressIndicator()
//                                       : ListView.builder(
//                                           itemExtent: 70,
//                                           shrinkWrap: true,
//                                           itemCount: value.productName.length,
//                                           itemBuilder:
//                                               (BuildContext context, index) {
//                                             return Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 0.4, right: 0.4),
//                                               child: Card(
//                                                 child: ListTile(
//                                                   title: Text(
//                                                     '${value.productName[index]["code"]}' +
//                                                         '-' +
//                                                         '${value.productName[index]["item"]}',
//                                                     style: TextStyle(
//                                                         color: value.productName[
//                                                                         index][
//                                                                     "cartrowno"] ==
//                                                                 null
//                                                             ? value.selected[
//                                                                     index]
//                                                                 ? Colors.green
//                                                                 : Colors
//                                                                     .grey[700]
//                                                             : Colors.green,
//                                                         fontSize: 14),
//                                                   ),
//                                                   subtitle: Text(
//                                                     '\u{20B9}${value.productName[index]["rate1"]}',
//                                                     style: TextStyle(
//                                                       color:
//                                                           P_Settings.ratecolor,
//                                                       fontStyle:
//                                                           FontStyle.italic,
//                                                     ),
//                                                   ),
//                                                   trailing: Row(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     children: [
//                                                       Container(
//                                                           width:
//                                                               size.width * 0.06,
//                                                           child: TextFormField(
//                                                             controller: value
//                                                                 .qty[index],
//                                                             keyboardType:
//                                                                 TextInputType
//                                                                     .number,
//                                                             decoration:
//                                                                 InputDecoration(
//                                                                     border:
//                                                                         InputBorder
//                                                                             .none,
//                                                                     hintText:
//                                                                         "1"),
//                                                           )),
//                                                       SizedBox(
//                                                         width: 10,
//                                                       ),
//                                                       IconButton(
//                                                         icon: Icon(
//                                                           Icons.add,
//                                                         ),
//                                                         onPressed: () async {
//                                                           Provider.of<Controller>(
//                                                                   context,
//                                                                   listen: false)
//                                                               .selectSettings(
//                                                                   "set_code in('SO_RATE_EDIT','SO_UPLOAD_DIRECT')");
//                                                           String oos = "O" +
//                                                               "${value.ordernum[0]["os"]}";

//                                                           setState(() {
//                                                             if (value.selected[
//                                                                     index] ==
//                                                                 false) {
//                                                               value.selected[
//                                                                   index] = !value
//                                                                       .selected[
//                                                                   index];
//                                                               // selected = index;
//                                                             }

//                                                             if (value.qty[index]
//                                                                         .text ==
//                                                                     null ||
//                                                                 value
//                                                                     .qty[index]
//                                                                     .text
//                                                                     .isEmpty) {
//                                                               value.qty[index]
//                                                                   .text = "1";
//                                                             }
//                                                           });
//                                                           print(
//                                                               "quantity noyyyyyyyyyyyy......${value.qty[index].text}");
//                                                           if (widget.type ==
//                                                               "sale order") {
//                                                             int max = await OrderAppDB
//                                                                 .instance
//                                                                 .getMaxCommonQuery(
//                                                                     'orderBagTable',
//                                                                     'cartrowno',
//                                                                     "os='${oos}' AND customerid='${widget.customerId}'");

//                                                             print(
//                                                                 "max----$max");
//                                                             // print("value.qty[index].text---${value.qty[index].text}");

//                                                             rate1 = value
//                                                                     .productName[
//                                                                 index]["rate1"];
//                                                             var total = double
//                                                                     .parse(
//                                                                         rate1) *
//                                                                 double.parse(value
//                                                                     .qty[index]
//                                                                     .text);
//                                                             print(
//                                                                 "total rate $total");
//                                                             var res = await OrderAppDB
//                                                                 .instance
//                                                                 .insertorderBagTable(
//                                                                     products[index]
//                                                                         [
//                                                                         "item"],
//                                                                     s[0],
//                                                                     s[1],
//                                                                     oos,
//                                                                     widget
//                                                                         .customerId,
//                                                                     max,
//                                                                     products[
//                                                                             index]
//                                                                         [
//                                                                         "code"],
//                                                                     double.parse(value
//                                                                         .qty[
//                                                                             index]
//                                                                         .text),
//                                                                     rate1,
//                                                                     total
//                                                                         .toString(),
//                                                                     0,
//                                                                     "",
//                                                                     0.0,
//                                                                     0.0,
//                                                                     0);

//                                                             snackbar.showSnackbar(
//                                                                 context,
//                                                                 "${products[index]["code"] + "-" + (products[index]['item'])} - Added to cart",
//                                                                 "sale order");
//                                                             Provider.of<Controller>(
//                                                                     context,
//                                                                     listen:
//                                                                         false)
//                                                                 .countFromTable(
//                                                               "orderBagTable",
//                                                               oos,
//                                                               widget.customerId,
//                                                             );
//                                                           }

//                                                           /////////////////////////
//                                                           (widget.customerId.isNotEmpty ||
//                                                                       widget.customerId !=
//                                                                           null) &&
//                                                                   (products[index][
//                                                                               "code"]
//                                                                           .isNotEmpty ||
//                                                                       products[index]
//                                                                               [
//                                                                               "code"] !=
//                                                                           null)
//                                                               ? Provider.of<
//                                                                           Controller>(
//                                                                       context,
//                                                                       listen:
//                                                                           false)
//                                                                   .calculateorderTotal(
//                                                                       oos,
//                                                                       widget
//                                                                           .customerId)
//                                                               : Text("No data");
//                                                         },
//                                                         color: Colors.black,
//                                                       ),
//                                                       IconButton(
//                                                           icon: Icon(
//                                                             Icons.delete,
//                                                             size: 18,
//                                                             // color: Colors.redAccent,
//                                                           ),
//                                                           onPressed: value.productName[
//                                                                           index]
//                                                                       [
//                                                                       "cartrowno"] ==
//                                                                   null
//                                                               ? value.selected[
//                                                                       index]
//                                                                   ? () async {
//                                                                       String
//                                                                           oos =
//                                                                           "O" +
//                                                                               "${widget.os}";
//                                                                       String
//                                                                           ros =
//                                                                           "R" +
//                                                                               "${widget.os}";
//                                                                       String
//                                                                           item =
//                                                                           products[index]["code"] +
//                                                                               products[index]["item"];
//                                                                       showModal.showMoadlBottomsheet(
//                                                                           oos,
//                                                                           widget
//                                                                               .customerId,
//                                                                           item,
//                                                                           size,
//                                                                           context,
//                                                                           "just added",
//                                                                           products[index]
//                                                                               [
//                                                                               "code"],
//                                                                           index,
//                                                                           "no filter",
//                                                                           "",
//                                                                           value.qty[
//                                                                               index],
//                                                                           "sale order");
//                                                                     }
//                                                                   : null
//                                                               : () async {
//                                                                   String oos = "O" +
//                                                                       "${widget.os}";
//                                                                   String item = products[
//                                                                               index]
//                                                                           [
//                                                                           "code"] +
//                                                                       products[
//                                                                               index]
//                                                                           [
//                                                                           "item"];
//                                                                   showModal.showMoadlBottomsheet(
//                                                                       oos,
//                                                                       widget
//                                                                           .customerId,
//                                                                       item,
//                                                                       size,
//                                                                       context,
//                                                                       "already in cart",
//                                                                       products[
//                                                                               index]
//                                                                           [
//                                                                           "code"],
//                                                                       index,
//                                                                       "no filter",
//                                                                       "",
//                                                                       value.qty[
//                                                                           index],
//                                                                       "sale order");
//                                                                 })
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         )),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   //////////////////////////////////////////////////////////////////////////////////
// }
