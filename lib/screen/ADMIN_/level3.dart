import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customappbar.dart';
import 'package:salesapp/components/selectDate.dart';

import 'package:salesapp/screen/ADMIN_/adminController.dart';
import 'package:salesapp/screen/ADMIN_/expandedDatatable.dart';
import 'package:salesapp/screen/ADMIN_/shrinkeddatatable.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelThree extends StatefulWidget {
  String hometileName;
  String level1tileName;
  String level2tileName;

  String old_filter_where_ids;
  String filter_id;
  List<String> filters;
  String reportelemet;
  LevelThree(
      {required this.reportelemet,
      required this.hometileName,
      required this.level1tileName,
      required this.level2tileName,
      required this.old_filter_where_ids,
      required this.filter_id,
      required this.filters});
  @override
  State<LevelThree> createState() {
    return _LevelThreeState();
  }
}

class _LevelThreeState extends State<LevelThree> {
  String? old_filter_where_ids;
  List<Map<String, dynamic>> tablejson = [];
  String? specialField;
  Widget? appBarTitle;
  DateTime currentDate = DateTime.now();
  bool qtyvisible = false;
  String? formattedDate;
  String? fromDate;
  String selected = "";
  String? toDate;
  String? crntDateFormat;
  Icon actionIcon = Icon(Icons.search);
  // List<bool> visible = [];
  // List<bool> isExpanded = [];
  late ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  List<String> listString = ["Main Heading", "level1", "level2"];
  List<String> listShrinkData = ["F1", "F2", "F3"];

  String searchkey = "";
  bool isSearch = false;
  bool datevisible = true;

  bool isSelected = true;
  bool buttonClicked = false;
  SelectDate selectD = SelectDate();
  List<Map<String, dynamic>> shrinkedData = [];
  List<Map<String, dynamic>> jsonList = [];
  String? titleName;
  var encoded;
  var decodd;
  var encodedShrinkdata;
  var decoddShrinked;
  String? dateFromShared;
  String? datetoShared;
  final jsondata = [
    {
      "rank": "0",
      "a": "TLN10_BillNo",
      "b": "TLN10_MRNo",
      "c": "TLN50_PatientName",
      "d": "CRY10_Amt",
      "e": "CRY10_Paid",
      "f": "CRY10_Bal",
      "g": "TLN10_Name",
    },
    {
      "rank": "1",
      "a": "G202204027",
      "b": "TJAA2",
      "c": "PRATHYEESH MAKRERI KANNUR",
      "d": "472.5",
      "e": "372.5",
      "f": "100",
      "g": "Anu",
    },
    {
      "rank": "1",
      "a": "G202204026",
      "b": "TJAA2",
      "c": "PRATHYEESH MAKRERI KANNUR",
      "d": "1697.5",
      "e": "1397.5",
      "f": "300",
      "g": "Graha",
    }
  ];

  getShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    decodd = prefs.getString("json");
  }

  setSharedPreftojsondata() async {
    //print("enterd into shared");
    encoded = json.encode(jsondata);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("encoded---$encoded");
    prefs.setString("json", encoded);
    // print("added to shred prefs");
  }

  _onSelectItem(int index, String reportType) {
    _selectedIndex.value = index;
    Navigator.of(context).pop(); // close the drawer
  }

  createShrinkedData() {
    shrinkedData.clear();
    // print("cleared---$shrinkedData");
    shrinkedData.add(jsondata[0]);
    shrinkedData.add(jsondata[jsondata.length - 1]);
    // print("shrinked data --${shrinkedData}");
    encodedShrinkdata = json.encode(shrinkedData);
  }

  // toggle(int i) {
  //   setState(() {
  //     isExpanded[i] = !isExpanded[i];
  //     visible[i] = !visible[i];
  //   });
  // }

  setList() {
    jsonList.clear();
    jsondata.map((jsonField) {
      jsonList.add(jsonField);
    }).toList();
    //print("json list--${jsonList}");
  }

