import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesapp/screen/ADMIN_/myService.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminController extends ChangeNotifier {
  String? old_filter_where_ids;
  // String? filter_id;
  String? tilName;
  bool? isLoading;
  String? reportType;
  bool istabLoading = false;

  bool backButtnClicked = false;
  String urlgolabl = Globaldata.apiglobal;
  List<Map<String, dynamic>> reportList = [];
  List<Map<String, dynamic>> specialelements = [];
  List<Map<String, dynamic>> reportCategoryList = [];
  List<Map<String, dynamic>> level1reportList = [];
  List<Map<String, dynamic>> level2reportList = [];
  List<Map<String, dynamic>> level3reportList = [];
  List<Map<String, dynamic>> level4reportList = [];
  List<dynamic> l1listForTable = [];
  List<dynamic> l2listForTable = [];
  List<dynamic> l3listForTable = [];

  List<bool> l1visible = [];
  List<bool> l1isExpanded = [];
  List<bool> l2visible = [];
  List<bool> l2isExpanded = [];
  List<bool> l3visible = [];
  List<bool> l3isExpanded = [];
  List<bool> l4visible = [];
  List<bool> l4isExpanded = [];

  List<bool> l1Shrinkvisible = [];
  List<bool> l2Shrinkvisible = [];

  List<bool> l3Shrinkvisible = [];

  String? fromDate;
  String? todate;
  String? searchkey;
  List<Map<String, dynamic>> l1newList = [];
  List<Map<String, dynamic>> l2newList = [];
  List<Map<String, dynamic>> l3newList = [];

  bool isSearch = false;
  List<Map<String, dynamic>> mapTabledata = [];
  List<String> tableColumn = [];
  List<String>? colName;
  // List<Map<String, dynamic>> newMp = [];
  Map<String, dynamic> valueMap = {};
  Map<String, dynamic> totMap = {};

  List<String>? rowName;
  String? special;
  List<String> expndtableColumn = [];
  Map<String, dynamic> expndvalueMap = {};
  List<String>? expndcolName;
  int i = 0;
  List<String>? expndrowName;
  List<Map<String, dynamic>> expndmapTabledata = [];
  List<Map<String, dynamic>> newMp = [];
  List<DataCell> datacell = [];
  List<Map<String, dynamic>> resultCopy = [];
  List<Map<String, dynamic>> tableJson = [];
  List<Map> mapJsondata = [];
  var l3length;
  var l1length;
  var l2length;
  var l4length;

  /////////////////////////////////////////////////////
  getCategoryReport(
    String cid,
  ) async {
    try {
      Map body = {
        'cid': cid,
      };
      isLoading = true;
      // notifyListeners();
      Uri url = Uri.parse("$urlgolabl/report_group_list.php");
      http.Response response = await http.post(
        url,
        body: body,
      );
      reportCategoryList.clear();
      var map = jsonDecode(response.body);
      //print(map);
      for (var item in map) {
        reportCategoryList.add(item);
      }
      if (reportCategoryList.length > 0) {
        reportType = reportCategoryList[0]["rg_name"];
      }
      isLoading = false;
      notifyListeners();

      print("report Category ${reportCategoryList}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////////////////////////////////
  getCategoryReportList(String rg_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cid = prefs.getString("cid");
    print("rg id---${rg_id}---$cid");

    try {
      Uri url = Uri.parse("$urlgolabl/reports_list.php");
      var body = {
        "rg_id": rg_id,
        "cid": cid,
      };
      isLoading = true;
      // notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );
      var map = jsonDecode(response.body);

      reportList.clear();
      // print(map);
      for (var item in map) {
        reportList.add(item);
        // notifyListeners();
      }
      isLoading = false;
      notifyListeners();
      // print("report date type ...........${reportList}");
      // print("report list${reportList}");
      final jsonData = reportList[0]['special_element2'];

      // final jsonData ='[[{"label":"QTY","value":"1"},{"label":"BATCH COST","value":"B.batch_cost"}],[{"label":"QTY","value":"1"},{"label":"BATCH COST","value":"B.batch_cost"}]]';
      // print("${reportList[3]}");
      final parsedJson = jsonDecode(jsonData);
      print("parsed json--$parsedJson");
      specialelements.clear();
      for (var i in parsedJson) {
        specialelements.add(i);
      }
      print("report list---${reportList}");
      // print("reportList[4]['report_elements']---${reportList[3]}");

      print("specialelements.............${specialelements}");
      //  print("special_element2.........................${reportList[0]['special_element2']}");
      // resultCopy=reportList;
      notifyListeners();
    } catch (e) {
      // print(e);
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////////////
  Future getSubCategoryReportList(
      String special_field,
      String filter_id,
      String fromdate,
      String tilldate,
      String old_filter_where_ids,
      String level) async {
    // resultCopy.clear();
    print(
        "special_field2---${special_field}  filter_id---${filter_id} fromdate---${fromdate} tilldate---${tilldate} old_filter_where_ids----${old_filter_where_ids}");
    try {
      Uri url = Uri.parse("$urlgolabl/filters_list.php");
      var body = {
        "special_field": special_field,
        "filter_id": filter_id,
        "fromdate": fromdate,
        "tilldate": tilldate,
        "old_filter_where_ids": old_filter_where_ids,
      };
      isLoading = true;
      notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );

      isLoading = false;
      notifyListeners();
      if (level == "level1") {
        var map1 = jsonDecode(response.body);
        print("map1----${map1}");
        level1reportList.clear();
        for (var item in map1) {
          level1reportList.add(item);
        }
        l1length = level1reportList.length;
        print("l1 report list -----${level1reportList}");
        // print("l1length---${l1length}");
        l1isExpanded = List.generate(l1length, (index) => false);
        l1visible = List.generate(l1length, (index) => true);

        l1Shrinkvisible = List.generate(l1length, (index) => true);

        // listForTable =List.generate(length, (index) =>  );
      }
      if (level == "level2") {
        var map2 = jsonDecode(response.body);
        print("dfbjdjzfn${level1reportList.length}");
        level2reportList.clear();
        for (var item in map2) {
          level2reportList.add(item);
        }
        l2length = level2reportList.length;
        print("l2 report list -----${level2reportList}");
        l2isExpanded = List.generate(l2length, (index) => false);
        l2visible = List.generate(l2length, (index) => true);

        l2Shrinkvisible = List.generate(l1length, (index) => true);

        // print("isExpanded---$isExpanded");
        // print("visible---$visible");
        // print("report list ---- ${level2reportList}");
      }
      if (level == "level3") {
        var map3 = jsonDecode(response.body);

        level3reportList.clear();
        for (var item in map3) {
          level3reportList.add(item);
        }
        l3length = level3reportList.length;
        l3isExpanded = List.generate(l3length, (index) => false);
        l3visible = List.generate(l3length, (index) => true);

        l3Shrinkvisible = List.generate(l1length, (index) => true);

        // print("isExpanded---$isExpanded");
        // print("visible---$visible");
        print("report list ---- ${level3reportList}");
      }
      if (level == "level4") {
        var map4 = jsonDecode(response.body);

        level4reportList.clear();
        for (var item in map4) {
          level4reportList.add(item);
        }
        l4length = level4reportList.length;
        l4isExpanded = List.generate(l4length, (index) => false);
        l4visible = List.generate(l4length, (index) => true);
        // print("isExpanded---$isExpanded");
        // print("visible---$visible");
        print("report list ---- ${level4reportList}");
      }

      // resultCopy=reportSubCategoryList;

      notifyListeners();
    } catch (e) {
      // print(e);
      return null;
    }
  }

  ////////////////////////////////////////////////////////clear///
  Future getExpansionJson(
      String special_field,
      String filter_id,
      String fromdate,
      String tilldate,
      String old_filter_where_ids,
      String special_field2,
      String level,
      int index) async {
    try {
      print(
          "special_field---${special_field} special_field2---${special_field2} filter_id---${filter_id} fromdate---${fromdate} tilldate---${tilldate} old_filter_where_ids----${old_filter_where_ids}");
      Uri url = Uri.parse("$urlgolabl/filter_tile_expansion.php");
      var body = {
        "special_field": special_field,
        "filter_id": filter_id,
        "fromdate": fromdate,
        "tilldate": tilldate,
        "old_filter_where_ids": old_filter_where_ids,
        "special_field2": special_field2,
      };
      istabLoading = true;
      notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );
      expndmapTabledata.clear();
      tableJson.clear();
      expndtableColumn.clear();
      // listForTable!.clear();
      istabLoading = false;
      notifyListeners();

      var map = jsonDecode(response.body);
      for (var item in map) {
        tableJson.add(item);
      }

      expndmapTabledata = tableJson;
      print("expndmapTabledata----${expndmapTabledata}");

      if (expndmapTabledata != null) {
        expndmapTabledata[0].forEach((key, value) {
          expndtableColumn.add(key);
        });
      }
      List<dynamic> copy = [];
      calculateSum();
      expndmapTabledata.add(totMap);
      print("aftr total expndmapTabledata----${expndmapTabledata}");
      // List listTable = [];
      if (level == "level1") {
        if (l1isExpanded[index]) {
          l1listForTable.insert(index, expndmapTabledata);
        }
      }
      if (level == "level2") {
        if (l2isExpanded[index]) {
          l2listForTable.insert(index, expndmapTabledata);
        }
      }
      if (level == "level3") {
        if (l3isExpanded[index]) {
          l3listForTable.insert(index, expndmapTabledata);
        }
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////////////////////////////////////////
  clearlevelsreportList(String level) {
    if (level == "level1") {
      level1reportList.clear();
    }
    if (level == "level2") {
      level2reportList.clear();
      print("level2 aftr clear---${level2reportList.length}");
    }
    if (level == "level3") {
      level3reportList.clear();
    }
    if (level == "level4") {
      level4reportList.clear();
    }
    notifyListeners();
    // reportSubCategoryList.clear();
    // notifyListeners();///
  }

  navigatorClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  toggleData(int i, String level) {
    if (level == "level1") {
      l1isExpanded[i] = !l1isExpanded[i];
      l1visible[i] = !l1visible[i];
    }
    if (level == "level2") {
      l2isExpanded[i] = !l2isExpanded[i];
      l2visible[i] = !l2visible[i];
    }
    if (level == "level3") {
      l3isExpanded[i] = !l3isExpanded[i];
      l3visible[i] = !l3visible[i];
    }
    if (level == "level4") {
      l4isExpanded[i] = !l4isExpanded[i];
      l4visible[i] = !l4visible[i];
    }

    notifyListeners();
  }

  toggleExpansion(int index, String level) {
    if (level == "level1") {
      for (int i = 0; i < l1isExpanded.length; i++) {
        if (l1isExpanded[index] != l1isExpanded[i] && l1isExpanded[i]) {
          l1isExpanded[i] = !l1isExpanded[i];
          l1visible[i] = !l1visible[i];
        }
      }
    }
    if (level == "level2") {
      for (int i = 0; i < l2isExpanded.length; i++) {
        if (l2isExpanded[index] != l2isExpanded[i] && l2isExpanded[i]) {
          l2isExpanded[i] = !l2isExpanded[i];
          l2visible[i] = !l2visible[i];
        }
      }
    }
    if (level == "level3") {
      for (int i = 0; i < l3isExpanded.length; i++) {
        if (l3isExpanded[index] != l3isExpanded[i] && l3isExpanded[i]) {
          l3isExpanded[i] = !l3isExpanded[i];
          l3visible[i] = !l3visible[i];
        }
      }
    }
    // if (level == "level4") {
    //   l4isExpanded[i] = !l4isExpanded[i];
    //   l4visible[i] = !l4visible[i];
    // }

    notifyListeners();
  }

  setDate(String fromD, String toD) {
    fromDate = fromD;
    todate = toD;
    notifyListeners();
  }

  setSearchKey(String searchKey) {
    print("searchKey----${searchKey}");

    searchkey = searchkey;
    notifyListeners();
  }

  setisSearch(bool isSearch) {
    isSearch = isSearch;
    print("isSerarch Controller----${isSearch}");
    notifyListeners();
  }

  newListClear(String level) {
    if (level == "level1") {
      l1newList.clear();
    }
    if (level == "level2") {
      l2newList.clear();
    }
    if (level == "level3") {
      l3newList.clear();
    }
    notifyListeners();
  }

  searchProcess(String level) {
    print("isSearch process----${isSearch}");
    print("searchKey process----${searchkey}");

    if (level == "level1" && isSearch == true) {
      l1newList = level1reportList
          .where((cat) => cat.values
              .elementAt(1)
              .toUpperCase()
              .contains(searchkey!.toUpperCase()))
          .toList();
      // print("nw list---$newList");
      notifyListeners();
    } else if (level == "level1" && isSearch == false) {
      l1newList.clear();
      notifyListeners();
    }
    if (level == "level2" && isSearch == true) {
      l2newList = level2reportList
          .where((cat) => cat.values
              .elementAt(1)
              .toUpperCase()
              .contains(searchkey!.toUpperCase()))
          .toList();
      // print("nw list---$newList");
      notifyListeners();
    } else if (level == "level2" && isSearch == false) {
      l2newList.clear();
      notifyListeners();
    }
    if (level == "level3" && isSearch == true) {
      l3newList = level3reportList
          .where((cat) => cat.values
              .elementAt(1)
              .toUpperCase()
              .contains(searchkey!.toUpperCase()))
          .toList();
      // print("nw list---$newList");
      notifyListeners();
    } else if (level == "level3" && isSearch == false) {
      l3newList.clear();
      notifyListeners();
    }
  }

  setSpecialField(String specField) {
    special = specField;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////

  // datatableCreation(var jsonData, String level, String type) {
  //   mapTabledata.clear();
  //   newMp.clear();
  //   tableColumn.clear();
  //   valueMap.clear();
  //   if (jsonData != null) {
  //     mapTabledata = json.decode(jsonData);
  //     // print("json data----${jsondata}");
  //   } else {
  //     // print("null");
  //   }
  //   if (type == "shrinked") {
  //     if (level == "level1") {
  //       mapTabledata.remove("sg");
  //       mapTabledata.remove("acc_rowid");
  //     } else if (level == "level2") {
  //       mapTabledata.remove("cat_id");
  //       mapTabledata.remove("cat_name");
  //     } else if (level == "level3") {
  //       mapTabledata.remove("batch_code");
  //       mapTabledata.remove("batch_name");
  //     }
  //   }

  // print("map after deletion${mapTabledata} ");
  // print("mapTabledata---${mapTabledata}");
  // mapTabledata.forEach((key, value) {
  //   tableColumn.add(key);
  //   valueMap[key] = value;
  // });
  // newMp.add(valueMap);
  // print("tableColumn---${tableColumn}");
  // print("valueMap---${valueMap}");
  // print("newMp---${newMp}");
  // }

  /////////////////////////////////////////////
  // expandedtableCreation(
  //   var jsonData,
  // ) {
  //   expndmapTabledata.clear();
  //   expndtableColumn.clear();
  //   if (jsonData != null) {
  //     expndmapTabledata = jsonData;
  //     // print("json data----${jsonData}");
  //   }
  //   print("expndmapTabledata---${expndmapTabledata}");

  //   if (expndmapTabledata != null) {
  //     expndmapTabledata[0].forEach((key, value) {
  //       expndtableColumn.add(key);
  //     });
  //   }
  //   calculateSum();
  //   expndmapTabledata.add(totMap);
  // }

  calculateSum() {
    for (var i = 0; i < expndtableColumn.length; i++) {
      double sum = 0;
      for (var item in expndmapTabledata) {
        item.forEach((key, value) {
          if (key == expndtableColumn[i]) {
            if (expndtableColumn[i][2] == "Y") {
              // value.toStringAsFixed(2);
              print("value---- $value");
              if (value == null) {
                print("null value");
                value = "0";
              }
              double valueStored = double.parse(value);
              sum = sum + valueStored;
              String d2 = sum.toStringAsFixed(2);
              print("double porecision----${d2}");
              double modSum = double.parse(d2);
              print("modified-----${modSum}");

              // Print("modified-----${modSum}");
              totMap[expndtableColumn[i]] = d2;
            } else {
              // sum='';
              totMap[expndtableColumn[i]] = "0";
            }
          }
        });
      }
      notifyListeners();
    }
  }
}
