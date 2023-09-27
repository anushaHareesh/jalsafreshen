// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:orderapp/components/commoncolor.dart';
// import 'package:orderapp/screen/6_reportPage.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../controller/controller.dart';

// enum WidgetMarker {
//   area,
//   date,
//   orderAmount,
//   balanceAmount,
//   collectionAmount,
//   remark
// }

// class FilterReport extends StatefulWidget {
//   const FilterReport({Key? key}) : super(key: key);

//   @override
//   State<FilterReport> createState() => _FilterReportState();
// }

// class _FilterReportState extends State<FilterReport> {
//   String? sid;
//   RangeValues _currentRangeValues = const RangeValues(20, 10000);
//   RangeValues _currentRangeValuesbal = const RangeValues(20, 10000);
//   WidgetMarker selectedWidgetMarker = WidgetMarker.date;
//   List<bool>? _isChecked;
//   List<bool>? _isCheckedremark;
//   List<bool>? _isCheckedarea;
//   DateTime selectedDate = DateTime.now();
//   DateTime currentDate = DateTime.now();
//   String? fromDate;
//   String? toDate;
//   String? formattedDate;
//   String? crntDateFormat;
//   List<String> remark = ["Remarked", "Not Remarked"];
//   List orderAmount = [
//     "1-500",
//     "501-1000",
//     "1001-1500",
//     "1501-2000",
//     "2001-2500",
//     "2501-3000",
//     "Above 3000",
//   ];
//   List dateSelect = [
//     "Today",
//     "Last 7 Days",
//     "This Month",
//     "Between date",
//   ];

//   @override
//   void initState() {
//     print("helooo");
//     crntDateFormat = DateFormat('dd-MM-yyyy').format(currentDate);
//     _isCheckedremark = List<bool>.filled(remark.length, false);
//     _isChecked = List<bool>.filled(orderAmount.length, false);

//     // TODO: implement initState
//     super.initState();
//     sharedPref();
//   }

//   sharedPref() async {
//     print("helooo");
//     final prefs = await SharedPreferences.getInstance();
//     sid = prefs.getString('sid');
//     print("sid ......$sid");
//     Provider.of<Controller>(context, listen: false).getArea(sid!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     bool isChecked = false;
//     /////////////// date filter //////////////
//     Widget dateFilter() {
//       return Column(
//         children: [
//           Text(
//             "Select Date",
//             style: TextStyle(color: P_Settings.wavecolor, fontSize: 16),
//           ),
//           Divider(),
//           Expanded(
//               child: Column(
//             children: [
//               Row(
//                 children: [
//                   Text("From Date :"),
//                   IconButton(
//                       onPressed: () {
//                         _selectFromDate(context, size);
//                         print("From date ${crntDateFormat.toString()}");
//                       },
//                       icon: Icon(Icons.calendar_month)),
//                   fromDate == null
//                       ? InkWell(
//                           onTap: (() {
//                             _selectFromDate(context, size);
//                           }),
//                           child: Text(crntDateFormat.toString()))
//                       : InkWell(
//                           onTap: () {
//                             _selectFromDate(context, size);
//                           },
//                           child: Text(fromDate.toString())),
//                 ],
//               ),

//               ////////////////////////////////////////////////////////
//               Row(
//                 children: [
//                   Text("To Date :"),
//                   IconButton(
//                       onPressed: () {
//                         _selectToDate(context, size);
//                         print("From date ${crntDateFormat.toString()}");
//                       },
//                       icon: Icon(Icons.calendar_month)),
//                   toDate == null
//                       ? InkWell(
//                           onTap: () {
//                             _selectToDate(context, size);
//                           },
//                           child: Text(crntDateFormat.toString()))
//                       : InkWell(
//                           onTap: () {
//                             _selectToDate(context, size);
//                           },
//                           child: Text(toDate.toString()))
//                 ],
//               ),
//             ],
//           )),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Color.fromARGB(255, 127, 192, 223),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//             onPressed: () {
//               Provider.of<Controller>(context, listen: false).setFilter(true);
//               Provider.of<Controller>(context, listen: false).filterReports(
//                 "balance",
//                 _currentRangeValues.start.round().toDouble(),
//                 _currentRangeValues.end.round().toDouble(),
//               );
//               Navigator.pop(context);
//             },
//             child: Text("Ok"),
//           )
//         ],
//       );
//     }

