import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/screen/SALES/print_report.dart';

import 'package:salesapp/screen/SALES/report_view.dart';

import 'package:provider/provider.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatefulWidget {
  String type;
  List<Map<String, dynamic>>? list;
  PdfPreviewPage({required this.type, this.list});
  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  DateTime now = DateTime.now();
  ReportView view = ReportView();
  List<Map<String, dynamic>> list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => EnqHome(
                //               type: "return from quataion",
                //             )));
              },
              icon: Icon(Icons.arrow_back)),
          actions: [
            Consumer<Controller>(
              builder: (context, value, child) {
                return IconButton(
                    onPressed: () {
                      if (widget.type == "sale order") {
                        list = widget.list!;
                      } else if (widget.type == "sales") {
                        list = value.todaySalesList;
                      } else if (widget.type == "collection") {
                        list = value.todayCollectionList;
                      }
                      PrintReport printer = PrintReport();
                      printer.printReport(list, widget.type);
                    },
                    icon: Icon(Icons.print));
              },
            )
          ],
          backgroundColor: P_Settings.wavecolor,
          title: Text('PDF Preview ${widget.type}'),
        ),
        body: Consumer<Controller>(
          builder: (context, value, child) {
            if (widget.type == "sale order") {
              list = widget.list!;
            } else if (widget.type == "sales") {
              list = value.todaySalesList;
            } else if (widget.type == "collection") {
              list = value.todayCollectionList;
            }
            print("jhdjdf------$list");
            if (value.isLoading) {
              return CircularProgressIndicator();
            } else {
              return PdfPreview(
                  useActions: false,
                  build: (context) => view.generate(list, widget.type));
            }
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
      backgroundColor: Colors.white,

          // title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to exit from this app'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
}
