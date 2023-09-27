///////////////////////////////////////////
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/screen/historydataPopup.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  String? page;
  History({this.page});
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  HistoryPopup popup = HistoryPopup();
  List<Map<String, dynamic>> newJson = [];
  final rows = <DataRow>[];
  String? behv;
  bool isSelected = false;
  Size? size;
  List<String>? colName;
  List<Map<String, dynamic>> products = [];
  List<String> behvr = [];
  Map<String, dynamic> mainHeader = {};
  int col = 0;

//////////////////////////////////////////////////////////////////////////////
  onSelectedRow(bool selected, Map<String, dynamic> history) async {
    if (selected) {
      // isSelected=true;
      print("history----$history");
      Provider.of<Controller>(context, listen: false).getHistoryData(
          'orderDetailTable', "order_id='${history["order_id"]}'");
      popup.buildPopupDialog(
          context, size!, history["Order_Num"], history["Cus_id"],"sale order");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = Provider.of<Controller>(context, listen: false).productName;
    // Provider.of<Controller>(context, listen: false)
    //     .getProductList(widget.customerId);
    // list.removeAt(0);
    // for (var item in list) {
    //   tableColumn.add(item);
    // }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    products = Provider.of<Controller>(context, listen: false).productName;

    // Provider.of<Controller>(context, listen: false).getHistory();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    // if (col <= 5) {
    //   width / col;
    // }
    return Scaffold(
      // appBar: AppBar(title: Text("Dynamic datatable")),
      body: InteractiveViewer(
        minScale: .4,
        maxScale: 5,
        child: Consumer<Controller>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Container(
                alignment: Alignment.center,
                height: height * 0.9,
                child: SpinKitCircle(
                  color: P_Settings.wavecolor,
                ),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: height * 0.03,
                      child: Text(
                        "History",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      horizontalMargin: 0,
                      headingRowHeight: 30,
                      dataRowHeight: 35,
                      // dataRowColor:
                      //     MaterialStateColor.resolveWith((states) => Colors.yellow),
                      columnSpacing: 0,
                      showCheckboxColumn: false,

                      border: TableBorder.all(width: 1, color: Colors.black),
                      columns: getColumns(value.tableColumn),
                      rows: getRowss(value.historyList),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////
  List<DataColumn> getColumns(List<String> columns) {
    // print("columns---${columns}");
    String behv;
    String colsName;
    return columns.map((String column) {
      // double strwidth = double.parse(behv[3]);
      // strwidth = strwidth * 10; //
      return DataColumn(
        label: Container(
          width: 100,
          child: Text(
            column,
            style: TextStyle(fontSize: 12),
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
    // print("rows---$rows");
    return rows.map((row) {
      return DataRow(
        //  selected:rows.contains(row),
        onSelectChanged: (value) {
          onSelectedRow(value!, row);
          print("hello");
        },
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
    mainHeader.remove('rank');
    // print("main header---$mainHeader");

    data.forEach((key, value) {
      datacell.add(
        DataCell(
          Container(
            width: 100,
            // width: mainHeader[k][3] == "1" ? 70 : 30,
            alignment: Alignment.center,
            //     ? Alignment.centerLeft
            //     : Alignment.centerRight,
            child: Text(
              value.toString(),
              // textAlign:
              //     mainHeader[k][1] == "L" ? TextAlign.left : TextAlign.right,
              style: TextStyle(
                fontSize: 10,
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
