// import 'package:flutter/material.dart';
// import 'package:salesapp/controller/controller.dart';

// import 'package:image/image.dart' as Imag;
// import 'package:provider/provider.dart';

// class PrintMainPage extends StatefulWidget {
//   const PrintMainPage({Key? key}) : super(key: key);

//   @override
//   State<PrintMainPage> createState() => _PrintMainPageState();
// }

// class _PrintMainPageState extends State<PrintMainPage> {
//   String _info = "";
//   String _msj = '';
//   bool connected = false;
//   List<BluetoothInfo> items = [];
//   List<String> _options = [
//     "permission bluetooth granted",
//     "bluetooth enabled",
//     "connection status",
//     "update info"
//   ];

//   String _selectSize = "2";
//   final _txtText = TextEditingController(text: "Hello developer");
//   bool _connceting = false;
//   Future<void> getBluetoots() async {
//     final List<BluetoothInfo> listResult =
//         await PrintBluetoothThermal.pairedBluetooths;
//     if (listResult.length == 0) {
//       _msj =
//           "There are no bluetoohs linked, go to settings and link the printer";
//     } else {
//       _msj = "Touch an item in the list to connect";
//     }

//     setState(() {
//       items = listResult;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getBluetoots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(),
//       body: Consumer<Controller>(
//         builder: (context, value, child) {
//           if (items.length == 0) {
//             return Container(
//               height: size.height * 0.75,
//               child: Center(
//                   child: Text(
//                 "Turn on your bluetooth...",
//                 style: TextStyle(fontSize: 20),
//               )),
//             );
//           } else {
//             return ListView.builder(
//                 itemCount: items.length > 0 ? items.length : 0,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     onTap: () {
//                       String mac = items[index].macAdress;
//                       this.connect(mac);
//                       printTest(value.printSalesData);
//                     },
//                     title: Text('Name: ${items[index].name}'),
//                     subtitle: Text("macAdress: ${items[index].macAdress}"),
//                   );
//                 });
//           }
//         },
//       ),
//     );
//   }

//   Future<void> connect(String mac) async {
//     setState(() {
//       _connceting = true;
//     });
//     final bool result =
//         await PrintBluetoothThermal.connect(macPrinterAddress: mac);
//     print("state conected $result");
//     if (result) connected = true;
//     setState(() {
//       _connceting = false;
//     });
//   }

//   Future<void> disconnect() async {
//     final bool status = await PrintBluetoothThermal.disconnect;
//     setState(() {
//       connected = false;
//     });
//     print("status disconnect $status");
//   }

//   Future<void> printTest(Map printSalesData) async {
//     bool conexionStatus = await PrintBluetoothThermal.connectionStatus;
//     if (conexionStatus) {
//       List<int> ticket = await testTicket(printSalesData);
//       final result = await PrintBluetoothThermal.writeBytes(ticket);
//       print("impresion $result");
//     } else {
//       //no conectado, reconecte
//     }
//   }

//   testTicket(Map printSalesData) async {
//     print("nkzsnfn------$printSalesData");
//     List<int> bytes = [];
//     List<int> bytesResult = [];
//     String billType;
//     if (printSalesData["master"]["payment_mode"] == "-3") {
//       billType = "SALES BILL - CREDIT";
//     } else {
//       billType = "SALES BILL - CASH";
//     }
//     // Using default profile
//     final profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm58, profile);
//     //bytes += generator.setGlobalFont(PosFontType.fontA);
//     bytes += generator.reset();

//     // bytes += generator.text(printSalesData["master"]["cus_name"],
//     //     styles: PosStyles(align: PosAlign.center, bold: true));
//     // bytes += generator.feed(1);
//     // bytes += generator.text(
//     //   "Bill No : ${printSalesData["master"]["sale_Num"]}",
//     //   styles: PosStyles(codeTable: 'CP1252'),
//     // );
//     // bytes += generator.text(printSalesData["master"]["Date"],
//     //     styles: PosStyles(codeTable: 'CP1252'));
//     // bytes += generator.feed(1);

