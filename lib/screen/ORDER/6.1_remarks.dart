import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customPopup.dart';
import 'package:salesapp/components/customToast.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:provider/provider.dart';

class RemarkPage extends StatefulWidget {
  String cus_id;
  String ser;
  String sid;
  String aid;
  RemarkPage(
      {required this.cus_id,
      required this.ser,
      required this.sid,
      required this.aid});

  @override
  State<RemarkPage> createState() => _RemarkPageState();
}

class _RemarkPageState extends State<RemarkPage> {
  TextEditingController remarkController = TextEditingController();
  TextEditingController remarkController1 = TextEditingController();
  CustomToast tost = CustomToast();
  DateTime now = DateTime.now();
  String? date;
  List s = [];
  bool colorlist = false;
  CustomPopup popup = CustomPopup();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false)
        .selectSettings("set_code in('RM_UPLOAD_DIRECT')");
    date = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    s = date!.split(" ");
    Provider.of<Controller>(context, listen: false)
        .fetchremarkFromTable(widget.cus_id);
    print("date...${date}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         await OrderAppDB.instance
        //             .deleteFromTableCommonQuery("remarksTable", "");
        //       },
        //       icon: Icon(Icons.delete))
        // ],
      ),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Consumer<Controller>(
            builder: (context, value, child) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Remarks",
                        style: TextStyle(
                            color: P_Settings.wavecolor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date"),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width: size.width * 0.9,
                                color: P_Settings.collection,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    date.toString(),
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text("Remarks", style: TextStyle(fontSize: 15)),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: SizedBox(
                                width: size.width * 0.9,
                                child: TextField(
                                  controller: remarkController,
                                  minLines:
                                      3, // any number you need (It works as the rows for the textarea)
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: remarkController.clear,
                                        icon: Icon(
                                          Icons.clear,
                                          size: 18,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 40, horizontal: 20),
                                      border: OutlineInputBorder(),
                                      labelText: '',
                                      hintText: 'Type here...'),
                                  onChanged: (value) {
                                    value = remarkController.text;
                                    print(
                                        "object......${remarkController.text}");
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Container(
                                width: size.width * 0.9,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    // primary: P_Settings.roundedButtonColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    if (remarkController.text != null ||
                                        remarkController.text.isNotEmpty) {
                                      String os1 = "M" + "${widget.ser}";
                                      int max = await OrderAppDB.instance
                                          .getMaxCommonQuery('remarksTable',
                                              'rem_row_num', " ");
                                      // int max = await OrderAppDB.instance
                                      //     .('$os1',
                                      //         'remarksTable', 'rem_row_num');
                                      print("jhjdfmax---$max");

                                      await OrderAppDB.instance
                                          .insertremarkTable(
                                              s[0],
                                              s[1],
                                              widget.cus_id,
                                              widget.ser,
                                              remarkController.text,
                                              widget.sid,
                                              max,
                                              0,
                                              0);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .fetchremarkFromTable(widget.cus_id);
                                      remarkController.clear();
                                      if (value.areaidFrompopup != null) {
                                        await Provider.of<Controller>(context,
                                                listen: false)
                                            .dashboardSummery(
                                                widget.sid,
                                                s[0],
                                                value.areaidFrompopup!,
                                                context);
                                      } else {
                                        await Provider.of<Controller>(context,
                                                listen: false)
                                            .dashboardSummery(
                                                widget.sid, s[0], "", context);
                                      }
                                      if (Provider.of<Controller>(context,
                                                  listen: false)
                                              .settingsList1[0]["set_value"] ==
                                          "YES") {
                                        print("upload----");
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .uploadRemarks(
                                                context, 0, "comomn popup");
                                      }
                                      tost.toast("success");
                                    }
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<Controller>(
                        builder: (context, value, child) {
                          return Container(
                            // color: P_Settings.collection,
                            height: size.height * 0.7,
                            child: ListView.builder(
                              itemCount: value.remarkList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Dismissible(
                                    key: ObjectKey([index]),
                                    onDismissed:
                                        (DismissDirection direction) async {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        print("Delete");
                                        setState(() {
                                          OrderAppDB.instance
                                              .deleteFromTableCommonQuery(
                                                  "remarksTable",
                                                  "rem_row_num='${value.remarkList[index]["rem_row_num"]}'");
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .fetchremarkFromTable(
                                                  widget.cus_id);
                                        });
                                      }
                                    },
                                    child: Card(
                                      color: Colors.grey[100],
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child: Icon(
                                            Icons.reviews,
                                            size: 16,
                                          ),
                                          backgroundColor:
                                              P_Settings.roundedButtonColor,
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                value.remarkList[index]
                                                        ['rem_text']
                                                    .toString(),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),

                                            /////////////////////////////////////////////
                                          ],
                                        ),
                                        trailing: Container(
                                          width: size.width * 0.2,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: IconButton(
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () {
                                                    remarkController1.clear();
                                                    showDialog(
                                                      context: context,
                                                      builder: (ctx) =>
                                                          AlertDialog(
      backgroundColor: Colors.white,

                                                        content: TextField(
                                                          controller:
                                                              remarkController1,
                                                          minLines:
                                                              3, // any number you need (It works as the rows for the textarea)
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          maxLines: null,
                                                          decoration:
                                                              InputDecoration(
                                                            suffixIcon:
                                                                IconButton(
                                                              onPressed:
                                                                  remarkController1
                                                                      .clear,
                                                              icon: Icon(
                                                                Icons.clear,
                                                                size: 18,
                                                              ),
                                                            ),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            40,
                                                                        horizontal:
                                                                            20),
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                          onChanged: (value) {
                                                            value =
                                                                remarkController1
                                                                    .text;
                                                          },
                                                        ),
                                                        actions: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        primary:
                                                                            P_Settings.wavecolor),
                                                                onPressed:
                                                                    () async {
                                                                  colorlist =
                                                                      true;
                                                                  await OrderAppDB
                                                                      .instance
                                                                      .upadteCommonQuery(
                                                                          "remarksTable",
                                                                          "rem_text='${remarkController1.text}'",
                                                                          "rem_row_num='${value.remarkList[index]["rem_row_num"]}'");
                                                                  Provider.of<Controller>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .fetchremarkFromTable(
                                                                          widget
                                                                              .cus_id);
                                                                  Navigator.of(
                                                                          ctx)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    "Edit"),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    size.width *
                                                                        0.01,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete,
                                                    color: value.remarkList[
                                                                    index][
                                                                'rem_cancel'] ==
                                                            1
                                                        ? Colors.grey
                                                        : Colors.red[400]),
                                                onPressed:
                                                    value.remarkList[index][
                                                                'rem_cancel'] ==
                                                            1
                                                        ? null
                                                        : () {
                                                            remarkController1
                                                                .clear();
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext context) => popup.buildPopupDialog(
                                                                    widget
                                                                        .cus_id,
                                                                    context,
                                                                    "Do you want to cancel the Remark?",
                                                                    "remark",
                                                                    value.remarkList[
                                                                            index]
                                                                        [
                                                                        "rem_row_num"],
                                                                    widget.sid,
                                                                    s[0],
                                                                    widget
                                                                        .aid));
                                                          },
                                              ),
                                            ],
                                          ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
