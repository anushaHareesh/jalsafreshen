import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customPopup.dart';
import 'package:salesapp/components/customToast.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/autocomplete.dart';
import '0_dashnew.dart';

class CollectionPage extends StatefulWidget {
  String? os;
  String? sid;
  String? cuid;
  String? aid;
  CollectionPage({this.os, this.sid, this.cuid, this.aid});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  ValueNotifier<bool> visible = ValueNotifier(false);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime date = DateTime.now();
  String? gen_condition;
  String? formattedDate;
  bool amtVal = true;
  bool dscVal = true;
  CustomPopup popup = CustomPopup();
  // List<String> items = ["Cash receipt", "Google pay"];
  String? selected;
  // String? os;
  List s = [];

  TextEditingController amtController = TextEditingController();
  TextEditingController dscController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CustomToast tst = CustomToast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // shared();
    formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(date);
    s = formattedDate!.split(" ");
    print("jhsjahjs----${widget.cuid}");
    Provider.of<Controller>(context, listen: false)
        .fetchtotalcollectionFromTable(widget.cuid!);
    Provider.of<Controller>(context, listen: false)
        .selectSettings("set_code in('CL_UPLOAD_DIRECT')");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: P_Settings.wavecolor,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                    opaque: false, // set to false
                    pageBuilder: (_, __, ___) => Dashboard()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.home,color: Colors.white,),
            ),
          )
        ],
        title: Text(
          "COLLECTION",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        // reverse: true,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Consumer<Controller>(
                builder: (context, value, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Collection",
                      //   style: TextStyle(
                      //       color: P_Settings.wavecolor,
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // Divider(
                      //   thickness: 2,
                      // ),
                      // SizedBox(
                      //   height: size.height * 0.02,
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Series",
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Container(
                            width: size.width * 1,
                            height: size.height * 0.05,
                            alignment: Alignment.centerLeft,
                            color: P_Settings.collection,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.os.toString()),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text("Date", style: TextStyle(fontSize: 15)),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Container(
                            width: size.width * 1,
                            height: size.height * 0.05,
                            alignment: Alignment.centerLeft,
                            color: P_Settings.collection,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                formattedDate.toString(),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text("Transaction Mode * ",
                              style: TextStyle(fontSize: 15)),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          // SizedBox(
                          //   height: size.height * 0.01,
                          // ),
                          Container(
                            color: Colors.grey[200],
                            // height: size.height * 0.04,
                            child: DropdownButton<String>(
                              value: selected,
                              hint: Text("Select"),
                              isExpanded: true,
                              // autofocus: false,
                              underline: SizedBox(),
                              elevation: 0,
                              items: value.walletList
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item["waid"].toString(),
                                      child: Container(
                                        width: size.width * 0.5,
                                        child: Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Text(
                                              item["wname"].toString(),
                                              style: TextStyle(fontSize: 13),
                                            )),
                                      )))
                                  .toList(),
                              onChanged: (item) {
                                print("clicked");

                                if (item != null) {
                                  setState(() {
                                    selected = item;
                                  });
                                  print("se;ected---$item");
                                }
                              },

                              // disabledHint: Text(selected ?? "null"),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text("Amount *", style: TextStyle(fontSize: 15)),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Container(
                            color: P_Settings.collection,
                            child: TextFormField(
                                style: TextStyle(fontSize: 14),
                                controller: amtController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  
                                  border: InputBorder.none,
                                )),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text("Discount ", style: TextStyle(fontSize: 15)),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Container(
                            // height: size.height * 0.04,
                            // width: size.width * 0.9,
                            color: P_Settings.collection,
                            child: TextFormField(
                                style: TextStyle(fontSize: 14),
                                controller: dscController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                )),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text("Remarks", style: TextStyle(fontSize: 15)),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          SizedBox(
                            // width: size.width * 0.9,
                            child: TextField(
                              style: TextStyle(fontSize: 14),
                              controller: noteController,
                              minLines:
                                  2, // any number you need (It works as the rows for the textarea)
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                 focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 199, 198, 198),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 199, 198, 198),
                                width: 1.0,
                              ),
                            ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 20),
                                border: OutlineInputBorder(),
                                labelText: '',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Center(
                            child: Container(
                              width: size.width * 0.3,
                              height: size.height * 0.05,
                              child: ElevatedButton(
                                onPressed: () async {
                                  String os1 = "C" + "${widget.os}";
                                  int max = await OrderAppDB.instance
                                      .calculateMaxSeries('$os1',
                                          'collectionTable', 'rec_row_num');
                                  ;
                                  print("max value in collection....$max");
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  String? sid = await prefs.getString('sid');
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  print(
                                      "hjfhdfhn---${amtController.text}---${dscController.text}");
                                  //  double sum=double.parse( amtController.text)+double.parse( dscController.text);

                                  if (amtController.text.isEmpty &&
                                          dscController.text.isEmpty ||
                                      selected == null) {
                                    visible.value = true;
                                  } else {
                                    visible.value = false;
                                    await OrderAppDB.instance
                                        .insertCollectionTable(
                                            s[0],
                                            s[1],
                                            widget.cuid!,
                                            max,
                                            os1,
                                            selected!,
                                            amtController.text,
                                            dscController.text,
                                            noteController.text,
                                            widget.sid!,
                                            0,
                                            0);

                                    amtController.clear();
                                    dscController.clear();
                                    noteController.clear();
                                    selected = null;
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .fetchtotalcollectionFromTable(
                                            widget.cuid!);

                                    if (Provider.of<Controller>(context,
                                                listen: false)
                                            .settingsList1[0]["set_value"] ==
                                        "YES") {
                                      print("upload----");
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .uploadCollectionData(
                                              context, 0, "comomn popup");
                                    }
                                    print(
                                        "value.areaidFrompopup----${value.areaidFrompopup}");
                                    if (value.areaidFrompopup != null) {
                                      await Provider.of<Controller>(context,
                                              listen: false)
                                          .dashboardSummery(sid!, s[0],
                                              value.areaidFrompopup!, context);
                                    } else {
                                      await Provider.of<Controller>(context,
                                              listen: false)
                                          .dashboardSummery(
                                              sid!, s[0], "", context);
                                    }

                                    // Provider.of<Controller>(context,
                                    //         listen: false)
                                    //     .mainDashtileValues(sid!, s[0]);
                                    // Provider.of<Controller>(context,
                                    //         listen: false)
                                    //     .mainDashAmounts(sid, s[0]);
                                    String? gen_area = Provider.of<Controller>(
                                            context,
                                            listen: false)
                                        .areaidFrompopup;
                                    if (gen_area != null) {
                                      gen_condition =
                                          " and accountHeadsTable.area_id=$gen_area";
                                    } else {
                                      gen_condition = " ";
                                    }
                                    await Provider.of<Controller>(context,
                                            listen: false)
                                        .todayCollection(s[0], gen_condition!);
                                    tst.toast("Saved");
                                  }
                                },
                                child: Text('Save'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Center(
                            child: ValueListenableBuilder(
                                valueListenable: visible,
                                builder: (BuildContext context, bool v,
                                    Widget? child) {
                                  print("value===${visible.value}");
                                  return Visibility(
                                    visible: v,
                                    child: Text(
                                      "Please fill corresponding fields!!!",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: value.fetchcollectionList.length == 0
                            ? false
                            : true,
                        child: Column(
                          children: [
                            Consumer<Controller>(
                              builder: (context, value, child) {
                                return Container(
                                  // color: P_Settings.collection,
                                  height: size.height * 0.7,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: value.fetchcollectionList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        // height: size.height * 0.1,
                                        child: Card(
                                          // shape: RoundedRectangleBorder(
                                          //   side: BorderSide(
                                          //       color: value.fetchcollectionList[
                                          //                       index]
                                          //                   ['rec_cancel'] ==
                                          //               1
                                          //           ? Colors.red
                                          //           : Colors.grey),
                                          //   borderRadius:
                                          //       BorderRadius.circular(15.0),
                                          // ),
                                          color: Colors.grey[100],
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                child: Icon(
                                                  Icons.reviews,
                                                  size: 16,
                                                ),
                                                backgroundColor: P_Settings
                                                    .roundedButtonColor,
                                              ),
                                              title: Row(
                                                children: [
                                                  Text(
                                                    value.fetchcollectionList[
                                                        index]['rec_date'],
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Text(
                                                    value.fetchcollectionList[
                                                        index]['rec_time'],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Text(
                                                  "\u{20B9}${value.fetchcollectionList[index]['rec_amount'].toStringAsFixed(2)}"),
                                              trailing: IconButton(
                                                icon: Icon(Icons.delete,
                                                    size: 16,
                                                    color: value.fetchcollectionList[
                                                                    index][
                                                                'rec_cancel'] ==
                                                            1
                                                        ? Colors.grey
                                                        : Colors.red[400]),
                                                onPressed:
                                                    value.fetchcollectionList[
                                                                    index][
                                                                "rec_cancel"] ==
                                                            1
                                                        ? null
                                                        : () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext context) => popup.buildPopupDialog(
                                                                    widget
                                                                        .cuid!,
                                                                    context,
                                                                    "Cancel Collection?",
                                                                    "collection",
                                                                    value.fetchcollectionList[
                                                                            index]
                                                                        [
                                                                        "rec_row_num"],
                                                                    widget.sid!,
                                                                    s[0],
                                                                    widget
                                                                        .aid!));
                                                          },
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
