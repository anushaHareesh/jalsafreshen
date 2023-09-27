import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';
// import 'package:reports/components/customColor.dart';

class ShrinkedDatatable extends StatefulWidget {
  // Map<String, dynamic> map;
  var decodd;
  String level;

  ShrinkedDatatable({
    required this.decodd,
    required this.level,
  });

  @override
  State<ShrinkedDatatable> createState() => _ShrinkedDatatableState();
}

class _ShrinkedDatatableState extends State<ShrinkedDatatable> {
  List<String> tableColumn = [];
  double width = 0.0;
  Map<String, dynamic> valueMap = {};
  List<String>? colName;
  int i = 0;
  List<String>? rowName;
  Map<String, dynamic> mapTabledata = {};
  // var jsondata;
  int colNo = 0;
  List<Map<String, dynamic>> newMp = [];
  String? behv;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.decodd != null) {
      mapTabledata = json.decode(widget.decodd);
      print("shrinked   mapTabledata---${mapTabledata}");
      colNo = mapTabledata.length - 2;
      // print("colNumber---${colNo}");
    } else {
      print("null");
    }
    String element0 = mapTabledata.keys.elementAt(0);
    String element1 = mapTabledata.keys.elementAt(1);

    print("element0----${element0}");
    print("element1----${element1}");

    mapTabledata.remove(element0);
    mapTabledata.remove(element1);

    mapTabledata.forEach((key, value) {
      tableColumn.add(key);
      valueMap[key] = value;
    });
    newMp.add(valueMap);
    // print("tableColumn---${tableColumn}");
    // print("valueMap---${valueMap}");
    // print("newMp---${newMp}");
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width - 30;
    if (colNo < 10) {
      print("if");

      width = width / colNo;
    } else {
      width = 60;
      print("else");
    }
    print("width----${width}");
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 7,
        headingRowHeight: 35,
        dataRowHeight: 35,
        horizontalMargin: 5,
        decoration: BoxDecoration(color: P_Settings.l1totColor),
        border: TableBorder.all(
          color: P_Settings.l1totColor,
        ),
        dataRowColor:
            MaterialStateColor.resolveWith((states) => widget.level == "level1"
                ? P_Settings.color4
                : widget.level == "level2"
                    ? P_Settings.color4
                    : widget.level == "level3"
                        ? P_Settings.color4
                        : P_Settings.color4),
        columns: getColumns(tableColumn),
        rows: getRowss(newMp),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    String behv;
    String colsName;

    return columns.map((String column) {
      // final isAge = column == columns[2];
      colName = column.split('_');
      colsName = colName![1];
      behv = colName![0];

      return DataColumn(
        tooltip: colsName,
        label: ConstrainedBox(
          constraints: BoxConstraints(minWidth: width, maxWidth: width * 2),
          child: Padding(
            padding: EdgeInsets.all(0.0),

            // padding: behv[1] == "L"? EdgeInsets.only(left:0.3):EdgeInsets.only(right:0.3),
            child: Text(
              colsName,
              style: TextStyle(fontSize: 12),
              textAlign: behv[1] == "L" ? TextAlign.left : TextAlign.right,
            ),
          ),
        ),
      );
    }).toList();
  }

  ////////////////////////////////////////////////////////////
  List<DataRow> getRowss(List<Map<String, dynamic>> row) {
    return newMp.map((row) {
      return DataRow(
        cells: getCelle(row),
      );
    }).toList();
  }

  ///////////////////////////////////////////////////////////
  List<DataCell> getCelle(Map<String, dynamic> data) {
    String behv;
    String colsName;
    String d2 = "";
    double d;
    print("data--$data");
    List<DataCell> datacell = [];
    for (var i = 0; i < tableColumn.length; i++) {
      data.forEach((key, value) {
        if (tableColumn[i] == key) {
          rowName = tableColumn[i].split('_');
          colsName = rowName![1];
          behv = rowName![0];
          print("behv[0]---${behv[0]}");
           if (value == null) {
            print("entered");
            value = "0";
          }
          if (behv[0] == "C") {
            print("if");
            print("colsName---$value");
            d= double.parse(value);
            d2 = d.toStringAsFixed(2);
          }
          print("d2----$d2");
          // print("column---${tableColumn[i]}");
          datacell.add(
            DataCell(
              Container(
                constraints:
                    BoxConstraints(minWidth: width, maxWidth: width * 2),
                // width: 70,
                alignment: behv[1] == "L"
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  // padding: behv[1] == "L"? EdgeInsets.only(left:0.3):EdgeInsets.only(right:0.3),
                  child: Text(
                    // value.toString(),
                    behv[0] == "C"?d2.toString():value.toString(),
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ),
          );
        }
      });
    }
    print(datacell.length);
    return datacell;
  }
}
///////////////////////////////////////////////////////////////////////////////////////
