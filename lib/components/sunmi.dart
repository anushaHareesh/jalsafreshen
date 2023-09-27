import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

class Sunmi {
  // initialize sunmi printer
  Future<void> initialize() async {
    await SunmiPrinter.bindingPrinter();
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  }

  // print image
  Future<void> printLogoImage() async {
    await SunmiPrinter.lineWrap(1); // creates one line space
    Uint8List byte = await _getImageFromAsset('asset/1.png');
    await SunmiPrinter.printImage(byte);
    await SunmiPrinter.lineWrap(1); // creates one line space
  }

  Future<Uint8List> readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  }

  Future<Uint8List> _getImageFromAsset(String iconPath) async {
    return await readFileBytes(iconPath);
  }

  // print text passed as parameter
  Future<void> printText(String text) async {
    await SunmiPrinter.lineWrap(1); // creates one line space
    await SunmiPrinter.printText(text,
        style: SunmiStyle(
          fontSize: SunmiFontSize.MD,
          bold: true,
          align: SunmiPrintAlign.CENTER,
        ));
    await SunmiPrinter.lineWrap(1); // creates one line space
  }

//////////////////////////////////////////////////////////////////////////////////////////////////
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

    await SunmiPrinter.lineWrap(1); // creates one line space
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);

    if (iscancelled == "cancelled") {
      await SunmiPrinter.printText("CANCELLED INVOICE",
          // printSalesData["company"][0]["gst"],
          style: SunmiStyle(
            fontSize: SunmiFontSize.MD,
            bold: true,
            align: SunmiPrintAlign.CENTER,
          ));
    } else {
      await SunmiPrinter.printText("TAX INVOICE",
          // printSalesData["company"][0]["gst"],
          style: SunmiStyle(
            fontSize: SunmiFontSize.MD,
            bold: true,
            align: SunmiPrintAlign.CENTER,
          ));
    }

    // await SunmiPrinter.line();
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);

    await SunmiPrinter.printText(
        printSalesData["company"][0]["cnme"].toString().toUpperCase(),
        style: SunmiStyle(
          fontSize: SunmiFontSize.LG,
          bold: true,
          // align: SunmiPrintAlign.CENTER,
        ));
    if (brname != null) {
      await SunmiPrinter.printText("( ${brname} )",
          style: SunmiStyle(
            fontSize: SunmiFontSize.MD,
            bold: true,
            align: SunmiPrintAlign.CENTER,
          ));
    }
    await SunmiPrinter.printText(
        // printSalesData["company"][0]["ad1"],
        printSalesData["company"][0]["ad1"].toUpperCase(),
        style: SunmiStyle(
          fontSize: SunmiFontSize.SM,
          bold: true,
          align: SunmiPrintAlign.CENTER,
        ));

    await SunmiPrinter.printText(
        // "jhsjfhjdfnzd".toUpperCase(),
        printSalesData["company"][0]["ad2"].toUpperCase(),
        style: SunmiStyle(
          fontSize: SunmiFontSize.SM,
          bold: true,
          align: SunmiPrintAlign.CENTER,
        ));

    await SunmiPrinter.printText(printSalesData["company"][0]["mob"],
        // printSalesData["company"][0]["mob"],
        style: SunmiStyle(
          fontSize: SunmiFontSize.SM,
          bold: true,
          align: SunmiPrintAlign.CENTER,
        ));

    await SunmiPrinter.printText(
        printSalesData["company"][0]["gst"].toUpperCase(),
        // printSalesData["company"][0]["gst"],
        style: SunmiStyle(
          fontSize: SunmiFontSize.MD,
          bold: true,
          align: SunmiPrintAlign.CENTER,
        ));

    await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Bill No :",
        width: 10,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "${printSalesData["master"]["sale_Num"]}",
        width: 20,
        align: SunmiPrintAlign.LEFT,
      ),
    ]);

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Date    :",
        width: 10,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "${printSalesData["master"]["Date"]}",
        width: 20,
        align: SunmiPrintAlign.LEFT,
      ),
    ]);

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Staff   : ",
        width: 10,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "${printSalesData["staff"][0]["sname"]}",
        width: 20,
        align: SunmiPrintAlign.LEFT,
      ),
    ]);

    // await SunmiPrinter.printRow(cols: [
    //   ColumnMaker(
    //     text: "Branch  : ",
    //     width: 10,
    //     align: SunmiPrintAlign.LEFT,
    //   ),
    //   ColumnMaker(
    //     text: "${brname}",
    //     width: 20,
    //     align: SunmiPrintAlign.LEFT,
    //   ),
    // ]);

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Party   : ",
        width: 10,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "${printSalesData["master"]["cus_name"]}",
        width: 20,
        align: SunmiPrintAlign.LEFT,
      ),
    ]);
    // await SunmiPrinter.printRow(cols: [
    //   ColumnMaker(
    //     text: " ",
    //     width: 10,
    //     align: SunmiPrintAlign.LEFT,
    //   ),
    //   ColumnMaker(
    //     text: "${printSalesData["master"]["address"]}",
    //     width: 20,
    //     align: SunmiPrintAlign.LEFT,
    //   ),
    // ]);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "GSTIN   : ",
        width: 10,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "${printSalesData["master"]["gstin"]}",
        width: 20,
        align: SunmiPrintAlign.LEFT,
      ),
    ]);
    // await SunmiPrinter.printRow(cols: [
    //   ColumnMaker(
    //     text: "O/S",
    //     width: 10,
    //     align: SunmiPrintAlign.LEFT,
    //   ),
    //   ColumnMaker(
    //     text: "${printSalesData["master"]["ba"].toStringAsFixed(2)}",
    //     width: 20,
    //     align: SunmiPrintAlign.LEFT,
    //   ),
    // ]);

    // await SunmiPrinter.lineWrap(1); // creates one line space
  }

  // print text as qrcode
  Future<void> printQRCode(String text) async {
    // set alignment center
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.lineWrap(1); // creates one line space
    await SunmiPrinter.printQRCode(text);
    await SunmiPrinter.lineWrap(4); // creates one line space
  }

  // print row and 2 columns
  Future<void> printRowAndColumns(Map<String, dynamic> printSalesData) async {
    await SunmiPrinter.lineWrap(1); // creates one line space

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
        align: SunmiPrintAlign.RIGHT,
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

    for (int i = 0; i < printSalesData["detail"].length; i++) {
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
          // text:"jhdjsdjhdjsdjdhhhhhhhhhhhhhhhhh",
          text: printSalesData["detail"][i]["item"],
          width: 14,
          align: SunmiPrintAlign.LEFT,
        ),
        ColumnMaker(
          text: printSalesData["detail"][i]["qty"].toStringAsFixed(2),
          width: 7,
          align: SunmiPrintAlign.CENTER,
        ),
        ColumnMaker(
          //  text: "345622.00",
          text: printSalesData["detail"][i]["rate"].toStringAsFixed(2),
          width: 7,
          align: SunmiPrintAlign.RIGHT,
        ),
        ColumnMaker(
          // text:"123422.00",
          text: printSalesData["detail"][i]["net_amt"].toStringAsFixed(2),
          width: 7,
          align: SunmiPrintAlign.RIGHT,
        ),
      ]);
      // await SunmiPrinter.lineWrap(1);
    }

    // prints a row with 3 columns
    // total width of columns should be 30
    // await SunmiPrinter.printRow(cols: [
    //   ColumnMaker(
    //     text: "$column1",
    //     width: 10,
    //     align: SunmiPrintAlign.LEFT,
    //   ),
    //   ColumnMaker(
    //     text: "$column2",
    //     width: 10,
    //     align: SunmiPrintAlign.CENTER,
    //   ),
    //   ColumnMaker(
    //     text: "$column3",
    //     width: 10,
    //     align: SunmiPrintAlign.RIGHT,
    //   ),
    // ]);
    // await SunmiPrinter.lineWrap(1); // creates one line space
  }

  Future<void> printTotal(Map<String, dynamic> printSalesData) async {
    // creates one line space
    await SunmiPrinter.setCustomFontSize(20);
    await SunmiPrinter.bold();

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Roundoff ",
        width: 19,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: printSalesData["master"]["roundoff"].toStringAsFixed(2),
        width: 16,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);

    await SunmiPrinter.setCustomFontSize(23);
    await SunmiPrinter.bold();
    double tot =
        printSalesData["master"]["ba"] + printSalesData["master"]["net_amt"];
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Total ",
        width: 16,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: printSalesData["master"]["net_amt"].toStringAsFixed(2),
        width: 16,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT); // Left align
    // await SunmiPrinter.printText('TAxable Details');
    await SunmiPrinter.line();

    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.setCustomFontSize(18);
    await SunmiPrinter.bold();

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "TaxPer",
        width: 10,
        align: SunmiPrintAlign.CENTER,
      ),
      ColumnMaker(
        text: "Taxble",
        width: 10,
        align: SunmiPrintAlign.CENTER,
      ),
      ColumnMaker(
        text: "Cgst",
        width: 10,
        align: SunmiPrintAlign.CENTER,
      ),
      ColumnMaker(
        text: "Sgst",
        width: 10,
        align: SunmiPrintAlign.CENTER,
      ),
    ]);
    await SunmiPrinter.line();
    await SunmiPrinter.bold();
    await SunmiPrinter.setCustomFontSize(18);

    for (int i = 0; i < printSalesData["taxable_data"].length; i++) {
      await SunmiPrinter.printRow(cols: [
        ColumnMaker(
          // text:"jhdjsdjhdjsdjdhhhhhhhhhhhhhhhhh",
          text: printSalesData["taxable_data"][i]["tper"].toStringAsFixed(2),
          width: 10,
          align: SunmiPrintAlign.CENTER,
        ),
        ColumnMaker(
          text: printSalesData["taxable_data"][i]["taxable"].toStringAsFixed(2),
          width: 10,
          align: SunmiPrintAlign.CENTER,
        ),
        ColumnMaker(
          //  text: "345622.00",
          text: printSalesData["taxable_data"][i]["cgst"].toStringAsFixed(2),
          width: 10,
          align: SunmiPrintAlign.CENTER,
        ),
        ColumnMaker(
          //  text: "345622.00",
          text: printSalesData["taxable_data"][i]["sgst"].toStringAsFixed(2),
          width: 10,
          align: SunmiPrintAlign.CENTER,
        ),
      ]);
      // await SunmiPrinter.lineWrap(1);
    }
    // await SunmiPrinter.printRow(cols: [
    //   ColumnMaker(
    //     text: "Total Tax",
    //     width: 14,
    //     align: SunmiPrintAlign.LEFT,
    //   ),
    //   ColumnMaker(
    //     text: "${printSalesData["master"]["taxtot"].toStringAsFixed(2)}",
    //     width: 16,
    //     align: SunmiPrintAlign.RIGHT,
    //   ),
    // ]);
    // await SunmiPrinter.printRow(cols: [
    //   ColumnMaker(
    //     text: "Total Tax Amount",
    //     width: 14,
    //     align: SunmiPrintAlign.LEFT,
    //   ),
    //   ColumnMaker(
    //     text: "${printSalesData["master"]["taxtot"].toStringAsFixed(2)}",
    //     width: 16,
    //     align: SunmiPrintAlign.RIGHT,
    //   ),
    // ]);

    await SunmiPrinter.line();

    // await SunmiPrinter.bold();
    // await SunmiPrinter.setCustomFontSize(23);

    // await SunmiPrinter.printRow(cols: [
    //   ColumnMaker(
    //     text: "Grand Total",
    //     width: 14,
    //     align: SunmiPrintAlign.LEFT,
    //   ),
    //   ColumnMaker(
    //     text: "${tot.toStringAsFixed(2)}",
    //     width: 16,
    //     align: SunmiPrintAlign.RIGHT,
    //   ),
    // ]);
  }