//     List list = [];
//     ////////////////for header///////////////
//     list = [
//       {
//         "text": printSalesData["company"][0]["cnme"],
//         "width": 12,
//         "align": "c",
//         "underline": true,
//         "bold": true
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);

//     // list = [
//     //   {
//     //     "text": "Phn : ${printSalesData["company"][0]["mob"]}",
//     //     "width": 12,
//     //     "align": "c",
//     //     "underline": false,
//     //     "bold": true
//     //   },
//     // ];
//     // bytesResult += await printText(generator, bytes, list, 0, false, 0);

//     // list = [
//     //   {
//     //     "text": "Gstin : ${printSalesData["company"][0]["gst"]}",
//     //     "width": 12,
//     //     "align": "c",
//     //     "underline": false,
//     //     "bold": true
//     //   },
//     // ];
//     // bytesResult += await printText(generator, bytes, list, 0, false, 0);
//     bytesResult += generator.hr(ch: '-');

//     // bytesResult += generator.reset();
//     // //////////////////////////////////////////////////
//     list = [
//       {
//         "text": "${billType}",
//         "width": 12,
//         "align": "c",
//         "underline": true,
//         "bold": true
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);
//     list = [
//       {
//         "text": "BillNo : ",
//         "width": 4,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//       {
//         "text": "${printSalesData["master"]["sale_Num"]}",
//         "width": 8,
//         "align": "l",
//         "underline": false,
//         "bold": true
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);

//     list = [
//       {
//         "text": "BillDate : ",
//         "width": 4,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//       {
//         "text": "${printSalesData["master"]["Date"]}",
//         "width": 8,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);

//     // /////////
//     list = [
//       {
//         "text": "Staff : ",
//         "width": 4,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//       {
//         "text": "${printSalesData["staff"][0]["sname"]}",
//         "width": 8,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);
//     bytesResult += generator.hr(ch: '-');
// /////////////////////////////////////////
//     list = [
//       {
//         "text": "Party",
//         "width": 4,
//         "align": "l",
//         "underline": false,
//         "bold": true
//       },
//       {
//         "text": "${printSalesData["master"]["cus_name"]}",
//         "width": 8,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);
//     list = [
//       {"text": " ", "width": 4, "align": "l", "underline": false, "bold": true},
//       {
//         "text": "${printSalesData["master"]["address"]}",
//         "width": 8,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);
//     list = [
//       {
//         "text": "GSTIN",
//         "width": 4,
//         "align": "l",
//         "underline": false,
//         "bold": true
//       },
//       {
//         "text": "${printSalesData["master"]["gstin"]}",
//         "width": 8,
//         "align": "l",
//         "underline": false,
//         "bold": true
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);
//     list = [
//       {
//         "text": "O/S bal",
//         "width": 4,
//         "align": "l",
//         "underline": false,
//         "bold": true
//       },
//       {
//         "text": "${printSalesData["master"]["ba"].toStringAsFixed(2)}",
//         "width": 8,
//         "align": "l",
//         "underline": false,
//         "bold": true
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);

//     bytesResult += generator.hr(ch: '-');

//     list = [
//       // {
//       //   "text": "code ",
//       //   "width": 2,
//       //   "align": "l",
//       //   "underline": false,
//       //   "bold": true
//       // },
//       {
//         "text": "Item",
//         "width": 4,
//         "align": "l",
//         "underline": false,
//         "bold": true
//       },
//       {
//         "text": "Qty",
//         "width": 2,
//         "align": "l",
//         "underline": false,
//         "bold": true
//       },
//       {
//         "text": "Rate",
//         "width": 2,
//         "align": "r",
//         "underline": false,
//         "bold": true
//       },
//       {
//         "text": "Amount",
//         "width": 2,
//         "align": "r",
//         "underline": false,
//         "bold": true
//       },
//       {"text": "", "width": 2, "align": "r", "underline": false, "bold": true},
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);
//     bytesResult += generator.hr();

