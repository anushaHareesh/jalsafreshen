import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/screen/ORDER/DateFinder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayCollection extends StatefulWidget {
  const TodayCollection({Key? key}) : super(key: key);

  @override
  State<TodayCollection> createState() => _TodayCollectionState();
}

class _TodayCollectionState extends State<TodayCollection> {
  DateTime dateti = DateTime.now();
  String? formattedDate;
  String? todaydate;

  DateFind dateFind = DateFind();

  String? sid;
  sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    print("sid ......$sid");
    print("formattedDate...$formattedDate");
  }

  @override
  void initState() {
    print("Hai");
    formattedDate = DateFormat('yyyy-MM-dd').format(dateti);
    todaydate = DateFormat('yyyy-MM-dd').format(dateti);

    sharedPref();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.iscollLoading) {
            return SpinKitFadingCircle(
              color: P_Settings.wavecolor,
            );
          } else {
            if (value.todayCollectionList.length == 0) {
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
                        IconButton(
                            onPressed: () {
                              dateFind.selectDateFind(
                                  context, "from date", "collection");
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
                      "No Collections!!!",
                      style: TextStyle(
                        fontSize: 17,
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
                        //             type: 'collection',
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
                          children: [
                            IconButton(
                                onPressed: () {
                                  dateFind.selectDateFind(
                                      context, "from date", "collection");
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     IconButton(
                  //         onPressed: () {
                  //           dateFind.selectDateFind(
                  //               context, "from date", "collection");
                  //         },
                  //         icon: Icon(
                  //           Icons.calendar_month,
                  //           color: P_Settings.wavecolor,
                  //         )),
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 10.0),
                  //       child: Text(
                  //         value.fromDate == null
                  //             ? todaydate.toString()
                  //             : value.fromDate.toString(),
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.grey[700],
                  //         ),
                  //       ),
                  //     ),
                  //     // IconButton(
                  //     //     onPressed: () {
                  //     //       dateFind.selectDateFind(context, "to date");
                  //     //     },
                  //     //     icon: Icon(Icons.calendar_month)),
                  //     // Text(dateFind.toDate.toString()),
                  //   ],
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.todayCollectionList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Card(
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    "asset/collection.png",
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                                title: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        // "svdbns ghhv bhjbhb bdnsd sd sbnd jfhdjf bsz dbnzsd znsd nzsd zsnd zs ndzsdn",
                                        "${value.todayCollectionList[index]['cus_name'].toString()} ",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ),
                                    Text(
                                      " - ${value.todayCollectionList[index]['rec_cusid'].toString()}",
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 11),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Amount :",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          " \u{20B9}${value.todayCollectionList[index]['rec_amount'].toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(child: Text("${value.todayCollectionList[index]['rec_note'].toString()}",))
                                        // RichText(
                                        //   overflow: TextOverflow.ellipsis,
                                        //   text: TextSpan(
                                        //     text:
                                        //     "bds dbns dns dbnsd bnszd bnzsd zbnsd zsbd zsbn zsbd bzsd zbnsd bnbb f",
                                        //         // '${value.todayCollectionList[index]['rec_note'].toString()}',
                                        //     style: DefaultTextStyle.of(context)
                                        //         .style,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                            
                                //  Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       // Column(
                                //       //   mainAxisAlignment:
                                //       //       MainAxisAlignment.start,
                                //       //   children: [
                                //       //     Row(
                                //       //       mainAxisAlignment:
                                //       //           MainAxisAlignment.start,
                                //       //       children: [
                                //       //         Image.asset(
                                //       //           "asset/collection.png",
                                //       //           height: 35,
                                //       //           color: P_Settings.wavecolor,
                                //       //           width: 30,
                                //       //         ),
                                //       //       ],
                                //       //     ),
                                //       //   ],
                                //       // ),
                                //       Padding(
                                //         padding: const EdgeInsets.only(left: 3),
                                //         child: Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.start,
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Row(
                                //               // mainAxisAlignment:
                                //               //     MainAxisAlignment.start,
                                //               children: [
                                //                 Text(
                                //                   "svdbns ghhv bhjbhb bdnsd sd sbnd jfhdjf bsz dbnzsd znsd nzsd zsnd zs ndzsdn",
                                //                   // "${value.todayCollectionList[index]['cus_name'].toString()} ",
                                //                   style: TextStyle(
                                //                       color: Colors.grey[700],
                                //                       fontWeight: FontWeight.bold,
                                //                       fontSize: 11),
                                //                 ),
                                //                 // Text(
                                //                 //   " - ${value.todayCollectionList[index]['rec_cusid'].toString()}",
                                //                 //   style: TextStyle(
                                //                 //       color: Colors.grey[700],
                                //                 //       fontWeight: FontWeight.bold,
                                //                 //       fontStyle: FontStyle.italic,
                                //                 //       fontSize: 11),
                                //                 // ),
                                //               ],
                                //             ),
                                //             Padding(
                                //               padding:
                                //                   const EdgeInsets.only(top: 10),
                                //               child: Row(
                                //                 children: [
                                //                   Text("Amount :",style: TextStyle(fontSize: 13),),
                                //                   Text(
                                //                     " \u{20B9}${value.todayCollectionList[index]['rec_amount'].toStringAsFixed(2)}",
                                //                     style: TextStyle(
                                //                         fontWeight:
                                //                             FontWeight.bold,
                                //                         color: Colors.red,
                                //                         fontSize: 14),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //             Padding(
                                //               padding:
                                //                   const EdgeInsets.only(top: 10),
                                //               child: Row(
                                //                 children: [
                                //                   RichText(
                                //                     overflow:
                                //                         TextOverflow.ellipsis,
                                //                     text: TextSpan(
                                //                       text:
                                //                           '${value.todayCollectionList[index]['rec_note'].toString()}',
                                //                       style: DefaultTextStyle.of(
                                //                               context)
                                //                           .style,
                                //                     ),
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                              ),
                            ),
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
