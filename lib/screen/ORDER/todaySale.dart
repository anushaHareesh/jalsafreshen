import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:salesapp/screen/ORDER/DateFinder.dart';
import 'package:salesapp/screen/historydataPopup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodaySale extends StatefulWidget {
  const TodaySale({Key? key}) : super(key: key);

  @override
  State<TodaySale> createState() => _TodaySaleState();
}

class _TodaySaleState extends State<TodaySale> {
  DateTime dateti = DateTime.now();
  HistoryPopup popup = HistoryPopup();
  String? formattedDate;
  String? todaydate;
  DateFind dateFind = DateFind();

  String? sid;
  String? cid;
  String? cancel_time;

  sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    cid = prefs.getString('cid');
    print("sid ......$sid");
    print("formattedDate...$formattedDate");
  }

/////////////////// bluetooth permission checking////////////////////
  // ///BluetoothConnection connection;
  // late BluetoothConnection connection;

  // connect(String address) async {
  //   try {
  //     connection = await BluetoothConnection.toAddress(address);
  //     print('Connected to the device');

  //     connection.input!.listen((Uint8List data) {
  //       //Data entry point
  //       print(ascii.decode(data));
  //     });
  //   } catch (exception) {
  //     print('Cannot connect, exception occured');
  //   }
  // }

  //     connection.input!.listen((Uint8List data) {
  //       //Data entry point
  //       print(ascii.decode(data));
  //     });
  //   } catch (exception) {
  //     print('Cannot connect, exception occured');
  //   }
  // }

  // checkPerm() async {
  //   print("blutooth connect");
  //   var blue = await Permission.bluetooth.status;
  //   print("gsdfsdf....$blue");
  //   if (blue.isDenied) {
  //     await Permission.bluetooth.request();
  //     print("blutooth connect  onnnn");
  //   }
  //   if (blue.isGranted) {
  //     await Permission.bluetooth.request();
  //     openAppSettings();

  //     //  print("request for permission");
  //   }
  //   if (blue.isLimited) {
  //     await Permission.bluetooth.request();
  //   }
  //   if (await Permission.bluetooth.status.isPermanentlyDenied) {
  //     await Permission.bluetooth.request();

  //     openAppSettings();
  //     print("blutooth connect  off");
  //   }
  // }

  @override
  void initState() {
    print("Hai");
    formattedDate = DateFormat('yyyy-MM-dd').format(dateti);
    todaydate = DateFormat('yyyy-MM-dd').format(dateti);

    sharedPref();
    // TODO: implement initState
    super.initState();
    print(
        "todaySalesList----${Provider.of<Controller>(context, listen: false).todaySalesList}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return SpinKitFadingCircle(
              color: P_Settings.wavecolor,
            );
          } else {
            if (value.todaySalesList.length == 0) {
              return Container(
                height: size.height * 0.7,
                width: double.infinity,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // ElevatedButton(
                        //     onPressed: () async {
                        //       await OrderAppDB.instance.backupDB();
                        //     },
                        //     child: Text("backup")),
                        // ElevatedButton(
                        //     onPressed: () async {
                        //       await OrderAppDB.instance.getDbPath();
                        //       await OrderAppDB.instance.restoreDB();
                        //     },
                        //     child: Text("restore")),

                        IconButton(
                            onPressed: () {
                              dateFind.selectDateFind(
                                  context, "from date", "sales");
                            },
                            icon: Icon(
                              Icons.calendar_month,
                              color: P_Settings.wavecolor,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            value.fromDate == null
                                ? todaydate.toString()
                                : value.fromDate.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       dateFind.selectDateFind(context, "to date");
                        //     },
                        //     icon: Icon(Icons.calendar_month)),
                        // Text(dateFind.toDate.toString()),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    Image.asset(
                      'asset/noData1.png',
                      height: size.height * 0.09,
                      fit: BoxFit.cover,
                      color: P_Settings.collection1,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      "No Sales!!!",
                      style: TextStyle(
                        fontSize: 18,
                        color: P_Settings.collection1,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // TextButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => PdfPreviewPage(
                        //             type: 'sales',
                        //           ),
                        //         ),
                        //       );
                        //       // SaleReport printer = SaleReport();
                        //       // printer.printSaleReport(value.todaySalesList);
                        //     },
                        //     child: Text(
                        //       "Print Report",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 15,
                        //           color: Colors.red),
                        //     )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       await OrderAppDB.instance.backupDB();
                            //     },
                            //     child: Text("backup")),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       await OrderAppDB.instance.getDbPath();
                            //       await OrderAppDB.instance.restoreDB();
                            //     },
                            //     child: Text("restore")),
                            IconButton(
                                onPressed: () {
                                  dateFind.selectDateFind(
                                      context, "from date", "sales");
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: P_Settings.wavecolor,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                value.fromDate == null
                                    ? todaydate.toString()
                                    : value.fromDate.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // IconButton(
                        //     onPressed: () {
                        //       dateFind.selectDateFind(context, "to date");
                        //     },
                        //     icon: Icon(Icons.calendar_month)),
                        // Text(dateFind.toDate.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.todaySalesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            children: [
                              GestureDetector(
                                // onTap: () {
                                //   Provider.of<Controller>(context,
                                //           listen: false)
                                //       .getSaleHistoryData('salesDetailTable',
                                //           "sales_id='${value.todaySalesList[index]["sales_id"]}'");
                                //   popup.buildPopupDialog(
                                //       context,
                                //       size,
                                //       value.todaySalesList[index]["sale_Num"],
                                //       value.todaySalesList[index]["Cus_id"],
                                //       "sales");
                                // },
                                child: Card(
                                    child: ListTile(
                                  tileColor:
                                      value.todaySalesList[index]["cancel"] == 1
                                          ? Color.fromARGB(255, 241, 164, 161)
                                          : Colors.grey[100],
                                  title: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              // "sbfjnsdbfjdsf dfjdbfjdf dfndjfxdfbxdjfbxdjfbd ndfdfs"
                                              value.todaySalesList[index]
                                                      ["cus_name"]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          // Icon(Icons),
                                          // SizedBox(
                                          //   width: size.width * 0.02,
                                          // ),
                                          Text(
                                            "Bill No : ",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          Text(
                                              value.todaySalesList[index]
                                                  ["sale_Num"],
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13)),
                                          Spacer(),

                                          InkWell(
                                              onTap: () async {
                                                String cancelled;
                                                if (value.todaySalesList[index]
                                                        ["cancel"] ==
                                                    1) {
                                                  cancelled = "cancelled";
                                                } else {
                                                  cancelled = "not cancelled";
                                                }
                                                List<Map<String, dynamic>>
                                                    result = await OrderAppDB
                                                        .instance
                                                        .printcurrentData(value
                                                                .todaySalesList[
                                                            index]["sales_id"]);
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .printSales(
                                                        cid!,
                                                        context,
                                                        value.todaySalesList[
                                                            index],
                                                        "",
                                                        cancelled);
                                              },
                                              child: Icon(Icons.print)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "No: Of Items : ",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          Text(
                                              "${value.todaySalesList[index]["count"].toString()}",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: size.height * 0.01,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Icon(
                                      //       Icons.person,
                                      //       color: Colors.green,
                                      //     ),
                                      //     SizedBox(
                                      //       width: size.width * 0.02,
                                      //     ),
                                      //     RichText(
                                      //       overflow: TextOverflow.clip,
                                      //       maxLines: 2,
                                      //       text: TextSpan(
                                      //         text:
                                      //             '${value.todaySalesList[index]["cus_name"]}',
                                      //         style: TextStyle(
                                      //             color: Colors.grey[700],
                                      //             fontWeight: FontWeight.bold,
                                      //             fontSize: 14),
                                      //       ),
                                      //     ),
                                      //     Text(" - "),
                                      //     Text(
                                      //       value.todaySalesList[index]
                                      //           ["Cus_id"],
                                      //       style: TextStyle(
                                      //           color: Colors.grey[700],
                                      //           fontWeight: FontWeight.bold,
                                      //           fontStyle: FontStyle.italic,
                                      //           fontSize: 14),
                                      //     ),
                                      //     Spacer(),
                                      //   ],
                                      // ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Icon(Icons.delete),
                                          value.todaySalesList[index]
                                                      ["cancel"] ==
                                                  1
                                              ? Container()
                                              : InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Colors.white,

                                                          // title: new Text("Alert!!"),
                                                          content: new Text(
                                                            "Cancel Bill No : ${value.todaySalesList[index]["sale_Num"]} ??",
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                          actions: <Widget>[
                                                            new ElevatedButton(
                                                              child: new Text(
                                                                  "OK"),
                                                              onPressed:
                                                                  () async {
                                                                String?
                                                                    gen_area =
                                                                    Provider.of<Controller>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .areaId;
                                                                print(
                                                                    "gen area----$gen_area");
                                                                String
                                                                    gen_condition;
                                                                if (gen_area !=
                                                                    null) {
                                                                  gen_condition =
                                                                      " and accountHeadsTable.area_id=$gen_area";
                                                                } else {
                                                                  gen_condition =
                                                                      " ";
                                                                }
                                                                cancel_time = DateFormat(
                                                                        'yyyy-MM-dd HH:mm:ss')
                                                                    .format(DateTime
                                                                        .now());

                                                                await OrderAppDB
                                                                    .instance
                                                                    .upadteCommonQuery(
                                                                        "salesMasterTable",
                                                                        "status = 0 , cancel = 1 , cancel_staff ='${sid}' , cancel_dateTime= '${cancel_time}' ",
                                                                        "sales_id='${value.todaySalesList[index]["sales_id"]}'");
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "Bill No : ${value.todaySalesList[index]["sale_Num"]} Cancelled",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_SHORT,
                                                                    gravity: ToastGravity
                                                                        .CENTER,
                                                                    timeInSecForIosWeb:
                                                                        1,
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        14.0);
                                                                List<String> s =
                                                                    cancel_time!
                                                                        .split(
                                                                            " ");
                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .todaySales(
                                                                        s[0],
                                                                        " ",
                                                                        "");
                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .dashboardSummery(
                                                                        sid!,
                                                                        formattedDate!,
                                                                        "",
                                                                        context);

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            new ElevatedButton(
                                                              child: new Text(
                                                                  "Cancel"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                        size: 18,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                          value.todaySalesList[index]
                                                      ["cancel"] ==
                                                  1
                                              ? Text(
                                                  "Cancelled",
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 11,
                                                      color: Colors.black),
                                                )
                                              : Container(),
                                          Row(
                                            children: [
                                              Text(
                                                "Total  :",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                "\u{20B9}${value.todaySalesList[index]["net_amt"].toStringAsFixed(2)}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