//     /////////for details/////////////////////
//     for (int i = 0; i < printSalesData["detail"].length; i++) {
//       list = [
//         {
//           "text": printSalesData["detail"][i]["item"],
//           "width": 4,
//           "align": "l",
//           "underline": false,
//           "bold": false
//         },
//         {
//           "text": printSalesData["detail"][i]["qty"].toStringAsFixed(2),
//           "width": 2,
//           "align": "c",
//           "underline": false,
//           "bold": false
//         },
//         {
//           "text": printSalesData["detail"][i]["rate"].toStringAsFixed(2),
//           "width": 2,
//           "align": "r",
//           "underline": false,
//           "bold": false
//         },
//         {
//           "text": printSalesData["detail"][i]["gross"].toStringAsFixed(2),
//           "width": 2,
//           "align": "r",
//           "underline": false,
//           "bold": false
//         },
//         {
//           "text": printSalesData["detail"][i]["unit"].toString(2),
//           "width": 2,
//           "align": "r",
//           "underline": false,
//           "bold": false
//         },
//       ];

//       bytesResult += await printText(generator, bytes, list, 0, false, 0);
//     }

//     bytesResult += generator.hr();

//     ////////////footer////////////////////////////////////////////
//     list = [
//       {
//         "text": "Count : ",
//         "width": 6,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//       {
//         "text": "${printSalesData["master"]["count"]}",
//         "width": 3,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//       {
//         "text": "${printSalesData["master"]["grossTot"].toStringAsFixed(2)}",
//         "width": 3,
//         "align": "r",
//         "underline": false,
//         "bold": false
//       },
//     ];
//     ///////////////////////////////////////////////////////////
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);

//     list = [
//       {
//         "text": "Discount : ",
//         "width": 6,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//       {
//         "text": "${printSalesData["master"]["distot"].toStringAsFixed(2)}",
//         "width": 6,
//         "align": "r",
//         "underline": false,
//         "bold": false
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);
//     list = [
//       {
//         "text": "Roundoff : ",
//         "width": 6,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//       {
//         "text": "${printSalesData["master"]["roundoff"].toStringAsFixed(2)}",
//         "width": 6,
//         "align": "r",
//         "underline": false,
//         "bold": false
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);

//     // list = [
//     //   {
//     //     "text": "Tax : ",
//     //     "width": 6,
//     //     "align": "l",
//     //     "underline": false,
//     //     "bold": false
//     //   },
//     //   {
//     //     "text": "${printSalesData["master"]["taxtot"].toStringAsFixed(2)}",
//     //     "width": 6,
//     //     "align": "r",
//     //     "underline": false,
//     //     "bold": false
//     //   },
//     // ];
//     // bytesResult += await printText(generator, bytes, list, 0, false, 0);
//     list = [
//       {
//         "text": "Total : ",
//         "width": 6,
//         "align": "l",
//         "underline": false,
//         "bold": false
//       },
//       {
//         "text": "${printSalesData["master"]["net_amt"].toStringAsFixed(2)}",
//         "width": 6,
//         "align": "r",
//         "underline": false,
//         "bold": false
//       },
//     ];
//     bytesResult += await printText(generator, bytes, list, 0, false, 0);

//     //  list = [
//     //   {
//     //     "text": "Curren ",
//     //     "width": 6,
//     //     "align": "l",
//     //     "underline": false,
//     //     "bold": false
//     //   },
//     //   {
//     //     "text": "${printSalesData["master"]["net_amt"].toStringAsFixed(2)}",
//     //     "width": 6,
//     //     "align": "r",
//     //     "underline": false,
//     //     "bold": false
//     //   },
//     // ];
//     // bytesResult += await printText(generator, bytes, list, 0, false, 0);

//     bytesResult += generator.cut();
//     bytesResult += generator.hr();

