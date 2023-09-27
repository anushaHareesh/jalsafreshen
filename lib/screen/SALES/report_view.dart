import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportView {
  String? date;
  DateTime now = DateTime.now();
  String? staff_name;
  String? cname;

  Future<Uint8List> generate(
      List<Map<String, dynamic>> list, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    staff_name = prefs.getString("staff_name");
    cname = prefs.getString("cname");

    date = DateFormat('dd / MM / yyyy').format(now);
    final pdf = Document();
    pdf.addPage(MultiPage(
      pageFormat:
          PdfPageFormat.a4.applyMargin(left: 0, top: 0, right: 0, bottom: 0),
      crossAxisAlignment: CrossAxisAlignment.center,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      build: (context) => [
        buildHeading(),
        SizedBox(height: 0.1 * PdfPageFormat.cm),
        // buildCustomerData(masterPdf),
        // SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildTable(list, type),

        buildTotal(list, type)
      ],

      // header: (
      //   context,
      // ) {
      //   return buildHeader(headerimage);
      // },
      // footer: (context) =>
      //     buildFooter(termsList, msg_log, footerimage, staff_name.toString()),
    ));
    return pdf.save();
  }

/////////////////////////////////////////////////////////////////////////
  Widget buildHeading() {
    return Container(
        child: Column(children: [
      SizedBox(height: 6),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(cname.toString(), style: TextStyle(fontSize: 18))]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          "Date         :    ",
          style: TextStyle(fontSize: 14),
        ),
        Text(
          date.toString(),
          style: TextStyle(fontSize: 14),
        ),
      ]),
    ]));
  }
////////////////////////////////////////////

  Widget buildTable(List<Map<String, dynamic>> list, String type) {
    print("build table-------$list");
    var cellAlignments;
    var headerAlignnments;
    ;
    if (type == "sales") {
      cellAlignments = {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerRight,
      };
      headerAlignnments = {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
      };
    } else if (type == "collection") {
      cellAlignments = {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
      };
      headerAlignnments = {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
      };
    } else if (type == "sale order") {
      cellAlignments = {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
      };
      headerAlignnments = {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
      };
    }
    int i = 0;
    List headers = [];
    if (type == "sales") {
      headers = [
        'Bill No',
        "Date",
        'Party',
        'Net Amount',
      ];
    } else if (type == "sale order") {
      headers = [
        'Item',
        'Qty',
        'Rate',
        'Amount',
      ];
    } else if (type == "collection") {
      headers = [
        'Date',
        'Party',
        'Amount',
      ];
    }
    var data1;
    Map map;
    List<List<dynamic>> data = [];
    int j;
    for (int i = 0; i < list.length; i++) {
      data1 = returnRows(list[i], (i + 1).toString(), type);
      data.add(data1);
    }
    return Table.fromTextArray(
        headers: headers,
        data: data,
        tableWidth: TableWidth.max,

        // cellDecoration: (index, data, rowNum) {
        //   return TableRow(children: children)
        // },
        border: TableBorder(
          left: BorderSide(
            color: PdfColors.grey,
          ),
          right: BorderSide(
            color: PdfColors.grey,
          ),
          // top: BorderSide(
          //   color: PdfColors.grey,
          // ),
          bottom: BorderSide(
            color: PdfColors.grey,
          ),
          // verticalInside: BorderSide(),
          // left: pw.BorderSide(style: pw.BorderStyle.solid),
          horizontalInside: BorderSide.none,
          verticalInside: BorderSide(
            color: PdfColors.grey,
            style: BorderStyle.solid,
          ),
        ),
        headerHeight: 23,
        headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        cellStyle: TextStyle(fontSize: 11),
        headerDecoration: BoxDecoration(color: PdfColors.grey300),
        cellHeight: 23,
        headerAlignments: headerAlignnments,
        // columnWidths: {
        //   // 0: FixedColumnWidth(50),
        //   1: FixedColumnWidth(160),
        //   // 2: FixedColumnWidth(50),
        //   // 3: FixedColumnWidth(70),
        //   // 4: FixedColumnWidth(70),
        //   // 5: FixedColumnWidth(60),
        //   // 6: FixedColumnWidth(60),
        //   // 7: FixedColumnWidth(60),
        //   // 8: FixedColumnWidth(80),
        // },
        cellAlignments: cellAlignments);
  }

  /////////////////////////////////////////////////////
  returnRows(Map listmap, String i, String type) {
    if (type == "sales") {
      return [
        listmap["sale_Num"],
        listmap["Date"],
        listmap["cus_name"],
        listmap["net_amt"],
      ];
    } else if (type == "collection") {
      return [
        listmap["rec_date"],
        listmap["cus_name"],
        listmap["rec_amount"],
      ];
    } else if (type == "sale order") {
      double amt = listmap["rate"] * listmap["qty"];
      return [
        listmap["item"],
        listmap["qty"],
        listmap["rate"],
        amt.toStringAsFixed(2)
      ];
    }
  }

//////////////////////////////////////////////////////////////////////////////

  Widget buildTotal(List<Map<String, dynamic>> list, String type) {
    double sum = 0.0;
    double amount_tot = 0.0;
    double gstTot = 0.0;
    double disctTot = 0.0;

    for (int i = 0; i < list.length; i++) {
      if (type == "sales") {
        sum = list[i]["net_amt"] + sum;
      } else if (type == "collection") {
        sum = list[i]["rec_amount"] + sum;
      } else if (type == "sale order") {
        double amt = list[i]["rate"] * list[i]["qty"];
        sum = amt + sum;
      }
      // amount_tot = double.parse(list[i]["amount"]) + amount_tot;
      // gstTot = double.parse(list[i]["tax"]) + gstTot;
      // disctTot = double.parse(list[i]["discount_amount"]) + disctTot;
    }

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2 * PdfPageFormat.mm),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Row(children: [
                  Expanded(
                      child: Text(
                    'Grand total',
                  )),
                  // Container(
                  //   child: Image(image, height: 8, width: 9),
                  // ),
                  Text(sum.toStringAsFixed(2))
                ]),
                // buildText(
                //   title: 'Grand total',
                //   value: sum.toStringAsFixed(2),
                //   unite: true,
                // ),

                Divider(),

                // SizedBox(height: 2 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400),
                // SizedBox(height: 0.5 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

//////////////////////////////////////////////////////////////////////

  loadDa() async {
    var data = await rootBundle.load("assets/Rupee_Foradian.ttf");
    return data;
  }
  // Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  //   final path = (await getExternalStorageDirectory())!.path;
  //   final file = File('$path/$fileName');
  //   await file.writeAsBytes(bytes, flush: true);
  //   OpenFilex.open('$path/$fileName');
  // }
}
