// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// class PrintPreview extends StatefulWidget {
//   final pw.Document doc;
//   PrintPreview({required this.doc});

//   @override
//   State<PrintPreview> createState() => _PrintPreviewState();
// }

// class _PrintPreviewState extends State<PrintPreview> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(),
//       body: PdfPreview(
//         build: (format) {
//           return _generatePdf(format, "fjndfn");
//           widget.doc.save();
//         },
//         initialPageFormat: PdfPageFormat.a4,
//         allowPrinting: true,
//         allowSharing: true,
//         pdfFileName: "test.pdf",
//       ),
//     );
//   }

//   _generatePdf(PdfPageFormat format, String title) async {
//     print("hjzshnd------$format---$title");
//     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
//     final font = await PdfGoogleFonts.nunitoExtraLight();

//     pdf.addPage(
//       pw.Page(
//         pageFormat: format,
//         build: (context) {
//           return pw.Column(
//             children: [
//               pw.SizedBox(
//                 width: double.infinity,
//                 child: pw.FittedBox(
//                   child: pw.Text(title, style: pw.TextStyle(font: font)),
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//               pw.Flexible(child: pw.FlutterLogo())
//             ],
//           );
//         },
//       ),
//     );

//     return pdf.save();
//   }
// }
