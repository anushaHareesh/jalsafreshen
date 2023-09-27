import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/screen/ORDER/DateFinder.dart';
import 'package:salesapp/screen/ORDER/pdfPrev.dart';
import 'package:salesapp/screen/historydataPopup.dart';
import 'package:provider/provider.dart';
import '../../db_helper.dart';

 class TodaysOrder extends StatefulWidget {
  const TodaysOrder({Key? key}) : super(key: key);

  @override
  State<TodaysOrder> createState() => _TodaysOrderState();
}

class _TodaysOrderState extends State<TodaysOrder> {
  // MainDashboard dash = MainDashboard();
  DateTime now = DateTime.now();
  DateFind dateFind = DateFind();
  HistoryPopup popup = HistoryPopup();
  List<String> s = [];
  String? result;
  String? date;
  String? todaydate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    todaydate = DateFormat('yyyy-MM-dd').format(now);
    s = date!.split(" ");
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
            if (value.todayOrderList.length == 0) {
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
                                  context, "from date", "sale order");
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
                      "No Orders!!!",
                      style: TextStyle(
                          fontSize: 17, color: P_Settings.collection1),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () async {
                              String d = value.fromDate.toString();
                              print("detailodata----${d}");
                              var detailData = await OrderAppDB.instance
                                  .printOrderDetailTable(
                                d
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfPreviewPage(
                                    type: 'sale order',
                                    list: detailData,
                                  ),
                                ),
                              );
                              // SaleReport printer = SaleReport();
                              // printer.printSaleReport(value.todaySalesList);
                            },
                            child: Text(
                              "Print Report",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.red),
                            )),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  dateFind.selectDateFind(
                                      context, "from date", "sale order");
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
                  //               context, "from date", "sale order");
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

                  //   ],
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.todayOrderList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Provider.of<Controller>(context,
                                          listen: false)
                                      .getHistoryData('orderDetailTable',
                                          "order_id='${value.todayOrderList[index]["order_id"]}'");
                                  popup.buildPopupDialog(
                                      context,
                                      size,
                                      value.todayOrderList[index]["Order_Num"],
                                      value.todayOrderList[index]["Cus_id"],
                                      "sale order");
                                },
                                child: Card(
                                    child: ListTile(
                                  tileColor: Colors.grey[100],
                                  title: Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          // Icon(Icons),
                                          // SizedBox(
                                          //   width: size.width * 0.02,
                                          // ),
                                          Text("Ord No : "),
                                          Flexible(
                                            child: Text(
                                                value.todayOrderList[index]
                                                    ["Order_Num"],
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: P_Settings.wavecolor,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          RichText(
                                            overflow: TextOverflow.clip,
                                            maxLines: 2,
                                            text: TextSpan(
                                              text:
                                                  '${value.todayOrderList[index]["cus_name"]}',
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Text(" - "),
                                          Text(
                                            value.todayOrderList[index]
                                                ["Cus_id"],
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "No: of Items  :",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                              "${value.todayOrderList[index]["count"].toString()}",
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                          Spacer(),
                                          Text(
                                            "Total  :",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "\u{20B9}${value.todayOrderList[index]["total_price"].toStringAsFixed(2)}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
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