//     ////////////////// area filter /////////////////////
//     Widget areaFilter() {
//       return Container(
//         height: size.height * 0.9,
//         child: Column(
//           children: [
//             Text(
//               "Select Area ",
//               style: TextStyle(color: P_Settings.wavecolor, fontSize: 16),
//             ),
//             Divider(),
//             Expanded(
//               child: Consumer<Controller>(
//                 builder: (context, value, child) {
//                   // Provider.of<Controller>(context, listen: false).getArea(sid!);
//                   return ListView.builder(
//                     itemCount: value.areaList.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(
//                           value.areaList[index]['aname'],
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         trailing: Checkbox(
//                           checkColor: Colors.white,
//                           // fillColor: MaterialStateProperty.resolveWith(getColor),
//                           value: isChecked,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               _isCheckedarea![index] = value!;
//                               print("area click $value");
//                               // Provider.of<Controller>(context, listen: false).setAreaFilter(value);
//                             });
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Color.fromARGB(255, 127, 192, 223),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//               onPressed: () {
//                 Provider.of<Controller>(context, listen: false).setFilter(true);
//                 Provider.of<Controller>(context, listen: false).filterReports(
//                   "balance",
//                   _currentRangeValues.start.round().toDouble(),
//                   _currentRangeValues.end.round().toDouble(),
//                 );
//                 Navigator.pop(context);
//               },
//               child: Text("Ok"),
//             )
//           ],
//         ),
//       );
//     }

//     //////////////////////// Order Amount //////////////////////

//     Widget orderAmountFilter() {
//       return Column(
//         children: [
//           Text(
//             "Select Order Amount",
//             style: TextStyle(color: P_Settings.wavecolor, fontSize: 16),
//           ),
//           Divider(),
//           SizedBox(
//             height: size.height * 0.04,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Row(
//               children: [
//                 Text(
//                   _currentRangeValuesbal.start.round().toString(),
//                 ),
//                 Spacer(),
//                 Text(
//                   _currentRangeValuesbal.end.round().toString(),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: size.height * 0.04,
//           ),
//           RangeSlider(
//             values: _currentRangeValues,
//             min: 0,
//             max: 16000,
//             divisions: 10,
//             labels: RangeLabels(
//               _currentRangeValues.start.round().toString(),
//               _currentRangeValues.end.round().toString(),
//             ),
//             // onChangeStart: (RangeValues values) =>
//             //     _currentRangeValues.start.round().toString(),
//             // onChangeEnd: (RangeValues values) =>
//             //     _currentRangeValues.end.round().toString(),
//             onChanged: (RangeValues values) {
//               setState(() {
//                 _currentRangeValues = values;
//                 print("_currentRangeValues$_currentRangeValues");
//               });
//             },
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Color.fromARGB(255, 127, 192, 223),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//             onPressed: () {
//               Provider.of<Controller>(context, listen: false).setFilter(true);
//               Provider.of<Controller>(context, listen: false).filterReports(
//                 "order amount",
//                 _currentRangeValues.start.round().toDouble(),
//                 _currentRangeValues.end.round().toDouble(),
//               );
//               Navigator.pop(context);
//             },
//             child: Text("Ok"),
//           )
//         ],
//       );
//     }

//     ///////////////// balance amount ///////////////
//     ///////////////// balance amount ///////////////
//     Widget balanceAmountFilter() {
//       return Column(
//         children: [
//           Text("Select balance Amount"),
//           SizedBox(
//             height: size.height * 0.04,
//           ),
//           RangeSlider(
//             values: _currentRangeValues,
//             min: 0,
//             max: 16000,
//             divisions: 10,
//             labels: RangeLabels(
//               _currentRangeValues.start.round().toString(),
//               _currentRangeValues.end.round().toString(),
//             ),
//             // onChangeStart: (RangeValues values) =>
//             //     _currentRangeValues.start.round().toString(),
//             // onChangeEnd: (RangeValues values) =>
//             //     _currentRangeValues.end.round().toString(),
//             onChanged: (RangeValues values) {
//               setState(() {
//                 _currentRangeValues = values;
//                 print("_currentRangeValues$_currentRangeValues");
//               });
//             },
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Color.fromARGB(255, 127, 192, 223),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//             onPressed: () {
//               Provider.of<Controller>(context, listen: false).setFilter(true);
//               Provider.of<Controller>(context, listen: false).filterReports(
//                 "balance",
//                 _currentRangeValues.start.round().toDouble(),
//                 _currentRangeValues.end.round().toDouble(),
//               );
//               Navigator.pop(context);
//             },
//             child: Text("Ok"),
//           )
//         ],
//       );
//     }

//     ////////////////// collection amount filter ///////////////////
//     Widget collectionAmountFilter() {
//       return Column(
//         children: [
//           Text(
//             "Collection Amount",
//             style: TextStyle(color: P_Settings.wavecolor, fontSize: 16),
//           ),
//           Divider(),
//           SizedBox(
//             height: size.height * 0.03,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Row(
//               children: [
//                 Text(
//                   _currentRangeValuesbal.start.round().toString(),
//                 ),
//                 Spacer(),
//                 Text(
//                   _currentRangeValuesbal.end.round().toString(),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: size.height * 0.04,
//           ),
//           RangeSlider(
//             values: _currentRangeValues,
//             min: 0,
//             max: 16000,
//             divisions: 10,
//             labels: RangeLabels(
//               _currentRangeValues.start.round().toString(),
//               _currentRangeValues.end.round().toString(),
//             ),
//             // onChangeStart: (RangeValues values) =>
//             //     _currentRangeValues.start.round().toString(),
//             // onChangeEnd: (RangeValues values) =>
//             //     _currentRangeValues.end.round().toString(),
//             onChanged: (RangeValues values) {
//               setState(() {
//                 _currentRangeValues = values;
//                 print("_currentRangeValues$_currentRangeValues");
//               });
//             },
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Color.fromARGB(255, 127, 192, 223),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//             onPressed: () {
//               Provider.of<Controller>(context, listen: false).setFilter(true);
//               Provider.of<Controller>(context, listen: false).filterReports(
//                 "collection",
//                 _currentRangeValues.start.round().toDouble(),
//                 _currentRangeValues.end.round().toDouble(),
//               );
//               Navigator.pop(context);
//             },
//             child: Text("Ok"),
//           )
//         ],
//       );
//     }

//     //////////////////////Remarks ////////////////////////
//     Widget remarkFilter() {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             height: size.height * 0.6,
//             child: ListView.builder(
//               itemCount: remark.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                   title: Text(remark[index]),
//                   value: _isCheckedremark![index],
//                   onChanged: (val) {
//                     setState(
//                       () {
//                         _isCheckedremark![index] = val!;
//                         print("Remark click $val");
//                         print("Remark index value ${remark[index]}");
//                         String remarks = remark[index];
//                         // Provider.of<Controller>(context, listen: false)
//                         //     .setRemarkFilter(val, remarks);
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Color.fromARGB(255, 127, 192, 223),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//             onPressed: () {
//               Provider.of<Controller>(context, listen: false).setFilter(true);
//               Provider.of<Controller>(context, listen: false).filterReports(
//                 "balance",
//                 _currentRangeValues.start.round().toDouble(),
//                 _currentRangeValues.end.round().toDouble(),
//               );
//               Navigator.pop(context);
//             },
//             child: Text("Ok"),
//           )
//         ],
//       );
//     }

//     Widget getCustomContainer() {
//       print("inside switch case");
//       switch (selectedWidgetMarker) {
//         case WidgetMarker.area:
//           print("area");

//           return areaFilter();
//         case WidgetMarker.date:
//           print("date");
//           return dateFilter();
//         case WidgetMarker.orderAmount:
//           print("order");

//           return orderAmountFilter();
//         case WidgetMarker.balanceAmount:
//           return balanceAmountFilter();
//         case WidgetMarker.collectionAmount:
//           return collectionAmountFilter();
//         case WidgetMarker.remark:
//           return remarkFilter();
//       }
//     }

//     ///////////////////////////////////////
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         height: size.height * 0.9,
//         child: Consumer<Controller>(
//           builder: (context, value, child) {
//             return Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8, left: 2, right: 4),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "FILTER",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       Divider(
//                         thickness: 2,
//                       ),
//                       Flexible(
//                         flex: 5,
//                         child: Container(
//                           color: P_Settings.collection,
//                           height: size.height * 9,
//                           width: size.width * 0.4,
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: size.height * 0.03,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedWidgetMarker = WidgetMarker.date;
//                                   });
//                                 },
//                                 child: Container(
//                                   width: size.width * 0.4,
//                                   height: size.height * 0.03,
//                                   child: Text("Date"),
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedWidgetMarker = WidgetMarker.area;
//                                     print(
//                                         "selectedWidgetMarker $selectedWidgetMarker");
//                                   });
//                                 },
//                                 child: Container(
//                                   width: size.width * 0.4,
//                                   height: size.height * 0.035,
//                                   child: Text("Area"),
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedWidgetMarker =
//                                         WidgetMarker.orderAmount;
//                                   });
//                                 },
//                                 child: Container(
//                                   width: size.width * 0.4,
//                                   height: size.height * 0.035,
//                                   child: Text("Order Amount"),
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedWidgetMarker =
//                                         WidgetMarker.balanceAmount;
//                                   });
//                                 },
//                                 child: Container(
//                                   width: size.width * 0.4,
//                                   height: size.height * 0.035,
//                                   child: Text("Balance Amount"),
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedWidgetMarker =
//                                         WidgetMarker.collectionAmount;
//                                   });
//                                 },
//                                 child: Container(
//                                   width: size.width * 0.4,
//                                   height: size.height * 0.035,
//                                   child: Text("Collection Amount"),
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     selectedWidgetMarker = WidgetMarker.remark;
//                                   });
//                                 },
//                                 child: Container(
//                                   width: size.width * 0.4,
//                                   height: size.height * 0.035,
//                                   child: Text("Remark"),
//                                 ),
//                               ),
//                               Divider(
//                                 thickness: 1,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   thickness: 2,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 50),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         flex: 5,
//                         child: Container(
//                           height: size.height * 7,
//                           width: size.width * 0.55,
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 getCustomContainer();
//                               });
//                             },
//                             child: getCustomContainer(),
//                           ),
//                         ),
//                       ),
//                       // Container(
//                       //   height: size.height * 0.05,
//                       //   width: size.width * 0.55,
//                       //   // color: Colors.yellow,
//                       //   child: ElevatedButton(
//                       //     style: ElevatedButton.styleFrom(
//                       //       primary: P_Settings.wavecolor,
//                       //       shape: RoundedRectangleBorder(
//                       //         borderRadius: BorderRadius.circular(10.0),
//                       //       ),
//                       //     ),
//                       //     onPressed: () {
//                       //       Navigator.pop(context);
//                       //       // Navigator.push(
//                       //       //   context,
//                       //       //   MaterialPageRoute(
//                       //       //       builder: (context) => ReportPage()),
//                       //       // );
//                       //     },
//                       //     child: Text(
//                       //       "Done",
//                       //       style: TextStyle(fontSize: 18),
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   /////////////////////////////////////
//   Future _selectFromDate(BuildContext context, Size size) async {
//     final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now().subtract(Duration(days: 0)),
//         lastDate: DateTime(2023),
//         builder: (BuildContext context, Widget? child) {
//           return Theme(
//               data: ThemeData.light().copyWith(
//                 colorScheme: ColorScheme.light()
//                     .copyWith(primary: P_Settings.appbarColor),
//               ),
//               child: Container(width: size.width * 0.4, child: child!));
//         });
//     if (pickedDate != null) {
//       setState(() {
//         currentDate = pickedDate;
//       });
//     } else {
//       print("please select date");
//     }
//     fromDate = DateFormat('dd-MM-yyyy').format(currentDate);
//   }

//   Future _selectToDate(BuildContext context, Size size) async {
//     final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2020),
//         lastDate: DateTime(2023),
//         builder: (BuildContext context, Widget? child) {
//           return Theme(
//               data: ThemeData.light().copyWith(
//                 colorScheme: ColorScheme.light()
//                     .copyWith(primary: P_Settings.appbarColor),
//               ),
//               child: Container(width: size.width * 0.4, child: child!));
//         });
//     if (pickedDate != null) {
//       setState(() {
//         currentDate = pickedDate;
//       });
//     } else {
//       print("please select date");
//     }
//     toDate = DateFormat('dd-MM-yyyy').format(currentDate);
//   }
// }
