// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:orderapp/components/printingSale.dart';

// class ScreenPrint extends StatefulWidget {
//   const ScreenPrint({Key? key}) : super(key: key);

//   @override
//   State<ScreenPrint> createState() => _ScreenPrintState();
// }

// class _ScreenPrintState extends State<ScreenPrint> {
//   List<Map<String, dynamic>> data = [
//     {'title': "jjfd", "Price": "100"},
//     {'title': "jjxdfd", "Price": "190"}
//   ];
//   final f = NumberFormat("\$###,###.00", "en_US");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Expanded(
//               child: ListView.builder(
//                   itemCount: data.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(
//                         data[index]["title"].toString(),
//                       ),
//                       subtitle: Text(data[index]["Price"].toString()),
//                     );
//                   })),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>  PrintMainPage(data: data,)),
//                     );
//                   },
//                   child: Text("Print"))
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