//     // bytes += generator.text('Bold text', styles: PosStyles(bold: true));
//     // bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
//     // bytes += generator.text('Underlined text',
//     //     styles: PosStyles(underline: true), linesAfter: 1);
//     // bytes +=
//     //     generator.text('Align left', styles: PosStyles(align: PosAlign.left));
//     // bytes += generator.text('Align center',
//     //     styles: PosStyles(align: PosAlign.center));
//     // bytes += generator.text('Align right',
//     //     styles: PosStyles(align: PosAlign.right), linesAfter: 1);

//     // bytes += generator.row(
//     //   [
//     //     PosColumn(
//     //       text: 'code',
//     //       width: 3,
//     //       styles: PosStyles(align: PosAlign.left, underline: true),
//     //     ),
//     //     PosColumn(
//     //       text: 'item',
//     //       width: 3,
//     //       styles: PosStyles(align: PosAlign.left, underline: true),
//     //     ),
//     //     PosColumn(
//     //       text: 'qty',
//     //       width: 3,
//     //       styles: PosStyles(align: PosAlign.right, underline: true),
//     //     ),
//     //     PosColumn(
//     //       text: 'rate',
//     //       width: 3,
//     //       styles: PosStyles(align: PosAlign.right, underline: true),
//     //     ),
//     //   ],
//     // );
//     // bytes += generator.feed(1);

//     // for (int i = 0; i < printSalesData["detail"].length; i++) {
//     //   bytes += generator.row(
//     //     [
//     //       PosColumn(
//     //         text: printSalesData["detail"][i]["code"].toString(),
//     //         width: 3,
//     //         styles: PosStyles(
//     //           align: PosAlign.left,
//     //         ),
//     //       ),
//     //       PosColumn(
//     //         text: printSalesData["detail"][i]["item"].toString(),
//     //         width: 3,
//     //         styles: PosStyles(
//     //           align: PosAlign.left,
//     //         ),
//     //       ),
//     //       PosColumn(
//     //         text: printSalesData["detail"][i]["qty"].toString(),
//     //         width: 3,
//     //         styles: PosStyles(
//     //           align: PosAlign.right,
//     //         ),
//     //       ),
//     //       PosColumn(
//     //         text: printSalesData["detail"][i]["rate"].toString(),
//     //         width: 3,
//     //         styles: PosStyles(
//     //           align: PosAlign.right,
//     //         ),
//     //       ),
//     //     ],
//     //   );
//     // }

//     // bytes += generator.feed(1);
//     // bytes += generator.row(
//     //   [
//     //     PosColumn(
//     //       text: "Item Count",
//     //       width: 3,
//     //       styles: PosStyles(
//     //         align: PosAlign.left,
//     //       ),
//     //     ),
//     //     PosColumn(
//     //       text: printSalesData["master"]["count"].toString(),
//     //       width: 9,
//     //       styles: PosStyles(
//     //         align: PosAlign.left,
//     //       ),
//     //     ),
//     //   ],
//     // );
//     // bytes += generator.row(
//     //   [
//     //     PosColumn(
//     //       text: "Total",
//     //       width: 6,
//     //       styles: PosStyles(align: PosAlign.left, bold: true),
//     //     ),
//     //     PosColumn(
//     //       text: "${printSalesData["master"]["net_amt"].toString()}",
//     //       width: 6,
//     //       styles: PosStyles(align: PosAlign.right, bold: true),
//     //     ),
//     //   ],
//     // );

//     // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
//     // bytes += generator.barcode(Barcode.upcA(barData));

//     // //QR code
//     // bytes += generator.qrcode('example.com');

//     // bytes += generator.text(
//     //   'Text size 50%',
//     //   styles: PosStyles(
//     //     fontType: PosFontType.fontB,
//     //   ),
//     // );
//     // bytes += generator.text(
//     //   'Text size 100%',
//     //   styles: PosStyles(
//     //     fontType: PosFontType.fontA,
//     //   ),
//     // );
//     // bytes += generator.text(
//     //   'Text size 200%',
//     //   styles: PosStyles(
//     //     height: PosTextSize.size2,
//     //     width: PosTextSize.size2,
//     //   ),
//     // );

