// import 'package:flutter/material.dart';
// import 'package:orderapp/components/sunmi.dart';
// import 'package:provider/provider.dart';

// import '../controller/controller.dart';

// class SunmiScreen extends StatefulWidget {
//   const SunmiScreen({Key? key}) : super(key: key);

//   @override
//   State<SunmiScreen> createState() => _SunmiScreenState();
// }

// class _SunmiScreenState extends State<SunmiScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sunmi Flutter Demo'),
//       ),
//       body: Consumer<Controller>(
//         builder: (context, value, child) => 
//         Container(
//           height: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Center(
//                 child: Text('Sunmi pos printer'),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Sunmi printer = Sunmi();
//                   printer.printReceipt(value.printSalesData);
//                 },
//                 child: const Text('Print'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
