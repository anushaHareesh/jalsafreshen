import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imin_printer/column_maker.dart';

import 'package:imin_printer/enums.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/imin_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IminPrint {
  final iminPrinter = IminPrinter();

  Future<void> initialize() async {
    await iminPrinter.initPrinter();
    // String? state = await iminPrinter.getPrinterStatus();
    // Fluttertoast.showToast(
    //     msg: state ?? '',
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }

  //////////////////////////////////////////////////////////////
  Future<void> printHeader(Map<String, dynamic> printSalesData,
      String payment_mode, String iscancelled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? brname = prefs.getString(
      "br_name",
    );
    String? billType;
    if (payment_mode == "-2") {
      billType = "CASH BILL";
    } else if (payment_mode == "-3") {
      billType = "CREDIT BILL";
    }
    String ad1 = printSalesData["company"][0]["ad1"];
    String ad2 = printSalesData["company"][0]["ad2"];
    String mob = printSalesData["company"][0]["mob"];
    String gst = printSalesData["company"][0]["gst"];

    await iminPrinter.printAndLineFeed();
    await iminPrinter.setAlignment(IminPrintAlign.center);

    if (iscancelled == "cancelled") {
      await iminPrinter.printText("CANCELLED INVOICE",
          // printSalesData["company"][0]["gst"],
          style: IminTextStyle(
              fontSize: 21,
              // bold: true,
              align: IminPrintAlign.center,
              fontStyle: IminFontStyle.bold));
    } else {
      await iminPrinter.printText("TAX INVOICE",
          // printSalesData["company"][0]["gst"],
          style: IminTextStyle(
              fontSize: 21,
              align: IminPrintAlign.center,
              fontStyle: IminFontStyle.bold));
    }

    // await SunmiPrinter.line();
    await iminPrinter.setAlignment(
      IminPrintAlign.center,
    );

    await iminPrinter.printText(
        printSalesData["company"][0]["cnme"].toString().toUpperCase(),
        style: IminTextStyle(fontSize: 29, fontStyle: IminFontStyle.bold
            // align: SunmiPrintAlign.CENTER,
            ));
    // if (brname != null) {
    //   await iminPrinter.printText("( ${brname} )",
    //       style: IminTextStyle(
    //           fontSize: 20,
    //           fontStyle: IminFontStyle.bold,
    //           align: IminPrintAlign.center));
    // }
    await iminPrinter.printText(
        // printSalesData["company"][0]["ad1"],
        printSalesData["company"][0]["ad1"].toUpperCase(),
        style: IminTextStyle(
            fontSize: 16,
            fontStyle: IminFontStyle.bold,
            align: IminPrintAlign.center));

    await iminPrinter.printText(
        // "jhsjfhjdfnzd".toUpperCase(),
        printSalesData["company"][0]["ad2"].toUpperCase(),
        style: IminTextStyle(
            fontSize: 16,
            fontStyle: IminFontStyle.bold,
            align: IminPrintAlign.center));
    if (printSalesData["company"][0]["mob"] != null &&
        printSalesData["company"][0]["mob"].isNotEmpty) {
      await iminPrinter.printText(printSalesData["company"][0]["mob"],
          // printSalesData["company"][0]["mob"],
          style: IminTextStyle(
              fontSize: 16,
              fontStyle: IminFontStyle.bold,
              align: IminPrintAlign.center));
    }

    if (printSalesData["company"][0]["gst"] != null &&
        printSalesData["company"][0]["gst"].isNotEmpty) {
      await iminPrinter.printText(
          printSalesData["company"][0]["gst"].toUpperCase(),
          // printSalesData["company"][0]["gst"],
          style: IminTextStyle(
              fontSize: 20,
              fontStyle: IminFontStyle.bold,
              align: IminPrintAlign.center));
    }

    await iminPrinter.printAndLineFeed();

    await iminPrinter.setAlignment(IminPrintAlign.left);

    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(
          text: "Bill No", width: 10, fontSize: 23, align: IminPrintAlign.left),
      ColumnMaker(
          text: "${printSalesData["master"]["sale_Num"]}",
          width: 20,
          fontSize: 24,
          align: IminPrintAlign.left),
    ]);

    List<String> substrings = printSalesData["master"]["Date"].split("-");
    // print("hjbsjhdbjhasd-----$substrings");
    // List sub=substrings[0].split("-");
    String formattedDate =
        substrings[2] + "-" + substrings[1] + "-" + substrings[0];
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(
          text: "Date", width: 10, fontSize: 23, align: IminPrintAlign.left),
      ColumnMaker(
          text: "${formattedDate}",
          width: 20,
          fontSize: 24,
          align: IminPrintAlign.left),
    ]);
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(
          text: "Staff", width: 10, fontSize: 23, align: IminPrintAlign.left),
      ColumnMaker(
          text: "${printSalesData["staff"][0]["sname"]}",
          width: 20,
          fontSize: 24,
          align: IminPrintAlign.left),
    ]);
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(
          text: "Party", width: 10, fontSize: 23, align: IminPrintAlign.left),
      ColumnMaker(
          text: "${printSalesData["master"]["cus_name"]}",
          width: 20,
          fontSize: 24,
          align: IminPrintAlign.left),
    ]);
    await iminPrinter.printColumnsText(cols: [
      printSalesData["master"]["gstin"] == null ||
              printSalesData["master"]["gstin"].isEmpty
          ? ColumnMaker(text: "")
          : ColumnMaker(
              text: "GSTIN",
              width: 10,
              fontSize: 23,
              align: IminPrintAlign.left),
      ColumnMaker(
          text: "${printSalesData["master"]["gstin"]}",
          width: 20,
          fontSize: 24,
          align: IminPrintAlign.left),
    ]);
  }

  /////////////////////////////////////////////////////////////////////
  Future<void> printRowAndColumns(Map<String, dynamic> printSalesData) async {
    // await iminPrinter.printAndLineFeed(); // creates one line space
    // set alignment center
    await iminPrinter.setAlignment(IminPrintAlign.center);
    await iminPrinter.setTextSize(18);
    await iminPrinter.setTextStyle(IminFontStyle.bold);
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(
        text: "Item",
        width: 14,
        fontSize: 18,
        align: IminPrintAlign.left,
      ),
      ColumnMaker(
        text: "Qty",
        width: 7,
        fontSize: 18,
        align: IminPrintAlign.center,
      ),
      ColumnMaker(
        text: "Rate",
        width: 7,
        fontSize: 18,
        align: IminPrintAlign.right,
      ),
      ColumnMaker(
        text: "Amount",
        width: 7,
        fontSize: 18,
        align: IminPrintAlign.right,
      ),
    ]);

    // await iminPrinter.
    await iminPrinter.printText(
        "--------------------------------------------------",
        style: IminTextStyle(
            fontSize: 20,
            fontStyle: IminFontStyle.bold,
            align: IminPrintAlign.left));
    await iminPrinter.setAlignment(IminPrintAlign.center);
    await iminPrinter.setTextSize(17);

    // await SunmiPrinter.bold();

    for (int i = 0; i < printSalesData["detail"].length; i++) {
      await iminPrinter.printColumnsText(cols: [
        ColumnMaker(
            text: printSalesData["detail"][i]["item"],
            width: 14,
            fontSize: 17,
            align: IminPrintAlign.left),
        ColumnMaker(
          text: printSalesData["detail"][i]["qty"].toStringAsFixed(2),
          width: 7,
          fontSize: 17,
          align: IminPrintAlign.center,
        ),
        ColumnMaker(
          text: printSalesData["detail"][i]["rate"].toStringAsFixed(2),
          fontSize: 17,
          width: 7,
          align: IminPrintAlign.right,
        ),
        ColumnMaker(
          text: printSalesData["detail"][i]["net_amt"].toStringAsFixed(2),
          width: 7,
          fontSize: 17,
          align: IminPrintAlign.right,
        ),
      ]);
    }
  }

  /////////////////////////////////////////////////////////////////////
  Future<void> printTotal(Map<String, dynamic> printSalesData) async {
    await iminPrinter.printText(
        "--------------------------------------------------",
        style: IminTextStyle(
            fontSize: 20,
            fontStyle: IminFontStyle.bold,
            align: IminPrintAlign.left));

    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(
          text: "Roundoff ",
          width: 19,
          fontSize: 18,
          align: IminPrintAlign.left),
      ColumnMaker(
        text: printSalesData["master"]["roundoff"].toStringAsFixed(2),
        width: 16,
        fontSize: 18,
        align: IminPrintAlign.right,
      ),
    ]);
    double tot =
        printSalesData["master"]["ba"] + printSalesData["master"]["net_amt"];
    // await iminPrinter.setTextSize(23);
    await iminPrinter.setTextStyle(IminFontStyle.bold);

    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(
          text: "Total ", width: 16, fontSize: 20, align: IminPrintAlign.left),
      ColumnMaker(
        text: printSalesData["master"]["net_amt"].toStringAsFixed(2),
        width: 16,
        fontSize: 20,
        align: IminPrintAlign.right,
      ),
    ]);
    await iminPrinter.setAlignment(IminPrintAlign.left); // Left align
    // await SunmiPrinter.printText('TAxable Details');
    await iminPrinter.printAndLineFeed();

    await iminPrinter.setAlignment(IminPrintAlign.center);
    // await iminPrinter.setTextSize(20);
    // await SunmiPrinter.bold();
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(
        text: "TaxPer",
        width: 10,
        align: IminPrintAlign.center,
        fontSize: 18,
      ),
      ColumnMaker(
        text: "Taxble",
        width: 10,
        align: IminPrintAlign.center,
        fontSize: 18,
      ),
      ColumnMaker(
        text: "Cgst",
        width: 10,
        align: IminPrintAlign.center,
        fontSize: 18,
      ),
      ColumnMaker(
        text: "Sgst",
        width: 10,
        align: IminPrintAlign.center,
        fontSize: 18,
      ),
    ]);
    await iminPrinter.printText(
        "--------------------------------------------------",
        style: IminTextStyle(
            fontSize: 20,
            fontStyle: IminFontStyle.bold,
            align: IminPrintAlign.left));

    for (int i = 0; i < printSalesData["taxable_data"].length; i++) {
      await iminPrinter.printColumnsText(cols: [
        ColumnMaker(
            text: printSalesData["taxable_data"][i]["tper"].toStringAsFixed(2),
            width: 10,
            fontSize: 16,
            align: IminPrintAlign.center),
        ColumnMaker(
            text:
                printSalesData["taxable_data"][i]["taxable"].toStringAsFixed(2),
            width: 10,
            fontSize: 16,
            align: IminPrintAlign.center),
        ColumnMaker(
            text: printSalesData["taxable_data"][i]["cgst"].toStringAsFixed(2),
            width: 10,
            fontSize: 16,
            align: IminPrintAlign.center),
        ColumnMaker(
            text: printSalesData["taxable_data"][i]["sgst"].toStringAsFixed(2),
            width: 10,
            fontSize: 16,
            align: IminPrintAlign.center),
      ]);

      // await SunmiPrinter.lineWrap(1);
    }
    // await iminPrinter.printText(
    //     "----------------------------------------------",
    //     style: IminTextStyle(
    //         fontSize: 16,
    //         fontStyle: IminFontStyle.bold,
    //         width: 40,
    //         align: IminPrintAlign.center));
    // await iminPrinter.printAndLineFeed();
  }

  ////////////////////////////////////////////////////////////////////
  //  Future<void> closePrinter() async {
  //   await iminPrinter.un
  // }
  ////////////////////////////
  Future<void> printReceipt(Map<String, dynamic> printSalesData,
      String payment_mode, String iscancelled) async {
    print("value.printSalesData----${printSalesData}");
    await initialize();
    await printHeader(printSalesData, payment_mode, iscancelled);
    await iminPrinter.printAndLineFeed();
    await printRowAndColumns(printSalesData);
    await iminPrinter.printAndLineFeed();
    await printTotal(printSalesData);
    await iminPrinter.printText(
        "--------------------------------------------------",
        style: IminTextStyle(
            fontSize: 20,
            fontStyle: IminFontStyle.bold,
            align: IminPrintAlign.left));
    await iminPrinter.setAlignment(IminPrintAlign.center);
    await iminPrinter.setTextSize(17);
    await iminPrinter.printAndLineFeed();
    await iminPrinter.printAndLineFeed();
    await iminPrinter.printAndLineFeed();
    await iminPrinter.printAndLineFeed();
    await iminPrinter.printAndLineFeed();
    await iminPrinter.partialCut();
    // await closePrinter();
  }
}
