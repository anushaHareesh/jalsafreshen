import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/screen/ADMIN_/adminController.dart';
import 'package:provider/provider.dart';

class DateFind {
  DateTime currentDate = DateTime.now();
  // String? formattedDate;
  String? fromDate;
  String? toDate;
  String? crntDateFormat;
  String? specialField;
  String? gen_condition;

  Future selectDateFind(
      BuildContext context, String dateType, String ordType) async {
    String? gen_area = Provider.of<Controller>(context, listen: false).areaId;
    print("gen area----$gen_area");
    if (gen_area != null) {
      gen_condition = " and accountHeadsTable.area_id=$gen_area";
    } else {
      gen_condition = " ";
    }
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(currentDate.year + 1),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme:
                    ColorScheme.light().copyWith(primary: P_Settings.wavecolor),
              ),
              child: child!);
        });
    if (pickedDate != null) {
      // setState(() {
      currentDate = pickedDate;
      // });
    } else {
      print("please select date");
    }
    if (dateType == "from date") {
      fromDate = DateFormat('yyyy-MM-dd').format(currentDate);
    }
    if (dateType == "to date") {
      toDate = DateFormat('yyyy-MM-dd').format(currentDate);
    }
    print("fromdate-----$fromDate---$toDate");
    // Provider.of<Controller>(context, listen: false).fromDate=fromDate;
    if (fromDate != null) {
      Provider.of<Controller>(context, listen: false).setDate(fromDate!, "");
    }
    toDate = toDate == null
        ? Provider.of<Controller>(context, listen: false).todate.toString()
        : toDate.toString();
    if (ordType == "sale order") {
      Provider.of<Controller>(context, listen: false)
          .todayOrder(fromDate!, gen_condition!);
    }
    if (ordType == "sales") {
      Provider.of<Controller>(context, listen: false)
          .todaySales(fromDate!, gen_condition!, "");
    }
    if (ordType == "collection") {
      Provider.of<Controller>(context, listen: false)
          .todayCollection(fromDate!, gen_condition!);
    }
  }
}