/////////////////////////////////////////////////////////////////////////////////////////
  Future<void> details(Map<String, dynamic> printSalesData) async {
    await SunmiPrinter.bold();

    await SunmiPrinter.setCustomFontSize(15);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Font size 15",
        width: 20,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "F width 50 ",
        width: 30,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);

    await SunmiPrinter.setCustomFontSize(18);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Font size 18",
        width: 20,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "F width 40 ",
        width: 20,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);

    await SunmiPrinter.setCustomFontSize(20);
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: "Font size 20",
        width: 20,
        align: SunmiPrintAlign.LEFT,
      ),
      ColumnMaker(
        text: "F width 36 ",
        width: 16,
        align: SunmiPrintAlign.RIGHT,
      ),
    ]);
  }

  /* its important to close the connection with the printer once you are done */
  Future<void> closePrinter() async {
    await SunmiPrinter.unbindingPrinter();
  }

  // print one structure
  Future<void> printReceipt(Map<String, dynamic> printSalesData,
      String payment_mode, String iscancelled) async {
    print("value.printSalesData----${printSalesData}");
    await initialize();
    // await printLogoImage();
    // await printText("Flutter is awesome");
    await printHeader(printSalesData, payment_mode, iscancelled);
    await printRowAndColumns(printSalesData);
    await SunmiPrinter.line();
    await printTotal(printSalesData);

    // await details(printSalesData);

    // await printQRCode("Dart is powerful");
    await SunmiPrinter.lineWrap(4);
    await SunmiPrinter.submitTransactionPrint();
    await SunmiPrinter.cut();
    await closePrinter();
  }
}
