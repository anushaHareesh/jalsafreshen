import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/areaPopup.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/screen/ORDER/6_customer_creation.dart';
import 'package:salesapp/screen/ORDER/6_orderForm.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDashboard extends StatefulWidget {
  BuildContext context;
  MainDashboard({Key? key, required this.context}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();

  static void dispose() {}
}

class _MainDashboardState extends State<MainDashboard> {
  DateTime date = DateTime.now();
  String? formattedDate;
  String? gen_condition;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String? userType;
  String? selected;
  List<String> s = [];
  AreaSelectionPopup popup = AreaSelectionPopup();
  String? sid;
  String? os;

  sharedPref() async {
    formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    s = formattedDate!.split(" ");
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    os = prefs.getString("os");

    userType = prefs.getString("userType");
    print("sid .sdd.....$sid");

    print("formattedDate...$formattedDate");
    print("sid ......$sid");

    // if (Provider.of<Controller>(context, listen: false).areaId != null) {
    //   Provider.of<Controller>(context, listen: false).dashboardSummery(
    //       sid!,
    //       s[0],
    //       Provider.of<Controller>(context, listen: false).areaId!,
    //       widget.context);
    // } else {
    //   if (userType == "staff") {
    //     Provider.of<Controller>(context, listen: false)
    //         .dashboardSummery(sid!, s[0], "",widget.context);
    //   }
    // }
    // Provider.of<Controller>(context, listen: false).todayOrder(s[0], context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => build(context));
    // initPlatformState();
    print("init");
    sharedPref();
    Provider.of<Controller>(context, listen: false)
        .selectSettings("set_code in ('DEFAULT_CUST_CODE') ");
    // String? gen_area = Provider.of<Controller>(context, listen: false).areaId;
    // print("gen area----$gen_area");
    // if (gen_area != null) {
    //   gen_condition = " and accountHeadsTable.area_id=$gen_area";
    // } else {
    //   gen_condition = " ";
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Consumer<Controller>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return SpinKitFadingCircle(
                color: P_Settings.wavecolor,
              );
            } else {
              return Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(95),
                          // topRight: Radius.circular(95),
                          ),
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 11.0, left: 08),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 15,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.yellow,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "${value.cname}",
                                  style: GoogleFonts.aBeeZee(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                " - ${value.sname?.toUpperCase()}",
                                style: GoogleFonts.aBeeZee(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyLarge,
                                    color: Colors.grey[600],
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13),
                                // style: TextStyle(
                                //     fontSize: 14,
                                //     fontWeight: FontWeight.bold,
                                //     color: P_Settings.collection1,
                                //     fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                buildPopupDialog(context, size);
                              },
                              icon: const Icon(
                                Icons.place,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              // value.areDetails.toString(),
                              value.areaSelecton == null
                                  ? "Choose Area"
                                  : value.areaSelecton!,
                              style: GoogleFonts.oswald(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyLarge,
                                  color: P_Settings.collection1,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       top: 4.0, left: 8, right: 8),
                        //   child: Card(
                        //     elevation: 4,
                        //     color: Color.fromARGB(255, 250, 248, 248),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: ListTile(
                        //         leading: Image.asset(
                        //           "asset/order.png",
                        //           height: size.height * 0.058,
                        //         ),
                        //         title: Text(
                        //           "SALE ORDER",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 13),
                        //         ),
                        //         onTap: () {
                        //           // if (widget.type == "return from cartList") {
                        //           //   return OrderForm(
                        //           //       widget.areaName!, "sale order");
                        //           // } else if (widget.type ==
                        //           //     "Product return confirmed") {
                        //           //   return OrderForm(widget.areaName!, "");
                        //           // } else {
                        //           //   return OrderForm("", "");
                        //           // }
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       OrderForm("", "sale order")));
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 8, right: 8),
                          child: Card(
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                color: Color.fromARGB(255, 192, 191, 191),
                                width: 1.0,
                              ),
                            ),
                            // color: Color.fromARGB(255, 250, 248, 248),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color.fromARGB(255, 4, 93, 167),
                                ),
                                leading: CircleAvatar(
                                  // backgroundColor: Colors.,
                                  backgroundImage: AssetImage(
                                    "asset/sales.png",
                                  ),
                                ),
                                title: Text(
                                  "SALES ENTRY",
                                  style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderForm("", "sales")));
                                },
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       top: 4.0, left: 8, right: 8),
                        //   child: Card(
                        //     elevation: 4,
                        //     color: Color.fromARGB(255, 250, 248, 248),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: ListTile(
                        //         leading: Image.asset(
                        //           "asset/customer.png",
                        //           height: size.height * 0.058,
                        //         ),
                        //         title: Text(
                        //           "CUSTOMER CREATION",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 13),
                        //         ),
                        //         onTap: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                 builder: (context) => CustomerCreation(
                        //                   sid: sid!,
                        //                   os: os,
                        //                 ),
                        //               ));
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, left: 8, right: 8),
                          child: Card(
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                color: Color.fromARGB(255, 192, 191, 191),
                                width: 1.0,
                              ),
                            ),
                            // color: Color.fromARGB(255, 250, 248, 248),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color.fromARGB(255, 4, 93, 167),
                                ),
                                leading: CircleAvatar(
                                  // backgroundColor: Colors.,
                                  backgroundImage: AssetImage(
                                    "asset/collector.png",
                                  ),
                                ),
                                title: Text(
                                  "COLLECTION ENTRY",
                                  style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderForm("", "collection")));
                                },
                              ),
                            ),
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text("Todays Count",
                        //           style: GoogleFonts.oswald(
                        //               textStyle:
                        //                   Theme.of(context).textTheme.displayLarge,
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.grey[700])),
                        //       Text(" -  ${s[0]}",
                        //           style: GoogleFonts.oswald(
                        //               textStyle:
                        //                   Theme.of(context).textTheme.bodyMedium,
                        //               fontSize: 16,
                        //               color: P_Settings.wavecolor))
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: size.height*01,),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: customcard(size, "Orders",
                        //           "${value.orderCount != "null" ? value.orderCount : "0"}"),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: customcard(size, "Collection",
                        //           "${value.collectionCount != "null" ? value.collectionCount : "0"}"),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: customcard(size, "Sales",
                        //           "${value.salesCount != "null" ? value.salesCount : "0"}"),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: customcard(size, "Return",
                        //           "${value.ret_count != "null" ? value.ret_count : "0"}"),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: customcard(
                        //         size,
                        //         "Shops visited",
                        //         "${value.shopVisited ?? "0"}",
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: customcard(size, "Shops Not Visited",
                        //           "${value.noshopVisited ?? "0"}"),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 12,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("Todays Collection ",
                                      style: GoogleFonts.oswald(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700])),
                                  Text("-  ${s[0]}",
                                      style: GoogleFonts.oswald(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          fontSize: 16,
                                          color: P_Settings.wavecolor))
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: customcard(
                                  size,
                                  "Cash Sale",
                                  "${value.cs_cnt == null || value.cs_cnt == "null" ? "0" : value.cs_cnt}" +
                                      "/" +
                                      "\u{20B9}${value.cashSaleAmt == "null" ? "0.0" : value.cashSaleAmt}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: customcard(
                                  size,
                                  "Credit Sale",
                                  "${value.cr_cnt == null || value.cr_cnt == "null" ? "0" : value.cr_cnt}" +
                                      "/" +
                                      "\u{20B9}${value.creditSaleAmt == "null" ? "0.00" : value.creditSaleAmt}"),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: customcard(
                                  size,
                                  "Sales",
                                  "${value.salesCount == null || value.salesCount == "null" ? "0" : value.salesCount}" +
                                      "/" +
                                      "\u{20B9}${value.salesAmount == "null" ? "0.0" : value.salesAmount}"),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(0),
                            //   child: customcard(size, "Collection",
                            //       "\u{20B9}${value.collectionAmount == "null" ? "0.00" : value.collectionAmount}"),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(0),
                            //   child: customcard(
                            //       size,
                            //       "Cancelled Bills",
                            //       "${value.can_bill_count == "null" ? "0" : value.can_bill_count}" +
                            //           "/" +
                            //           "\u{20B9}${value.can_bill_amt == "null" ? "0.00" : value.can_bill_amt}"),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: customcard(
                                  size,
                                  "Collection",
                                  // "${value.can_bill_count == "null" ? "0" : value.can_bill_count}" +
                                  //     "/" +
                                  "\u{20B9}${value.collectionAmount == null || value.collectionAmount == "null" ? "0.00" : value.collectionAmount}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  //////////////////////////////////////////////////////////////////////

  buildPopupDialog(BuildContext context, Size size) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Consumer<Controller>(builder: (context, value, child) {
                if (value.isLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.white,
                        height: size.height * 0.06,
                        child: DropdownButton<String>(
                          value: selected,
                          // isDense: true,
                          hint: const Text("Select"),
                          // isExpanded: true,
                          autofocus: false,
                          underline: const SizedBox(),
                          elevation: 0,
                          items: value.areDetails
                              .map((item) => DropdownMenuItem<String>(
                                  value: item["aid"].toString(),
                                  child: SizedBox(
                                    width: size.width * 0.5,
                                    child: Text(
                                      item["aname"].toString(),
                                      style: const TextStyle(fontSize: 14),
                                    ),
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
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (selected != null) {
                              Provider.of<Controller>(context, listen: false)
                                  .areaId = selected;
                              Provider.of<Controller>(context, listen: false)
                                  .areaSelection(selected!);
                              Provider.of<Controller>(context, listen: false)
                                  .dashboardSummery(
                                      sid!, s[0], selected!, context);
                              String? genArea = Provider.of<Controller>(context,
                                      listen: false)
                                  .areaidFrompopup;
                              if (genArea != null) {
                                gen_condition =
                                    " and accountHeadsTable.area_id=$genArea";
                              } else {
                                gen_condition = " ";
                              }
                              Provider.of<Controller>(context, listen: false)
                                  .getCustomer(genArea!);
                              // Provider.of<Controller>(context, listen: false)
                              //     .todayOrder(s[0], gen_condition!);
                              Provider.of<Controller>(context, listen: false)
                                  .todayCollection(s[0], gen_condition!);
                              Provider.of<Controller>(context, listen: false)
                                  .todaySales(s[0], gen_condition!, "");
                              // Provider.of<Controller>(context, listen: false)
                              //     .selectReportFromOrder(
                              //         context, sid!, s[0], "");
                            }

                            Navigator.pop(context);
                          },
                          child: const Text("save"))
                    ],
                  );
                }
              }),
            );
          });
        });
  }

  //////////////////////////////////////////////////////////////////////
  Widget customcard(
    Size size,
    String title,
    String value,
  ) {
    print("valuenjn-----$value");
    return SizedBox(
      height: size.height * 0.2,
      width: size.width * 0.45,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        // color: Colors.black,
        color: title == "Cash Sale"
            ? P_Settings.dashbordcl1
            : title == "Cancelled Bills"
                ? P_Settings.dashbordcl2
                : title == "Sales"
                    ? P_Settings.dashbordcl3
                    : title == "Credit Sale"
                        ? P_Settings.dashbordcl4
                        : title == "Shops visited"
                            ? P_Settings.dashbordcl5
                            : title == "Shops Not Visited"
                                ? P_Settings.dashbordcl6
                                : P_Settings.dashbordcl2,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // height: size.height * 0.1,
                // width: size.width * 0.12,
                child: title == "Cash Sale"
                    ? Image.asset(
                        "asset/cashsale.png",
                        height: size.height * 0.05,
                        width: size.width * 0.12,
                      )
                    : title == "Cancelled Bills"
                        ? Image.asset(
                            "asset/order.png",
                            height: size.height * 0.05,
                            width: size.width * 0.12,
                          )
                        : title == "Sales"
                            ? Image.asset(
                                "asset/sale.png",
                                height: size.height * 0.05,
                                width: size.width * 0.12,
                              )
                            : title == "Shops visited"
                                ? Image.asset(
                                    "asset/5.png",
                                    height: size.height * 0.05,
                                    width: size.width * 0.12,
                                  )
                                : title == "Shops Not Visited"
                                    ? Image.asset(
                                        "asset/6.png",
                                        height: size.height * 0.05,
                                        width: size.width * 0.12,
                                      )
                                    : title == "Credit Sale"
                                        ? Image.asset(
                                            "asset/creditSale.png",
                                            height: size.height * 0.05,
                                            width: size.width * 0.12,
                                          )
                                        : title == "Collection"
                                            ? Image.asset(
                                                "asset/collection.png",
                                                height: size.height * 0.05,
                                                width: size.width * 0.12,
                                              )
                                            : null,
              ),
              Text(
                title.toString(),
                style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Text(
                value == null || value == "null" ? "0" : value.toString(),
                style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  fontSize: 16,
                  color: Colors.white,
                ),
                // style: TextStyle(
                //     fontSize: 23,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
