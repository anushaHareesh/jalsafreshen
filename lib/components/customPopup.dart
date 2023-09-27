import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:provider/provider.dart';

class CustomPopup {
  String? gen_condition;

  Widget buildPopupDialog(String cuid, BuildContext context, String content,
      String type, int rowNum, String userId, String date, String aid) {
    String? gen_area =
        Provider.of<Controller>(context, listen: false).areaidFrompopup;
    print("content type........${content.runtimeType}");
    if (gen_area != null) {
      gen_condition = " and accountHeadsTable.area_id=$gen_area";
    } else {
      gen_condition = " ";
    }
    return AlertDialog(
      backgroundColor: Colors.white,

      // title: const Text('Popup example'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${content}"),
        ],
      ),
      actions: <Widget>[
         ElevatedButton(
          onPressed: () async {
           
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            print("hfzsdhfu----$aid");
            if (type == "exit") {
              exit(0);
            }
            if (type == "collection") {
              await OrderAppDB.instance.upadteCommonQuery(
                  "collectionTable", "rec_cancel='1'", "rec_row_num=$rowNum");
              Provider.of<Controller>(context, listen: false)
                  .dashboardSummery(userId, date, aid, context);
              Provider.of<Controller>(context, listen: false)
                  .todayCollection(date, gen_condition!);
              Provider.of<Controller>(context, listen: false)
                  .fetchtotalcollectionFromTable(cuid);
            }
            if (type == "remark") {
              print("hai........   ");
              await OrderAppDB.instance.upadteCommonQuery(
                  "remarksTable", "rem_cancel='1'", "rem_row_num=$rowNum");
              Provider.of<Controller>(context, listen: false)
                  .dashboardSummery(userId, date, aid, context);
              Provider.of<Controller>(context, listen: false)
                  .fetchremarkFromTable(cuid);
            }
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: Text('Ok'),
        ),
      ],
    );
  }
}