//     // bytes += generator.feed(2);
//     //bytes += generator.cut();

//     print("bytesResult-----$bytesResult");
//     return bytesResult;
//   }

//   Future<List<int>> printText(final generator, List<int> bytes, List ptext,
//       int feed, bool cut, int fontType) async {
//     bytes += generator
//         .setGlobalFont(fontType == 0 ? PosFontType.fontB : PosFontType.fontA);
//     bytes += generator.row(ptext
//         .map(
//           (e) => PosColumn(
//             text: e["text"].toString(),
//             width: e["width"],
//             styles: PosStyles(
//                 bold: e["bold"],
//                 underline: e["underline"],
//                 align: e["align"] == "r"
//                     ? PosAlign.right
//                     : e["align"] == "c"
//                         ? PosAlign.center
//                         : PosAlign.left),
//           ),
//         )
//         .toList());
//     bytes += generator.feed(feed);
//     return bytes;
//   }
// }

// ////////////////// reference ////////////////////////////
// // Future<List<int>> testTicket() async {
// //   List<int> bytes = [];
// //   // Using default profile
// //   final profile = await CapabilityProfile.load();
// //   final generator = Generator(PaperSize.mm58, profile);
// //   //bytes += generator.setGlobalFont(PosFontType.fontA);
// //   bytes += generator.reset();

// //   final ByteData data = await rootBundle.load('asset/noData1.png');
// //   final Uint8List bytesImg = data.buffer.asUint8List();
// //   final image = Imag.decodeImage(bytesImg);
// //   // Using `ESC *`
// //   bytes += generator.image(image!);

// //   bytes += generator.text('Anusha k', styles: PosStyles());
// //   bytes += generator.text('Special 1: ñÑ àÀ èÈ éÉ üÜ çÇ ôÔ',
// //       styles: PosStyles(codeTable: 'CP1252'));
// //   bytes += generator.text(
// //     'Thottada ',
// //     styles: PosStyles(codeTable: 'CP1252'),
// //   );

// //   bytes += generator.text('Bold text', styles: PosStyles(bold: true));
// //   bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
// //   bytes += generator.text('Underlined text',
// //       styles: PosStyles(underline: true), linesAfter: 1);
// //   bytes +=
// //       generator.text('Align left', styles: PosStyles(align: PosAlign.left));
// //   bytes += generator.text('Align center',
// //       styles: PosStyles(align: PosAlign.center));
// //   bytes += generator.text('Align right',
// //       styles: PosStyles(align: PosAlign.right), linesAfter: 1);

// //   bytes += generator.row(
// //     [
// //       PosColumn(
// //         text: 'col3',
// //         width: 3,
// //         styles: PosStyles(align: PosAlign.center, underline: true),
// //       ),
// //       PosColumn(
// //         text: 'col6',
// //         width: 6,
// //         styles: PosStyles(align: PosAlign.center, underline: true),
// //       ),
// //       PosColumn(
// //         text: 'col3',
// //         width: 3,
// //         styles: PosStyles(align: PosAlign.center, underline: true),
// //       ),
// //     ],
// //   );

// //   final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
// //   bytes += generator.barcode(Barcode.upcA(barData));

// //   //QR code
// //   bytes += generator.qrcode('example.com');

// //   bytes += generator.text(
// //     'Text size 50%',
// //     styles: PosStyles(
// //       fontType: PosFontType.fontB,
// //     ),
// //   );
// //   bytes += generator.text(
// //     'Text size 100%',
// //     styles: PosStyles(
// //       fontType: PosFontType.fontA,
// //     ),
// //   );
// //   bytes += generator.text(
// //     'Text size 200%',
// //     styles: PosStyles(
// //       height: PosTextSize.size2,
// //       width: PosTextSize.size2,
// //     ),
// //   );

// //   bytes += generator.feed(2);
// //   //bytes += generator.cut();
// //   return bytes;
// // }