///////////////////////////////////////////////////////////
  // Future _selectFromDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2020),
  //       lastDate: DateTime(currentDate.year + 1),
  //       builder: (BuildContext context, Widget? child) {
  //         return Theme(
  //             data: ThemeData.light().copyWith(
  //               colorScheme: ColorScheme.light()
  //                   .copyWith(primary: P_Settings.l3appbarColor),
  //             ),
  //             child: child!);
  //       });
  //   if (pickedDate != null) {
  //     setState(() {
  //       currentDate = pickedDate;
  //     });
  //   } else {
  //     print("please select date");
  //   }
  //   fromDate = DateFormat('dd-MM-yyyy').format(currentDate);
  //   fromDate =
  //       fromDate == null ? dateFromShared.toString() : fromDate.toString();

  //   toDate = toDate == null ? datetoShared.toString() : toDate.toString();

  //   Provider.of<Controller>(context, listen: false).setDate(fromDate!, toDate!);

  //   specialField = Provider.of<Controller>(context, listen: false).special;

  //   Provider.of<Controller>(context, listen: false).getSubCategoryReportList(
  //       specialField!,
  //       widget.filter_id,
  //       fromDate!,
  //       toDate!,
  //       widget.old_filter_where_ids,
  //       "level3");
  // }

/////////////////////////////////////////////////////////////////
  // Future _selectToDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2020),
  //       lastDate: DateTime(currentDate.year + 1),
  //       builder: (BuildContext context, Widget? child) {
  //         return Theme(
  //             data: ThemeData.light().copyWith(
  //               colorScheme: ColorScheme.light()
  //                   .copyWith(primary: P_Settings.l3appbarColor),
  //             ),
  //             child: child!);
  //       });
  //   if (pickedDate != null) {
  //     setState(() {
  //       currentDate = pickedDate;
  //     });
  //   } else {
  //     print("please select date");
  //   }
  //   toDate = DateFormat('dd-MM-yyyy').format(currentDate);
  //   fromDate =
  //       fromDate == null ? dateFromShared.toString() : fromDate.toString();

  //   toDate = toDate == null ? datetoShared.toString() : toDate.toString();

  //   Provider.of<Controller>(context, listen: false).setDate(fromDate!, toDate!);

  //   specialField = Provider.of<Controller>(context, listen: false).special;

  //   Provider.of<Controller>(context, listen: false).getSubCategoryReportList(
  //       specialField!,
  //       widget.filter_id,
  //       fromDate!,
  //       toDate!,
  //       widget.old_filter_where_ids,
  //       "level3");
  // }

