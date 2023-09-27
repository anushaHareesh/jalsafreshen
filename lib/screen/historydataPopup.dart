import 'package:flutter/material.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:provider/provider.dart';

class HistoryPopup {
  Future buildPopupDialog(BuildContext context, Size size, String? orderNum,
      String? cusId, String type) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
      backgroundColor: Colors.white,

            content: Consumer<Controller>(builder: (context, value, child) {
              if (value.isLoading) {
                return CircularProgressIndicator();
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 11),
                      child: Container(
                        height: size.height * 0.04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            type == "sale order"
                                ? Text(
                                    "Ord No : ${orderNum}",
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 13),
                                  )
                                : Text(
                                    "Bill No : ${orderNum}",
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 13),
                                  ),
                            // Text(
                            //   cusId,
                            //   style: TextStyle(color: Colors.grey[500]),
                            // )
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: FittedBox(
                        // height: size.height*0.2,
                        child: DataTable(
                          horizontalMargin: 0,
                          headingRowHeight: 25,
                          dataRowHeight: 30,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Color.fromARGB(255, 240, 235, 235)),
                          columnSpacing: 0,
                          showCheckboxColumn: false,
                          dataRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          border: TableBorder.all(width: 1, color: Colors.grey),
                          columns: getColumns(value.tableHistorydataColumn),
                          rows: getRowss(value.historydataList),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),

            // actions: [
            //   ElevatedButton(onPressed: (){
            //     Navigator.pop(context);
            //   }, child: Text("ok"))
            // ],
          );
        });
  }

  List<DataColumn> getColumns(List<String> columns) {
    print("columns---${columns}");
    String behv;
    String colsName;
    return columns.map((String column) {
      // double strwidth = double.parse(behv[3]);
      // strwidth = strwidth * 10; //
      return DataColumn(
        label: Container(
          width: 70,
          child: Text(
            column,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
            // textAlign: behv[1] == "L" ? TextAlign.left : TextAlign.right,
          ),
          // ),
        ),
      );
    }).toList();
  }

  ////////////////////////////////////////////
  List<DataRow> getRowss(List<Map<String, dynamic>> rows) {
    List<String> newBehavr = [];
    print("rows---$rows");
    return rows.map((row) {
      return DataRow(
        // color: MaterialStateProperty.all(Colors.green),
        cells: getCelle(row),
      );
    }).toList();
  }
/////////////////////////////////////////////

  List<DataCell> getCelle(Map<String, dynamic> data) {
    // print("data--$data");
    //  double  sum=0;
    List<DataCell> datacell = [];

    // print("main header---$mainHeader");

    data.forEach((key, value) {
      datacell.add(
        DataCell(
          Container(
            width: 70,
            // width: mainHeader[k][3] == "1" ? 70 : 30,
            alignment: Alignment.center,
            //     ? Alignment.centerLeft
            //     : Alignment.centerRight,
            child: Text(
              value.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ),
        ),
      );
    });

    // print(datacell.length);
    return datacell;
  }
}
