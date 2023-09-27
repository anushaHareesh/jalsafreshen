import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customappbar.dart';
import 'package:salesapp/components/selectDate.dart';
import 'package:salesapp/screen/ADMIN_/adminController.dart';
import 'package:salesapp/screen/ADMIN_/expandedDatatable.dart';
import 'package:salesapp/screen/ADMIN_/level2.dart';
import 'package:salesapp/screen/ADMIN_/shrinkeddatatable.dart';

import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LevelOne extends StatefulWidget {
  String old_filter_where_ids;
  String filter_id;
  String tilName;
  List<String> filters;
  String reportelements;
  LevelOne(
      {required this.reportelements,
      required this.old_filter_where_ids,
      required this.filter_id,
      required this.tilName,
      required this.filters});

  @override
  State<LevelOne> createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOne> {
  String? specialField;
  Widget? appBarTitle;
  DateTime currentDate = DateTime.now();
  bool qtyvisible = false;
  String? formattedDate;
  String? fromDate;
  String? toDate;
  String selected = "";

  String? crntDateFormat;
  Icon actionIcon = const Icon(Icons.search);
  var encodedTablejson;
  // List<bool> visible = [];
  // List<bool> isExpanded = [];
  late ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  List<String> listString = ["Main Heading", "level1", "level2"];
  List<String> listShrinkData = ["F1", "F2", "F3"];
  String? old_filter_where_ids;
  String? filter1;
  // String searchkey = "";
  // bool isSearch = false;
  bool datevisible = true;
  SelectDate selectD = SelectDate();
  bool isSelected = true;
  bool buttonClicked = false;
  List<Map<String, dynamic>> tablejson = [];
  List<Map<String, dynamic>> shrinkedData = [];
  List<Map<String, dynamic>> jsonList = [];
  var encoded;
  var decodd;
  var encodedShrinkdata;
  var decoddShrinked;

  // String? dateFromShared;
  // String? datetoShared;
  getShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    decodd = prefs.getString("json");
  }

  _onSelectItem(int index, String reportType) {
    _selectedIndex.value = index;
    // Navigator.of(context).pop(); // close the drawer
  }

  createShrinkedData() {
    shrinkedData.clear();
    // print("cleared---$shrinkedData");
    // shrinkedData.add(jsondata[0]);
    // shrinkedData.add(jsondata[jsondata.length - 1]);
    // print("shrinked data --${shrinkedData}");
    encodedShrinkdata = json.encode(shrinkedData);
  }

  setList() {
    // jsonList.clear();
    // jsondata.map((jsonField) {
    //   jsonList.add(jsonField);
    // }).toList();
    // //print("json list--${jsonList}");
  }

///////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
  @override
  void initState() {
    //print("jsondata----$jsondata");
    super.initState();
    print(
        "from date from initstate---${Provider.of<AdminController>(context, listen: false).fromDate}");
    // dateFromShared = Provider.of<Controller>(context, listen: false).fromDate;
    // datetoShared = Provider.of<Controller>(context, listen: false).todate;

    // crntDateFormat = DateFormat('dd-MM-yyyy').format(currentDate);
    print(crntDateFormat);

    // setSharedPreftojsondata();
    getShared();
    createShrinkedData();
    selected = "1";
    // Provider.of<Controller>(context, listen: false).listForTable.length =
    //     Provider.of<Controller>(context, listen: false).level1reportList.length;
    // print(
    //     "Provider.of<Controller>(context, listen: false).listForTable.length--${Provider.of<Controller>(context, listen: false).listForTable.length}");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    List<Widget> drawerOpts = [];
    String? specialList;
    String? newlist;
    String? type;
    String? type1;
    String? type2;
    String? type3;

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder:
                  (BuildContext context, int selectedValue, Widget? child) {
                return CustomAppbar(
                  // title: "",
                  title: widget.tilName,
                  level: 'level1',
                );
              }),
        ),

        ///////////////////////////////////////////////////////////////////

        body: InteractiveViewer(
          child: Column(
            children: [
              // Text(widget._draweItems[_selectedIndex].title),
              buttonClicked
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ConstrainedBox(
                            constraints: new BoxConstraints(
                              minHeight: 20.0,
                              minWidth: 80.0,
                            ),
                            child: SizedBox.shrink(
                              child: InkWell(
                                onTap: (() {
                                  // print("Icon button --${buttonClicked}");
                                  setState(() {
                                    buttonClicked = false;
                                  });
                                }),
                                child: const Icon(Icons.calendar_month),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Consumer<AdminController>(builder: (context, value, child) {
                      {
                        print("helloo");
                        type = widget.reportelements.toString();
                        // value.reportList[4]["report_elements"].toString();
                        print("type..............$type");
                        List<String> parts = type!.split(',');
                        type1 = parts[0].trim();
                        type2 = parts[1].trim();
                        type3 = parts[2].trim();
                        // prefix: "date"
                      }
                      {
                        return Container(
                          color: Colors.yellow,
                          child: Container(
                            height: size.height * 0.14,
                            color: P_Settings.dateviewColor,
                            child: Column(
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          width: size.width * 0.1,
                                        ),
                                      ),
                                      type1 == "F"
                                          ? Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      selectD.selectDate(
                                                          context,
                                                          "level1",
                                                          widget.filter_id,
                                                          widget
                                                              .old_filter_where_ids,
                                                          "from date");
                                                    },
                                                    icon: const Icon(
                                                        Icons.calendar_month)),
                                                selectD.fromDate == null
                                                    ? InkWell(
                                                        onTap: (() {
                                                          selectD.selectDate(
                                                              context,
                                                              "level1",
                                                              widget.filter_id,
                                                              widget
                                                                  .old_filter_where_ids,
                                                              "from date");
                                                        }),
                                                        child: Text(Provider.of<
                                                                    AdminController>(
                                                                context,
                                                                listen: false)
                                                            .fromDate
                                                            .toString()))
                                                    : InkWell(
                                                        onTap: () {
                                                          selectD.selectDate(
                                                              context,
                                                              "level1",
                                                              widget.filter_id,
                                                              widget
                                                                  .old_filter_where_ids,
                                                              "from date");
                                                        },
                                                        child: Text(selectD
                                                            .fromDate
                                                            .toString()))
                                              ],
                                            )
                                          : Row(
                                              children: [],
                                            ),
                                      type2 == "T"
                                          ? Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      selectD.selectDate(
                                                          context,
                                                          "level1",
                                                          widget.filter_id,
                                                          widget
                                                              .old_filter_where_ids,
                                                          "to date");
                                                    },
                                                    icon: const Icon(
                                                        Icons.calendar_month)),
                                                selectD.fromDate == null
                                                    ? InkWell(
                                                        onTap: (() {
                                                          selectD.selectDate(
                                                              context,
                                                              "level1",
                                                              widget.filter_id,
                                                              widget
                                                                  .old_filter_where_ids,
                                                              "to date");
                                                        }),
                                                        child: Text(Provider.of<
                                                                    AdminController>(
                                                                context,
                                                                listen: false)
                                                            .todate
                                                            .toString()))
                                                    : InkWell(
                                                        onTap: () {
                                                          selectD.selectDate(
                                                              context,
                                                              "level1",
                                                              widget.filter_id,
                                                              widget
                                                                  .old_filter_where_ids,
                                                              "to date");
                                                        },
                                                        child: Text(
                                                          selectD.toDate
                                                              .toString(),
                                                        ),
                                                      ),
                                              ],
                                            )
                                          : Row(
                                              children: [],
                                            ),
                                      type3 == "S"
                                          ? qtyvisible
                                              ? SizedBox(
                                                  width: size.width * 0.2,
                                                  child: IconButton(
                                                    icon: Icon(
                                                        Icons.arrow_upward,
                                                        color: P_Settings
                                                            .l1appbarColor),
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyvisible = false;
                                                      });
                                                    },
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: size.width * 0.2,
                                                  child: IconButton(
                                                    icon: Icon(
                                                        Icons.arrow_downward,
                                                        color: P_Settings
                                                            .l1appbarColor),
                                                    onPressed: () {
                                                      setState(() {
                                                        qtyvisible = true;
                                                      });
                                                    },
                                                  ),
                                                )
                                          : Text("")
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: qtyvisible,
                                  child: type3 == "S"
                                      ? Row(
                                          children: [
                                            Consumer<AdminController>(builder:
                                                (context, value, child) {
                                              {
                                                return Flexible(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    // color: P_Settings.datatableColor,
                                                    height: size.height * 0.07,
                                                    width: size.width * 1.2,
                                                    child: Row(
                                                      children: [
                                                        ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          physics:
                                                              const PageScrollPhysics(),
                                                          itemCount: value
                                                              .specialelements
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: SizedBox(
                                                                width:
                                                                    size.width *
                                                                        0.3,
                                                                // height: size.height*0.001,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    // shape: StadiumBorder(),

                                                                    primary: selected ==
                                                                            value.specialelements[index][
                                                                                "value"]
                                                                        ? P_Settings
                                                                            .color4
                                                                        : P_Settings
                                                                            .color4,
                                                                    shadowColor:
                                                                        P_Settings
                                                                            .color4,
                                                                    // minimumSize:
                                                                    //     Size(100, 100),
                                                                    // maximumSize:
                                                                    //     Size(100, 100),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    fromDate = fromDate ==
                                                                            null
                                                                        ? Provider.of<AdminController>(context, listen: false)
                                                                            .fromDate
                                                                            .toString()
                                                                        : fromDate
                                                                            .toString();

                                                                    toDate = toDate ==
                                                                            null
                                                                        ? Provider.of<AdminController>(context, listen: false)
                                                                            .todate
                                                                            .toString()
                                                                        : toDate
                                                                            .toString();

                                                                    Provider.of<AdminController>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .setDate(
                                                                            fromDate!,
                                                                            toDate!);

                                                                    specialField =
                                                                        value.specialelements[index]
                                                                            [
                                                                            "value"];

                                                                    selected = value
                                                                            .specialelements[index]
                                                                        [
                                                                        "value"];
                                                                    Provider.of<AdminController>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .setSpecialField(
                                                                            specialField!);
                                                                    Provider.of<AdminController>(context, listen: false).getSubCategoryReportList(
                                                                        specialField!,
                                                                        widget
                                                                            .filter_id,
                                                                        fromDate!,
                                                                        toDate!,
                                                                        widget
                                                                            .old_filter_where_ids,
                                                                        "level1");
                                                                  },
                                                                  child: Text(
                                                                    value.specialelements[
                                                                            index]
                                                                        [
                                                                        "label"],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            })
                                          ],
                                        )
                                      : Text(""),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }),

              // Provider.of<Controller>(context, listen: false).isSearch &&
              //         Provider.of<Controller>(context, listen: false)
              //                 .l1newList
              //                 .length ==
              //             0
              //     ? Container(
              //         alignment: Alignment.center,
              //         height: size.height * 0.6,
              //         child: const Text(
              //           "No data Found!!!",
              //           style: const TextStyle(fontSize: 20),
              //         ),
              //       )
              //     :
              Consumer<AdminController>(builder: (context, value, child) {
                {
                  print("level1 report list${value.level1reportList.length}");

                  if (value.isLoading == true) {
                    return Container(
                      height: size.height * 0.6,
                      child: SpinKitPouringHourGlassRefined(
                          color: P_Settings.l1appbarColor),
                    );
                  }
                  if (value.isSearch && value.l1newList.length == 0) {
                     print("inside search newlist");
                    return Container(
                      alignment: Alignment.center,
                      height: size.height * 0.6,
                      child: const Text(
                        "No data Found!!!",
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }
                  if (value.isSearch && value.l1newList.length > 0) {
                    print("inside search");
                    return Container(
                      height: size.height * 0.71,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.l1newList.length,
                          itemBuilder: (context, index) {
                            var jsonEncoded =
                                json.encode(value.l1newList[index]);

                            print("jsonEncoded---${jsonEncoded}");

                            // if (index < 0 ||
                            //     index >= value.level1reportList.length) {
                            //   return const Offstage();
                            // }
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Ink(
                                    decoration: BoxDecoration(
                                      color: P_Settings.l1datatablecolor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        print("special field--${specialField}");
                                        specialField = specialField == null
                                            ? "1"
                                            : specialField.toString();
                                        fromDate = fromDate == null
                                            ? Provider.of<AdminController>(
                                                    context,
                                                    listen: false)
                                                .fromDate
                                                .toString()
                                            : fromDate.toString();

                                        toDate = toDate == null
                                            ? Provider.of<AdminController>(
                                                    context,
                                                    listen: false)
                                                .todate
                                                .toString()
                                            : toDate.toString();

                                        Provider.of<AdminController>(context,
                                                listen: false)
                                            .setDate(fromDate!, toDate!);

                                        filter1 = widget.filters[1].trim();
                                        print(
                                            "level1 filtersss ..............$filter1");
                                        String acc_row_id = value
                                            .l1newList[index].values
                                            .elementAt(0);
                                        old_filter_where_ids =
                                            widget.old_filter_where_ids +
                                                acc_row_id +
                                                ",";
                                        print(
                                            "old_filter_where_ids--${old_filter_where_ids}");
                                        Provider.of<AdminController>(context,
                                                listen: false)
                                            .setSpecialField(specialField!);
                                        Provider.of<AdminController>(context,
                                                listen: false)
                                            .getSubCategoryReportList(
                                                specialField!,
                                                filter1!,
                                                fromDate!,
                                                toDate!,
                                                old_filter_where_ids!,
                                                "level2");
                                        Provider.of<AdminController>(context,
                                                listen: false)
                                            .l2listForTable
                                            .clear();
                                        Provider.of<AdminController>(context,
                                                listen: false)
                                            .isSearch = false;
                                        String tileName = value
                                            .l1newList[index].values
                                            .elementAt(1);
                                        Provider.of<AdminController>(context,
                                                listen: false)
                                            .newListClear("level1");

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LevelTwo(
                                                    reportelement:
                                                        widget.reportelements,
                                                    hometileName:
                                                        widget.tilName,
                                                    level1tileName: tileName,
                                                    old_filter_where_ids:
                                                        old_filter_where_ids!,
                                                    filter_id: filter1!,
                                                    tile: widget.tilName,
                                                    filters: widget.filters,
                                                  )),
                                        );
                                      },
                                      title: Center(
                                        child: Text(
                                          value.l1newList[index].values
                                                      .elementAt(1) !=
                                                  null
                                              ? value.l1newList[index].values
                                                  .elementAt(1)
                                              : "",
                                          // style: TextStyle(fontSize: 12),
                                        ), 
                                      ),
                                      // subtitle:
                                      //     Center(child: Text('/report page flow')),
                                      trailing: IconButton(
                                          color: P_Settings.l1datatablecolor,
                                          icon: Provider.of<AdminController>(
                                                      context,
                                                      listen: false)
                                                  .l1isExpanded[index]
                                              ? const Icon(
                                                  Icons.arrow_upward,
                                                  size: 18,
                                                )
                                              : const Icon(
                                                  Icons.arrow_downward,
                                                  // actionIcon.icon,
                                                  size: 18,
                                                ),
                                          onPressed: () {
                                            Provider.of<AdminController>(
                                                    context,
                                                    listen: false)
                                                .toggleExpansion(
                                                    index, "level1");
                                            Provider.of<AdminController>(
                                                    context,
                                                    listen: false)
                                                .toggleData(index, "level1");
                                            String acc_row_id = value
                                                .l1newList[index].values
                                                .elementAt(0);
                                            old_filter_where_ids =
                                                widget.old_filter_where_ids +
                                                    acc_row_id;

                                            // print(
                                            //     "acc_rowid---${acc_row_id}");
                                            specialField = specialField == null
                                                ? "1"
                                                : specialField.toString();
                                            fromDate = fromDate == null
                                                ? Provider.of<AdminController>(
                                                        context,
                                                        listen: false)
                                                    .fromDate
                                                    .toString()
                                                : fromDate.toString();

                                            toDate = toDate == null
                                                ? Provider.of<AdminController>(
                                                        context,
                                                        listen: false)
                                                    .todate
                                                    .toString()
                                                : toDate.toString();
                                            print(
                                                "visiblejjjjjj---${Provider.of<AdminController>(context, listen: false).l1visible[index]}");
                                            Provider.of<AdminController>(
                                                        context,
                                                        listen: false)
                                                    .l1isExpanded[index]
                                                ? Provider.of<AdminController>(
                                                        context,
                                                        listen: false)
                                                    .getExpansionJson(
                                                        specialField!,
                                                        widget.filter_id,
                                                        fromDate!,
                                                        toDate!,
                                                        old_filter_where_ids!,
                                                        '',
                                                        "level1",
                                                        index)
                                                : null;
                                            tablejson =
                                                Provider.of<AdminController>(
                                                        context,
                                                        listen: false)
                                                    .expndmapTabledata;

                                            print("tablejson --${tablejson}");

                                            print(
                                                "tablejson length---${tablejson.length}");
                                          }),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.004),

                                  // Consumer<Controller>(
                                  //     builder: (context, value, child) {
                                  //   return Container(
                                  //     child: Text(value.listForTable.isEmpty
                                  //         ? "null"
                                  //         : value.listForTable[index]
                                  //             .toString()),
                                  //   );
                                  // })
                                  Provider.of<AdminController>(context,
                                              listen: false)
                                          .l1isExpanded[index]
                                      ? Consumer<AdminController>(
                                          builder: (context, value, child) {
                                            return Visibility(
                                                visible:
                                                    value.l1isExpanded[index],
                                                child: value.istabLoading
                                                    ? Container(
                                                        height: 40,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: P_Settings
                                                              .l1appbarColor,
                                                        ))
                                                    : ExpandedDatatable(
                                                        dedoded: index >= 0
                                                            ? value.l1listForTable[
                                                                index]
                                                            : null,
                                                        level: "level1",
                                                      )
                                                // : Container()
                                                );
                                          },
                                        )
                                      : Visibility(
                                          visible: Provider.of<AdminController>(
                                                  context,
                                                  listen: false)
                                              .l1visible[index],
                                          // child:Text("haiii")

                                          child: ShrinkedDatatable(
                                            decodd: jsonEncoded,
                                            level: "level1",
                                          ),
                                        ),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                  return Container(
                    height: size.height * 0.71,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.level1reportList.length,
                        itemBuilder: (context, index) {
                          print(
                              "level1reportList---${value.level1reportList[index]}");
                          var jsonEncoded =
                              json.encode(value.level1reportList[index]);

                          print("jsonEncoded---${jsonEncoded}");

                          if (index < 0 ||
                              index >= value.level1reportList.length) {
                            return const Offstage();
                          }
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Ink(
                                  decoration: BoxDecoration(
                                    color: P_Settings.blue3,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      print("special field--${specialField}");
                                      specialField = specialField == null
                                          ? "1"
                                          : specialField.toString();
                                      fromDate = fromDate == null
                                          ? Provider.of<AdminController>(
                                                  context,
                                                  listen: false)
                                              .fromDate
                                              .toString()
                                          : fromDate.toString();

                                      toDate = toDate == null
                                          ? Provider.of<AdminController>(
                                                  context,
                                                  listen: false)
                                              .todate
                                              .toString()
                                          : toDate.toString();

                                      Provider.of<AdminController>(context,
                                              listen: false)
                                          .setDate(fromDate!, toDate!);

                                      filter1 = widget.filters[1].trim();
                                      print(
                                          "level1 filtersss ..............$filter1");
                                      String acc_row_id = value
                                          .level1reportList[index].values
                                          .elementAt(0);
                                      old_filter_where_ids =
                                          widget.old_filter_where_ids +
                                              acc_row_id +
                                              ",";
                                      print(
                                          "old_filter_where_ids--${old_filter_where_ids}");
                                      Provider.of<AdminController>(context,
                                              listen: false)
                                          .setSpecialField(specialField!);
                                      Provider.of<AdminController>(context,
                                              listen: false)
                                          .getSubCategoryReportList(
                                              specialField!,
                                              filter1!,
                                              fromDate!,
                                              toDate!,
                                              old_filter_where_ids!,
                                              "level2");
                                      Provider.of<AdminController>(context,
                                              listen: false)
                                          .l2listForTable
                                          .clear();
                                      Provider.of<AdminController>(context,
                                              listen: false)
                                          .isSearch = false;
                                      String tileName = value
                                          .level1reportList[index].values
                                          .elementAt(1);
                                      Provider.of<AdminController>(context,
                                              listen: false)
                                          .newListClear("level1");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LevelTwo(
                                                  reportelement:
                                                      widget.reportelements,
                                                  hometileName: widget.tilName,
                                                  level1tileName: tileName,
                                                  old_filter_where_ids:
                                                      old_filter_where_ids!,
                                                  filter_id: filter1!,
                                                  tile: widget.tilName,
                                                  filters: widget.filters,
                                                )),
                                      );
                                    },
                                    title: Center(
                                      child: Text(
                                        value.isSearch
                                            ? value.l1newList[index].values
                                                .elementAt(1)
                                            : value.level1reportList[index]
                                                        .values
                                                        .elementAt(1) !=
                                                    null
                                                ? value.level1reportList[index]
                                                    .values
                                                    .elementAt(1)
                                                : "",
                                        // style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    // subtitle:
                                    //     Center(child: Text('/report page flow')),
                                    trailing: IconButton(
                                        color: P_Settings.l1appbarColor,
                                        icon: Provider.of<AdminController>(
                                                    context,
                                                    listen: false)
                                                .l1isExpanded[index]
                                            ? const Icon(
                                                Icons.arrow_upward,
                                                size: 18,
                                              )
                                            : const Icon(
                                                Icons.arrow_downward,
                                                // actionIcon.icon,
                                                size: 18,
                                              ),
                                        onPressed: () {
                                          Provider.of<AdminController>(context,
                                                  listen: false)
                                              .toggleExpansion(index, "level1");
                                          Provider.of<AdminController>(context,
                                                  listen: false)
                                              .toggleData(index, "level1");
                                          String acc_row_id = value
                                              .level1reportList[index].values
                                              .elementAt(0);
                                          old_filter_where_ids =
                                              widget.old_filter_where_ids +
                                                  acc_row_id;

                                          // print(
                                          //     "acc_rowid---${acc_row_id}");
                                          specialField = specialField == null
                                              ? "1"
                                              : specialField.toString();
                                          fromDate = fromDate == null
                                              ? Provider.of<AdminController>(
                                                      context,
                                                      listen: false)
                                                  .fromDate
                                                  .toString()
                                              : fromDate.toString();

                                          toDate = toDate == null
                                              ? Provider.of<AdminController>(
                                                      context,
                                                      listen: false)
                                                  .todate
                                                  .toString()
                                              : toDate.toString();
                                          print(
                                              "visiblejjjjjj---${Provider.of<AdminController>(context, listen: false).l1visible[index]}");
                                          Provider.of<AdminController>(context,
                                                      listen: false)
                                                  .l1isExpanded[index]
                                              ? Provider.of<AdminController>(
                                                      context,
                                                      listen: false)
                                                  .getExpansionJson(
                                                      specialField!,
                                                      widget.filter_id,
                                                      fromDate!,
                                                      toDate!,
                                                      old_filter_where_ids!,
                                                      '',
                                                      "level1",
                                                      index)
                                              : null;
                                          tablejson =
                                              Provider.of<AdminController>(
                                                      context,
                                                      listen: false)
                                                  .expndmapTabledata;

                                          print("tablejson --${tablejson}");

                                          print(
                                              "tablejson length---${tablejson.length}");
                                        }),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.004),
                                Provider.of<AdminController>(context,
                                            listen: false)
                                        .l1isExpanded[index]
                                    ? Consumer<AdminController>(
                                        builder: (context, value, child) {
                                          return Visibility(
                                              visible:
                                                  value.l1isExpanded[index],
                                              child: value.istabLoading
                                                  ? Container(
                                                      height: 40,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: P_Settings
                                                            .l1appbarColor,
                                                      ))
                                                  : ExpandedDatatable(
                                                      dedoded: value
                                                          .expndmapTabledata,
                                                      // value.l1listForTable.length!=0 && value.l1listForTable !=null||value.l1listForTable.isNotEmpty
                                                      //     ? value.l1listForTable[
                                                      //         index]
                                                      //     : null ,
                                                      level: "level1",
                                                    ));
                                        },
                                      )
                                    : Visibility(
                                        visible: Provider.of<AdminController>(
                                                context,
                                                listen: false)
                                            .l1visible[index],
                                        // child:Text("haiii")

                                        child: ShrinkedDatatable(
                                          decodd: jsonEncoded,
                                          level: "level1",
                                        ),
                                      ),
                              ],
                            ),
                          );
                        }),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////