/////////////////////////////////////////////////////////////////
  @override
  void initState() {
    //print("jsondata----$jsondata");
    super.initState();
    dateFromShared =
        Provider.of<AdminController>(context, listen: false).fromDate;
    datetoShared = Provider.of<AdminController>(context, listen: false).todate;
    crntDateFormat = DateFormat('dd-MM-yyyy').format(currentDate);
    specialField = Provider.of<AdminController>(context, listen: false).special;

    print(crntDateFormat);
    // Provider.of<Controller>(context, listen: false).getReportApi();

    // print("initstate");
    setSharedPreftojsondata();
    getShared();
    createShrinkedData();
    titleName = widget.hometileName +
        ' ' +
        '/' +
        ' ' +
        widget.level1tileName +
        ' ' +
        '/' +
        ' ' +
        widget.level2tileName;

    // isExpanded = List.generate(length, (index) => false);
    // visible = List.generate(length, (index) => true);
    // print("isExpanded---$isExpanded");
    // print("visible---$visible");
    selected = Provider.of<AdminController>(context, listen: false).special!;
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

    // for (var i = 0;
    //      i < Provider.of<Controller>(context, listen: false).getReportApi().length;
    //     i++) {
    //   // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];
    //   drawerOpts.add(Consumer<Controller>(builder: (context, value, child) {
    //     return ListTile(
    //         // leading: new Icon(d.icon),
    //         // title: new Text(
    //         //   value.ge[i],
    //         //   style: TextStyle(fontFamily: P_Font.kronaOne, fontSize: 17),
    //         // ),
    //         selected: i == _selectedIndex.value,
    //         onTap: () {
    //           // _onSelectItem(i, value.drawerItems[i]);
    //           // Navigator.push(
    //           //                 context,
    //           //                 MaterialPageRoute(builder: (context) => Level1Sample()),
    //           //               );
    //         });
    //   }));
    // }
    /////////////////////////////////////////////////////////////////////
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   // leading: IconButton(
        //   //     icon: Icon(Icons.arrow_back, color: Colors.white),
        //   //     onPressed: () {
        //   //       Navigator.of(context).pop();
        //   //       Navigator.popUntil(
        //   //           context, ModalRoute.withName("productdetailspage"));
        //   //     }),
        //   title: appBarTitle,
        //   // appBarTitle,
        //   actions: [
        //     IconButton(
        //       icon: actionIcon,
        //       onPressed: () {
        //         // toggle(i);
        //         setState(() {
        //           if (this.actionIcon.icon == Icons.search) {
        //             _controller.clear();
        //             this.actionIcon = Icon(Icons.close);
        //             this.appBarTitle = TextField(
        //                 controller: _controller,
        //                 style: const TextStyle(
        //                   color: Colors.white,
        //                 ),
        //                 decoration: const InputDecoration(
        //                   prefixIcon: Icon(Icons.search, color: Colors.white),
        //                   hintText: "Search...",
        //                   hintStyle: TextStyle(color: Colors.white),
        //                 ),
        //                 // onChanged: ((value) {
        //                 //   print(value);
        //                 //   onChangedValue(value);
        //                 // }),
        //                 cursorColor: Colors.black);
        //           } else {
        //             if (this.actionIcon.icon == Icons.close &&
        //                 _controller.text.isNotEmpty) {
        //               this.actionIcon = Icon(Icons.search);
        //               this.appBarTitle = Consumer<Controller>(
        //                   builder: (context, value, child) {
        //                 if (value.reportSubCategoryList != null &&
        //                     value.reportSubCategoryList.isNotEmpty) {
        //                   return Text(
        //                     value.reportSubCategoryList[0]["sg"],
        //                     style: TextStyle(fontSize: 16),
        //                   );
        //                 } else {
        //                   return Container();
        //                 }
        //               });
        //               // Provider.of<Controller>(context, listen: false)
        //               //     .setIssearch(false);
        //             } else {
        //               if (this.actionIcon.icon == Icons.close) {
        //                 print("closed");
        //                 _controller.clear();
        //                 this.actionIcon = Icon(Icons.search);
        //                 this.appBarTitle = Consumer<Controller>(
        //                     builder: (context, value, child) {
        //                   if (value.reportSubCategoryList != null &&
        //                       value.reportSubCategoryList.isNotEmpty) {
        //                     return Text(
        //                       value.reportSubCategoryList[0]["sg"],
        //                       style: TextStyle(fontSize: 16),
        //                     );
        //                   } else {
        //                     return Container();
        //                   }
        //                 });
        //               }
        //             }
        //           }
        //         });
        //       },
        //     ),
        //   ],
        // ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder:
                  (BuildContext context, int selectedValue, Widget? child) {
                return CustomAppbar(
                  title: " ",
                  level: 'level3',
                );
              }),
        ),

        ///////////////////////////////////////////////////////////////////
        // drawer: Drawer(
        //   child: new Column(
        //     children: <Widget>[
        //       Container(
        //         height: size.height * 0.2,
        //         color: P_Settings.color3,
        //       ),
        //       Column(children: drawerOpts)
        //     ],
        //   ),
        // ),
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
                                child: Icon(Icons.calendar_month),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Consumer<AdminController>(builder: (context, value, child) {
                      {
                        type = widget.reportelemet;
                        List<String> parts = type!.split(',');
                        type1 = parts[0].trim(); // prefix: "date"
                        type2 = parts[1].trim(); // prefix: "date"
                        type3 = parts[2].trim(); // prefix: "date"
                      }
                      {
                        return Container(
                          color: Colors.yellow,
                          // height: size.height * 0.27,
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
                                      // Row(
                                      //   children: [
                                      //     IconButton(
                                      //         onPressed: () {
                                      //           _selectToDate(context);
                                      //         },
                                      //         icon: Icon(Icons.calendar_month)),
                                      //     toDate == null
                                      //         ? InkWell(
                                      //             onTap: () {
                                      //               _selectToDate(context);
                                      //             },
                                      //             child: Text(
                                      //                 datetoShared.toString()))
                                      //         : InkWell(
                                      //             onTap: () {
                                      //               _selectToDate(context);
                                      //             },
                                      //             child:
                                      //                 Text(toDate.toString()))
                                      //   ],
                                      // ),
                                      type3 == "S"
                                          ? qtyvisible
                                              ? SizedBox(
                                                  width: size.width * 0.2,
                                                  child: IconButton(
                                                    icon: Icon(
                                                        Icons.arrow_upward,
                                                        color: P_Settings
                                                            .blue3),
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
                                                            .blue4),
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
                                                    height: size.height * 0.07,
                                                    width: size.width * 1,
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
                                                                    primary: selected ==
                                                                            value.specialelements[index][
                                                                                "value"]
                                                                        ? P_Settings
                                                                            .blue3
                                                                        : P_Settings
                                                                            .blue3,
                                                                    shadowColor:
                                                                        P_Settings
                                                                            .color4,
                                                                    minimumSize:
                                                                        Size(10,
                                                                            20),
                                                                    maximumSize:
                                                                        Size(10,
                                                                            20),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    specialField =
                                                                        value.specialelements[index]
                                                                            [
                                                                            "value"];
                                                                    selected = value
                                                                            .specialelements[index]
                                                                        [
                                                                        "value"];

                                                                    fromDate = fromDate ==
                                                                            null
                                                                        ? dateFromShared
                                                                            .toString()
                                                                        : fromDate
                                                                            .toString();

                                                                    toDate = toDate ==
                                                                            null
                                                                        ? datetoShared
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
                                                                        "level3");
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
              Container(
                width: double.infinity,
                color: P_Settings.dateviewColor,
                height: size.height * 0.05,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(titleName.toString())),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   color: P_Settings.dateviewColor,
              //   height: size.height * 0.05,
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: SingleChildScrollView(
              //             scrollDirection: Axis.horizontal,
              //             child: Text(titleName.toString())),
              //       ),
              //     ],
              //   ),
              // ),
              // Provider.of<Controller>(context, listen: false).isSearch &&
              //         Provider.of<Controller>(context, listen: false)
              //                 .l3newList
              //                 .length ==
              //             0
              //     ? Container(
              //         alignment: Alignment.center,
              //         height: size.height * 0.6,
              //         child: Text(
              //           "No data Found!!!",
              //           style: TextStyle(fontSize: 20),
              //         ),
              //       )
              //     :
              Consumer<AdminController>(builder: (context, value, child) {
                {
                  print("level3 report list${value.level3reportList.length}");

                  if (value.isLoading == true) {
                    return Container(
                      height: size.height * 0.6,
                      child: SpinKitPouringHourGlassRefined(
                          color: P_Settings.blue3),
                    );
                  }
                  if (value.isSearch && value.l3newList.length == 0) {
                    return Container(
                      alignment: Alignment.center,
                      height: size.height * 0.6,
                      child: const Text(
                        "No data Found!!!",
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }
                  if (value.isSearch && value.l3newList.length > 0) {
                    return Container(
                      // color: P_Settings.datatableColor,
                      height: size.height * 0.71,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.l3newList.length,
                          itemBuilder: (context, index) {
                            var jsonEncoded =
                                json.encode(value.l3newList[index]);
                            // Provider.of<Controller>(context, listen: false)
                            //     .datatableCreation(
                            //         jsonEncoded, "level3", "shrinked");
                            if (index < 0 || index >= value.l3newList.length) {
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
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,

                                            // title: Text("Alert Dialog Box"),
                                            content: Text("No more pages.."),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: P_Settings
                                                        .blue3),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text("ok"),
                                              ),
                                            ],
                                          ),
                                        );

                                        Provider.of<AdminController>(context,
                                                listen: false)
                                            .setSpecialField(specialField!);
                                      },
                                      title: Center(
                                        child: Text(
                                          value.l3newList[index].values
                                                      .elementAt(1) !=
                                                  null
                                              ? value.l3newList[index].values
                                                  .elementAt(1)
                                              : "",
                                          // style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      // subtitle:
                                      //     Center(child: Text('/report page flow')),
                                      trailing: IconButton(
                                          icon: Provider.of<AdminController>(
                                                      context,
                                                      listen: false)
                                                  .l3isExpanded[index]
                                              ? Icon(
                                                  Icons.arrow_upward,
                                                  size: 18,
                                                )
                                              : Icon(
                                                  Icons.arrow_downward,
                                                  // actionIcon.icon,
                                                  size: 18,
                                                ),
                                          onPressed: () {
                                            Provider.of<AdminController>(
                                                    context,
                                                    listen: false)
                                                .toggleExpansion(
                                                    index, "level3");
                                            Provider.of<AdminController>(
                                                    context,
                                                    listen: false)
                                                .toggleData(index, "level3");
                                            String batch_code = value
                                                .l3newList[index].values
                                                .elementAt(0);
                                            old_filter_where_ids =
                                                widget.old_filter_where_ids +
                                                    batch_code;

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
                                            Provider.of<AdminController>(
                                                        context,
                                                        listen: false)
                                                    .l3isExpanded[index]
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
                                                        "level3",
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
                                          .l3isExpanded[index]
                                      ? Consumer<AdminController>(
                                          builder: (context, value, child) {
                                            return Visibility(
                                                visible:
                                                    value.l3isExpanded[index],
                                                child: value.istabLoading
                                                    ? Container(
                                                        height: 40,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: P_Settings
                                                              .blue3,
                                                        ))
                                                    : ExpandedDatatable(
                                                        dedoded: index >= 0
                                                            ? value.l3listForTable[
                                                                index]
                                                            : null,
                                                        level: "level3",
                                                      )
                                                // : Container()
                                                );
                                          },
                                        )
                                      : Visibility(
                                          visible: Provider.of<AdminController>(
                                                  context,
                                                  listen: false)
                                              .l3visible[index],
                                          // child:Text("haiii")

                                          child: ShrinkedDatatable(
                                            decodd: jsonEncoded,
                                            level: "level3",
                                          ),
                                        ),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                  return Container(
                    // color: P_Settings.datatableColor,
                    height: size.height * 0.69,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.level3reportList.length,
                        itemBuilder: (context, index) {
                          var jsonEncoded =
                              json.encode(value.level3reportList[index]);
                          // Provider.of<Controller>(context, listen: false)
                          //     .datatableCreation(
                          //         jsonEncoded, "level3", "shrinked");
                          if (index < 0 ||
                              index >= value.level3reportList.length) {
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
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,

                                          // title: Text("Alert Dialog Box"),
                                          content: Text("No more pages.."),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: P_Settings
                                                      .blue3),
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text("ok"),
                                            ),
                                          ],
                                        ),
                                      );

                                      Provider.of<AdminController>(context,
                                              listen: false)
                                          .setSpecialField(specialField!);
                                    },
                                    title: Center(
                                      child: Text(
                                        value.isSearch
                                            ? value.l3newList[index].values
                                                .elementAt(1)
                                            : value.level3reportList[index]
                                                        .values
                                                        .elementAt(1) !=
                                                    null
                                                ? value.level3reportList[index]
                                                    .values
                                                    .elementAt(1)
                                                : "",
                                        // style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    // subtitle:
                                    //     Center(child: Text('/report page flow')),
                                    trailing: IconButton(
                                        icon: Provider.of<AdminController>(
                                                    context,
                                                    listen: false)
                                                .l3isExpanded[index]
                                            ? Icon(
                                                Icons.arrow_upward,
                                                size: 18,
                                              )
                                            : Icon(
                                                Icons.arrow_downward,
                                                // actionIcon.icon,
                                                size: 18,
                                              ),
                                        onPressed: () {
                                          Provider.of<AdminController>(context,
                                                  listen: false)
                                              .toggleExpansion(index, "level3");
                                          Provider.of<AdminController>(context,
                                                  listen: false)
                                              .toggleData(index, "level3");
                                          String batch_code = value
                                              .level3reportList[index].values
                                              .elementAt(0);
                                          old_filter_where_ids =
                                              widget.old_filter_where_ids +
                                                  batch_code;

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
                                                  .l3isExpanded[index]
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
                                                      "level3",
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
                                        .l3isExpanded[index]
                                    ? Consumer<AdminController>(
                                        builder: (context, value, child) {
                                          return Visibility(
                                              visible:
                                                  value.l3isExpanded[index],
                                              child: value.istabLoading
                                                  ? Container(
                                                      height: 40,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: P_Settings
                                                            .l3appbarColor,
                                                      ))
                                                  : ExpandedDatatable(
                                                      dedoded: index >= 0
                                                          ? value.l3listForTable[
                                                              index]
                                                          : null,
                                                      level: "level3",
                                                    )
                                              // : Container()
                                              );
                                        },
                                      )
                                    : Visibility(
                                        visible: Provider.of<AdminController>(
                                                context,
                                                listen: false)
                                            .l3visible[index],
                                        // child:Text("haiii")

                                        child: ShrinkedDatatable(
                                          decodd: jsonEncoded,
                                          level: "level3",
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

///////////////////////alert box for button click //////////////////////////////////////
