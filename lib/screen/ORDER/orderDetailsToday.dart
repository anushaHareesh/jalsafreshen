// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:provider/provider.dart';

class OrderDetailsToday extends StatefulWidget {
  const OrderDetailsToday({Key? key}) : super(key: key);

  @override
  State<OrderDetailsToday> createState() => _OrderDetailsTodayState();
}

class _OrderDetailsTodayState extends State<OrderDetailsToday> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<Controller>(
          builder: (context, value, child) {
            return Container(
              width: size.width * 0.98,
              child: DataTable(
                // horizontalMargin: 0,
                headingRowHeight: 20,
                dataRowHeight: 23,
                dataRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                columnSpacing: 0,
                border: TableBorder.all(
                    width: 1, color: Color.fromARGB(255, 226, 220, 220)),
                columns: getColumns(value.tableHistorydataColumn),
                rows: getRowss(value.historydataList),
              ),
            );
          },
        ),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    print("columns---${columns}");
    String behv;
    String colsName;
    return columns.map((String column) {
      return DataColumn(
        label: Container(
          width: 70,
          child: Text(
            column,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
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
        cells: getCelle(row),
      );
    }).toList();
  }
/////////////////////////////////////////////

  List<DataCell> getCelle(Map<String, dynamic> data) {
    List<DataCell> datacell = [];
    data.forEach((key, value) {
      datacell.add(
        DataCell(
          Container(
            width: 70,
            alignment: Alignment.center,
            child: Text(
              value.toString(),
              style: TextStyle(
                fontSize: 12,
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
