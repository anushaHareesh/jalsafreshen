import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class PrintReport {
  Future<void> initialize() async {
    await SunmiPrinter.bindingPrinter();
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  }

  Future<Uint8List> readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  }

  //////////////////////////////////////////////
  Future<void> saleReportPrint(List<Map<String, dynamic>> result) async {
    await SunmiPrinter.lineWrap(1); // creates one line space
    double sum = 0.0;
    // set alignment center
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.setCustomFontSize(20);
    await SunmiPrinter.bold();

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Bill No",
        width: 10,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "Date",
        width: 10,
        align: SunmiPrintAlign.CENTER,
      ),
      // ColumnMaker(
      //   text: "Party",
      //   width: 8,
      //   align: SunmiPrintAlign.CENTER,
      // ),
      ColumnMaker(
        text: "Amount",
        width: 15,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
    await SunmiPrinter.line();
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);

    await SunmiPrinter.setCustomFontSize(20);
    await SunmiPrinter.bold();

    for (int i = 0; i < result.length; i++) {
      sum = sum + result[i]["net_amt"];
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
          // text:"jhdjsdjhdjsdjdhhhhhhhhhhhhhhhhh",
          text: result[i]["sale_Num"],
          width: 10,
          align: SunmiPrintAlign.LEFT,
        ),
        ColumnMaker(
          // text:"jhdjsdjhdjsdjdhhhhhhhhhhhhhhhhh",
          text: result[i]["Date"],
          width: 10,
          align: SunmiPrintAlign.LEFT,
        ),
        // ColumnMaker(
        //   text: result[i]["cus_name"],
        //   width: 8,
        //   align: SunmiPrintAlign.CENTER,
        // ),
        ColumnMaker(
          //  text: "345622.00",
          text: result[i]["net_amt"].toStringAsFixed(2),
          width: 15,
          align: SunmiPrintAlign.RIGHT,
        ),
      ]);
      // await SunmiPrinter.lineWrap(1);
    }
    await SunmiPrinter.line();
    await SunmiPrinter.bold();
    await SunmiPrinter.setCustomFontSize(23);

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Grand Total",
        width: 14,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "${sum.toStringAsFixed(2)}",
        width: 16,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
  }

////////////////////////////////////////////////////////////
  Future<void> orderReportPrint(List<Map<String, dynamic>> result) async {
    await SunmiPrinter.lineWrap(1); // creates one line space
    double sum = 0.0;
    // set alignment center
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.setCustomFontSize(20);
    await SunmiPrinter.bold();

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Item",
        width: 14,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "Qty",
        width: 7,
        align: SunmiPrintAlign.CENTER,
      ),
      ColumnMaker(
        text: "Rate",
        width: 7,
        align: SunmiPrintAlign.CENTER,
      ),
      ColumnMaker(
        text: "Amount",
        width: 7,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
    await SunmiPrinter.line();
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.setCustomFontSize(20);
    await SunmiPrinter.bold();
    for (int i = 0; i < result.length; i++) {
      double amt = result[i]["rate"] * result[i]["qty"];
      sum = sum + amt;
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
          // text:"jhdjsdjhdjsdjdhhhhhhhhhhhhhhhhh",
          text: result[i]["item"],
          width: 14,
          align: SunmiPrintAlign.LEFT,
        ),
        ColumnMaker(
          // text:"jhdjsdjhdjsdjdhhhhhhhhhhhhhhhhh",
          text: result[i]["qty"].toString(),
          width: 7,
          align: SunmiPrintAlign.LEFT,
        ),
        ColumnMaker(
          text: result[i]["rate"].toString(),
          width: 7,
          align: SunmiPrintAlign.CENTER,
        ),
        ColumnMaker(
          //  text: "345622.00",
          text: amt.toStringAsFixed(2),
          width: 7,
          align: SunmiPrintAlign.RIGHT,
        ),
      ]);
      // await SunmiPrinter.lineWrap(1);
    }
    await SunmiPrinter.line();
    await SunmiPrinter.bold();
    await SunmiPrinter.setCustomFontSize(23);

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Grand Total",
        width: 14,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "${sum.toStringAsFixed(2)}",
        width: 16,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
  }

  //////////////////////////////////////////////////////////
  Future<void> collectionReportPrint(List<Map<String, dynamic>> result) async {
    await SunmiPrinter.lineWrap(1); // creates one line space
    double sum = 0.0;
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.setCustomFontSize(20);
    await SunmiPrinter.bold();

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Date",
        width: 8,
        align: SunmiPrintAlign.CENTER,
      ),
      ColumnMaker(
        text: "Party",
        width: 14,
        align: SunmiPrintAlign.CENTER,
      ),
      ColumnMaker(
        text: "Amount",
        width: 8,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
    await SunmiPrinter.line();
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);

    await SunmiPrinter.setCustomFontSize(20);
    await SunmiPrinter.bold();

    for (int i = 0; i < result.length; i++) {
      sum = sum + result[i]["rec_amount"];
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
          // text:"jhdjsdjhdjsdjdhhhhhhhhhhhhhhhhh",
          text: result[i]["rec_date"],
          width: 8,
          align: SunmiPrintAlign.LEFT,
        ),
        ColumnMaker(
          text: result[i]["cus_name"],
          width: 14,
          align: SunmiPrintAlign.CENTER,
        ),
        ColumnMaker(
          //  text: "345622.00",
          text: result[i]["rec_amount"].toString(),
          width: 8,
          align: SunmiPrintAlign.RIGHT,
        ),
      ]);
    }

    await SunmiPrinter.line();
    await SunmiPrinter.bold();
    await SunmiPrinter.setCustomFontSize(23);

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Grand Total",
        width: 14,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "${sum.toStringAsFixed(2)}",
        width: 16,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
  }

  Future<Uint8List> _getImageFromAsset(String iconPath) async {
    return await readFileBytes(iconPath);
  }

  Future<void> closePrinter() async {
    await SunmiPrinter.unbindingPrinter();
  }

  Future<void> printReport(
      List<Map<String, dynamic>> reportData, String type) async {
    print("reportData--$type--${reportData}");
    await initialize();
    // await printLogoImage();
    // await printText("Flutter is awesome");
    // await printHeader(printSalesData, payment_mode);
    if (type == "sales") {
      await saleReportPrint(reportData);
    } else if (type == "collection") {
      await collectionReportPrint(reportData);
    } else if (type == "sale order") {
      await orderReportPrint(reportData);
    }
    // await SunmiPrinter.line();
    // await printTotal(printSalesData);
    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter.submitTransactionPrint();
    await SunmiPrinter.cut();
    await closePrinter();
  }
}
