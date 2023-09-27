// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:orderapp/components/commoncolor.dart';
// import 'package:orderapp/components/customPopup.dart';
// import 'package:orderapp/components/customToast.dart';
// import 'package:orderapp/components/network_connectivity.dart';
// import 'package:orderapp/components/noNetwork.dart';
// import 'package:orderapp/components/unregister_popup.dart';
// import 'package:orderapp/controller/controller.dart';
// import 'package:orderapp/db_helper.dart';

// import 'package:orderapp/screen/ADMIN_/admin_dashboard.dart';
// import 'package:orderapp/screen/ADMIN_/homePage.dart';

// import 'package:orderapp/screen/ORDER/1_companyRegistrationScreen.dart';
// import 'package:orderapp/screen/ORDER/2_companyDetailsscreen.dart';
// import 'package:orderapp/screen/ORDER/3_staffLoginScreen.dart';
// import 'package:orderapp/screen/ORDER/5_mainDashboard.dart';
// import 'package:orderapp/screen/ORDER/6_customer_creation.dart';
// import 'package:orderapp/screen/ORDER/6_downloadedPage.dart';
// import 'package:orderapp/screen/ORDER/6_historypage.dart';
// import 'package:orderapp/screen/ORDER/6_reportPage.dart';
// import 'package:orderapp/screen/ORDER/6_uploaddata.dart';
// import 'package:orderapp/screen/ORDER/6_settings.dart';
// import 'package:orderapp/screen/ORDER/background_download.dart';
// import 'package:orderapp/screen/ORDER/todayCollection.dart';
// import 'package:orderapp/screen/ORDER/todaySale.dart';
// import 'package:orderapp/screen/ORDER/todaysOrder.dart';
// import 'package:orderapp/screen/ORDER/webview.dart';
// import 'package:orderapp/screen/SALES/sale_itemlist.dart';
// import 'package:orderapp/service/queryResult.dart';
// import 'package:orderapp/service/tableList.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../components/commoncolor.dart';
// import '6_orderForm.dart';

// class Dashboard extends StatefulWidget {
//   String? type;

//   String? areaName;
//   Dashboard({this.type, this.areaName});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
//   TabController? _tabController;
//   static const List<Tab> myTabs = <Tab>[
//     Tab(text: 'Home '),
//     Tab(text: 'Todays Order'),
//     Tab(text: 'Todays Collection'),
//     Tab(text: 'Todays Sale'),
//     Tab(text: 'CList'),
//   ];
//   List<Widget> drawerOpts = [];
//   String? gen_condition;
//   ValueNotifier<bool> upselected = ValueNotifier(false);
//   ValueNotifier<bool> dwnselected = ValueNotifier(false);
//   String title = "";
//   String? cid;
//   String? sid;
//   String? os;
//   bool val = true;
//   String? userType;
//   bool? isautodownload;
//   // String menu_index = "";
//   // List defaultitems = ["upload data", "download page", "logout"];
//   DateTime date = DateTime.now();
//   String? formattedDate;
//   String? selected;
//   String? firstMenu;
//   List<String> s = [];
//   Unreg popup = Unreg();
//   final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//   int _selectedIndex = 0;

//   _onSelectItem(int index, String? menu) {
//     if (!mounted) return;
//     print("menu----$menu");
//     if (this.mounted) {
//       setState(() {
//         _selectedIndex = index;
//         Provider.of<Controller>(context, listen: false).menu_index = menu!;
//       });
//     }
//     Navigator.of(context).pop(); // close the drawer
//   }

//   @override
//   void initState() {
//     // Provider.of<Controller>(context, listen: false).postRegistration("RONPBQ9AD5D",context);
//     // TODO: implement initState
//     print("returned---");
//     super.initState();
//     Provider.of<Controller>(context, listen: false).fetchMenusFromMenuTable();

//     drawerOpts.clear();

//     // print(Provider.of<Controller>(context, listen: false).firstMenu);
//     // if (Provider.of<Controller>(context, listen: false).firstMenu != null) {
//     //   Provider.of<Controller>(context, listen: false).menu_index =
//     //       Provider.of<Controller>(context, listen: false).firstMenu!;
//     // } else {
//     //   CircularProgressIndicator();
//     // }

//     formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
//     s = formattedDate!.split(" ");
//     Provider.of<Controller>(context, listen: false)
//         .verifyRegistration(context, "");
//     String? gen_area = Provider.of<Controller>(context, listen: false).areaId;
//     print("gen area----$gen_area");
//     if (gen_area != null) {
//       gen_condition = " and accountHeadsTable.area_id=$gen_area";
//     } else {
//       gen_condition = " ";
//     }
//     getCompaniId();

//     Provider.of<Controller>(context, listen: false).setCname();
//     Provider.of<Controller>(context, listen: false).setSname();
//     _tabController = TabController(
//       vsync: this,
//       length: myTabs.length,
//       initialIndex: 0,
//     );

//     _tabController!.addListener(() {
//       if (!mounted) return;
//       if (mounted) {
//         setState(() {
//           _selectedIndex = _tabController!.index;
//           Provider.of<Controller>(context, listen: false).menu_index =
//               _tabController!.index.toString();
//         });
//       }
//       print("Selected Index: " + _tabController!.index.toString());
//     });
//   }

//   navigateToPage(BuildContext context, Size size) {
//     print("Navigation in home page");
//     Navigator.of(context).push(
//       PageRouteBuilder(
//           opaque: false, // set to false
//           pageBuilder: (_, __, ___) => HomePage()),
//     );
//   }

//   // insertSettings() async {
//   //   await OrderAppDB.instance.deleteFromTableCommonQuery("settings", "");
//   //   await OrderAppDB.instance.insertsettingsTable("rate Edit", 0);
//   // }

//   getCompaniId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     cid = prefs.getString("cid");
//     os = prefs.getString("os");
//     userType = prefs.getString("userType");
//     // firstMenu = prefs.getString("firstMenu");
//     // Provider.of<Controller>(context, listen: false).menu_index = firstMenu;
//     // menu_index = firstMenu!;
//     sid = prefs.getString("sid");
//     print("sid...cid  menu_index $sid...$cid");
//     print("formattedDate...$formattedDate");
//     print("dashboard init");
//     print("${widget.type}");
//     if (widget.type == "return from cartList") {
//       Provider.of<Controller>(context, listen: false).menu_index = "S2";
//     }
//     print("dididdd");
//     print("user-----$userType");
//     if (userType == "admin") {
//       Provider.of<Controller>(context, listen: false).getArea(" ");
//     } else if (userType == "staff") {
//       if (sid != null) {
//         Provider.of<Controller>(context, listen: false).getArea(sid!);
//       }
//     }

//     print("s[0]----${s[0]}");
//     Provider.of<Controller>(context, listen: false)
//         .todayOrder(s[0], gen_condition!);
//     Provider.of<Controller>(context, listen: false)
//         .todayCollection(s[0], gen_condition!);
//     Provider.of<Controller>(context, listen: false)
//         .todaySales(s[0], gen_condition!);
//     if (Provider.of<Controller>(context, listen: false).areaidFrompopup !=
//         null) {
//       Provider.of<Controller>(context, listen: false).dashboardSummery(
//           sid!,
//           s[0],
//           Provider.of<Controller>(context, listen: false).areaidFrompopup!,
//           _key.currentContext!);
//     } else {
//       if (userType == "staff") {
//         Provider.of<Controller>(context, listen: false)
//             .dashboardSummery(sid!, s[0], "", _key.currentContext!);
//       }
//     }
//     // Provider.of<Controller>(context, listen: false)
//     //     .dashboardSummery(sid!, s[0], "");
//     print("cid--sid--$cid--$sid");
//     isautodownload = prefs.getBool("isautodownload");
//     // if (isautodownload != null && isautodownload!) {
//     //     Timer.periodic(Duration(seconds: 2), (timer) {
//     //       print("download data");
//     //       downloaddata.DownloadData(context);
//     //     });
//     //   }
//     return sid;
//   }

//   _getDrawerItemWidget(String? pos, Size size) {
//     print("pos---${pos}");
//     switch (pos) {
//       case "S1":
//         {
//           print("djs");
//           _tabController!.animateTo((0));

//           return new MainDashboard(
//             context: context,
//           );
//         }

//       case "S2":
//         if (widget.type == "return from cartList") {
//           return OrderForm(widget.areaName!, "sale order");
//         } else if (widget.type == "Product return confirmed") {
//           return OrderForm(widget.areaName!, "");
//         } else {
//           return OrderForm("", "");
//         }

//       case "S3":
//         return OrderForm("", "return");

//       case "SAC1":
//         return null;

//       case "S4":
//         return null;

//       case "S5":
//         return null;

//       case "SA1":
//         return CustomerCreation(
//           sid: sid!,
//           os: os,
//         );
//       case "A1":
//         {
//           Provider.of<Controller>(context, listen: false).adminDashboard(
//               Provider.of<Controller>(context, listen: false).cid!);
//           getCompaniId();
//           return AdminDashboard(
//               // sid: sid!,
//               // os: os,
//               );
//         }

//       case "A2":
//         {
//           getCompaniId();
//           print("ciddddd--$cid");
//           if (Provider.of<Controller>(context, listen: false).versof == "0") {
//             CustomToast tst = CustomToast();
//             tst.toast("company not registered");
//           } else {
//             SchedulerBinding.instance.addPostFrameCallback((_) {
//               Navigator.pop(context);
//               return navigateToPage(context, size);
//             });
//           }
//           return AdminDashboard();
//           // return MainDashboard();
//         }

//       case "SA2":
//         return null;
//       case "SA3":
//         // print("yy-- ${Provider.of<Controller>(context, listen: false).areaSelecton!}");
//         return OrderForm("", "collection");

//       case "SL1":
//         return OrderForm("", "sales");

//       case "UL":
//         {
//           Provider.of<Controller>(context, listen: false)
//               .verifyRegistration(context, "");
//           return Uploaddata(
//             title: "Upload data",
//             cid: cid!,
//             type: "drawer call",
//           );
//         }

//       case "DP":
//         {
//           Provider.of<Controller>(context, listen: false)
//               .verifyRegistration(context, "");
//           return DownloadedPage(
//             title: "Download Page",
//             type: "drawer call",
//             context: context,
//           );
//         }

//       case "CD":
//         // title = "Download data";
//         return CompanyDetails(
//           type: "drawer call",
//           msg: "",
//         );

//       case "HR":
//         // title = "Download data";
//         return History(
//             // type: "drawer call",
//             );
//       case "0":
//         return MainDashboard(
//           context: context,
//         );

//       case "1":
//         {
//           Provider.of<Controller>(context, listen: false).setDate(s[0], "");
//           Provider.of<Controller>(context, listen: false)
//               .todayOrder(s[0], gen_condition!);
//           return new TodaysOrder();
//         }
//       case "2":
//         {
//           Provider.of<Controller>(context, listen: false).setDate(s[0], "");
//           Provider.of<Controller>(context, listen: false)
//               .todayCollection(s[0], gen_condition!);
//           return TodayCollection();
//         }

//       case "3":
//         {
//           Provider.of<Controller>(context, listen: false).setDate(s[0], "");
//           Provider.of<Controller>(context, listen: false)
//               .todaySales(s[0], gen_condition!);
//           return new TodaySale();
//         }
//       case "4":
//         {
//           Provider.of<Controller>(context, listen: false)
//               .selectReportFromOrder(context, sid!, s[0], "");
//           // Navigator.pop(context);
//           return ReportPage(
//             sid: sid!,
//           );
//         }
//       // case "RP":
//       //   Provider.of<Controller>(context, listen: false).setFilter(false);
//       //   Provider.of<Controller>(context, listen: false)
//       //       .selectReportFromOrder(context);
//       //   return ReportPage();

//       // case "ST":
//       //   // title = "Download data";
//       //   return Settings();
//       // case "TO":
//       //   // title = "Upload data";
//       //   return TodaysOrder();
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     print("veeendum");
//     if (widget.type == "return from cartList" ||
//         widget.type == "Product return confirmed") {
//       print("from cart");
//       if (val) {
//         Provider.of<Controller>(context, listen: false).menu_index = "S2";
//         val = false;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Provider.of<Controller>(context, listen: false)
//     //     .todayCollection(s[0], context);
//     print(
//         "length menu-0----${Provider.of<Controller>(context, listen: false).menuList.length}");
//     Size size = MediaQuery.of(context).size;
//     return WillPopScope(
//         onWillPop: () => _onBackPressed(context),
//         child: Scaffold(
//           key: _key, //
//           // backgroundColor: P_Settings.wavecolor,
//           appBar:
//               Provider.of<Controller>(context, listen: false).menu_index ==
//                           "UL" ||
//                       Provider.of<Controller>(context, listen: false)
//                               .menu_index ==
//                           "DP"
//                   ? AppBar(
//                       flexibleSpace: Container(
//                         decoration: BoxDecoration(),
//                       ),
//                       elevation: 0,
//                       title: Text(
//                         title,
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       // backgroundColor: P_Settings.wavecolor,
//                       bottom: PreferredSize(
//                         preferredSize: Size.fromHeight(6.0),
//                         child: Consumer<Controller>(
//                           builder: (context, value, child) {
//                             if (value.isLoading) {
//                               return LinearProgressIndicator(
//                                 backgroundColor: Colors.white,
//                                 color: P_Settings.wavecolor,

//                                 // valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
//                                 // value: 0.25,
//                               );
//                             } else {
//                               return Container();
//                             }
//                           },
//                         ),
//                       ),
//                       // title: Text("Company Details",style: TextStyle(fontSize: 20),),
//                     )
//                   : AppBar(
//                       flexibleSpace: Container(
//                         decoration: BoxDecoration(),
//                       ),
//                       backgroundColor: Provider.of<Controller>(context,
//                                           listen: false)
//                                       .menu_index ==
//                                   "S1" ||
//                               Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "0" ||
//                               Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "1" ||
//                               Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "2" ||
//                               Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "3" ||
//                               Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "4"
//                           ? Colors.white
//                           : P_Settings.wavecolor,

//                       bottom: Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "S1" ||
//                               Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "1" ||
//                               Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "2" ||
//                               Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "3" ||
//                               Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "4" ||
//                               Provider.of<Controller>(context, listen: false)
//                                       .menu_index ==
//                                   "0"
//                           ? TabBar(
//                               isScrollable: true,
//                               // indicator: BoxDecoration(
//                               //     borderRadius: BorderRadius.circular(50),
//                               //     color:P_Settings.wavecolor),
//                               indicatorColor: P_Settings.wavecolor,
//                               indicatorSize: TabBarIndicatorSize.label,
//                               indicatorWeight: 3.0,
//                               labelPadding:
//                                   EdgeInsets.symmetric(horizontal: 9.0),
//                               // indicatorSize: TabBarIndicatorSize.label,
//                               labelColor: Color.fromARGB(255, 58, 54, 54),
//                               labelStyle: GoogleFonts.lato(
//                                 textStyle:
//                                     Theme.of(context).textTheme.bodyText2,
//                                 fontSize: 14,
//                               ),
//                               unselectedLabelColor: P_Settings.wavecolor,
//                               tabs: myTabs,
//                               controller: _tabController,
//                             )
//                           : null,
//                       leading: Builder(
//                         builder: (context) => IconButton(
//                             icon: new Icon(
//                               Icons.menu,
//                               color: Provider.of<Controller>(context, listen: false)
//                                               .menu_index ==
//                                           "S1" ||
//                                       Provider.of<Controller>(context, listen: false)
//                                               .menu_index ==
//                                           "0" ||
//                                       Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .menu_index ==
//                                           "1" ||
//                                       Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .menu_index ==
//                                           "2" ||
//                                       Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .menu_index ==
//                                           "3" ||
//                                       Provider.of<Controller>(context,
//                                                   listen: false)
//                                               .menu_index ==
//                                           "4"
//                                   ? P_Settings.wavecolor
//                                   : Colors.white,
//                             ),
//                             onPressed: () async {
//                               drawerOpts.clear();

//                               Provider.of<Controller>(context, listen: false)
//                                   .getCompanyData();

//                               // drawerOpts.clear();
//                               print(
//                                   "drwer op---${drawerOpts.length}----${Provider.of<Controller>(context, listen: false).menuList.length}");
//                               for (var i = 0;
//                                   i <
//                                       Provider.of<Controller>(context,
//                                               listen: false)
//                                           .menuList
//                                           .length;
//                                   i++) {
//                                 // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];

//                                 drawerOpts.add(Consumer<Controller>(
//                                   builder: (context, value, child) {
//                                     // print(
//                                     //     "menulist[menu]-------${value.menuList[i]["menu_name"]}");
//                                     return ListTile(
//                                       title: Text(
//                                         value.menuList[i]["menu_name"]
//                                             .toLowerCase(),
//                                         style: GoogleFonts.lato(
//                                           textStyle: Theme.of(context)
//                                               .textTheme
//                                               .bodyText2,
//                                           fontSize: 17,
//                                         ),
//                                       ),
//                                       // selected: i == _selectedIndex,
//                                       onTap: () {
//                                         _onSelectItem(
//                                           i,
//                                           value.menuList[i]["menu_index"],
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ));
//                               }
//                               Scaffold.of(context).openDrawer();
//                             }),
//                       ),
//                       elevation: 0,
//                       // backgroundColor: P_Settings.wavecolor,
//                       actions: [
//                         /////////////////// table view in app bar /////////////////
//                         // IconButton(
//                         //     onPressed: () {
//                         //       Provider.of<Controller>(context, listen: false)
//                         //           .clearList(Provider.of<Controller>(context,
//                         //                   listen: false)
//                         //               .queryResult);
//                         //       Navigator.of(context).push(
//                         //         PageRouteBuilder(
//                         //             opaque: false, // set to false
//                         //             pageBuilder: (_, __, ___) =>
//                         //                 QueryResultScreen()),
//                         //       );
//                         //     },
//                         //     icon: Icon(
//                         //       Icons.query_builder,
//                         //       color: Colors.green,
//                         //     )),
//                         // IconButton(
//                         //   onPressed: () async {
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("orderMasterTable", "");
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("orderDetailTable", "");
//                         //     await OrderAppDB.instance.deleteFromTableCommonQuery(
//                         //         "accountHeadsTable", "");
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("customerTable", "");
//                         //     await OrderAppDB.instance.deleteFromTableCommonQuery(
//                         //         "registrationTable", "");
//                         //     await OrderAppDB.instance.deleteFromTableCommonQuery(
//                         //         "staffDetailsTable", "");
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("areaDetailsTable", "");
//                         //     await OrderAppDB.instance.deleteFromTableCommonQuery(
//                         //         "productDetailsTable", "");
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("productsCategory", "");
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("companyTable", "");
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("orderBagTable", "");
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("menuTable", "");
//                         //     // await OrderAppDB.instance
//                         //     //     .deleteFromTableCommonQuery("settings", "");
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("walletTable", "");
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("collectionTable", "");
//                         //     await OrderAppDB.instance
//                         //         .deleteFromTableCommonQuery("remarksTable", "");
//                         //     await OrderAppDB.instance.deleteFromTableCommonQuery(
//                         //         "returnMasterTable", "");
//                         //     await OrderAppDB.instance.deleteFromTableCommonQuery(
//                         //         "returnDetailTable", "");
//                         //   },
//                         //   icon: Icon(
//                         //     Icons.delete,
//                         //     color: Colors.green,
//                         //   ),
//                         // ),
//                         // IconButton(
//                         //   onPressed: () async {
//                         //     List<Map<String, dynamic>> list =
//                         //         await OrderAppDB.instance.getListOfTables();
//                         //     Navigator.push(
//                         //       context,
//                         //       MaterialPageRoute(
//                         //           builder: (context) => TableList(list: list)),
//                         //     );
//                         //   },
//                         //   icon: Icon(Icons.table_bar, color: Colors.green),
//                         // ),
//                       ],
//                     ),

//           drawer: Drawer(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: size.height * 0.045,
//                       ),
//                       Container(
//                         height: size.height * 0.1,
//                         width: size.width * 1,
//                         color: P_Settings.wavecolor,
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               height: size.height * 0.07,
//                               width: size.width * 0.03,
//                             ),
//                             Icon(
//                               Icons.list_outlined,
//                               color: Colors.white,
//                             ),
//                             SizedBox(width: size.width * 0.04),
//                             Text(
//                               "Menus",
//                               style:
//                                   TextStyle(fontSize: 20, color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Column(children: drawerOpts),
//                       Divider(
//                         color: Colors.black,
//                         indent: 20,
//                         endIndent: 20,
//                       ),
//                       ListTile(
//                         onTap: () async {
//                           _onSelectItem(0, "CD");
//                         },
//                         title: Text(
//                           "company Details",
//                           style: TextStyle(fontSize: 17),
//                         ),
//                       ),
//                       // ListTile(
//                       //   onTap: () async {
//                       //     _onSelectItem(0, "SO");
//                       //   },
//                       //   title: Text(
//                       //     "Sales",
//                       //     style: TextStyle(fontSize: 17),
//                       //   ),
//                       // ),
//                       ListTile(
//                         trailing: Icon(Icons.arrow_downward),
//                         onTap: () async {
//                           _onSelectItem(0, "DP");
//                         },
//                         title: Text(
//                           "download page",
//                           style: TextStyle(fontSize: 17),
//                         ),
//                       ),
//                       ListTile(
//                         trailing: Icon(Icons.arrow_upward),
//                         onTap: () async {
//                           _onSelectItem(0, "UL");
//                         },
//                         title: Text(
//                           "upload data",
//                           style: TextStyle(fontSize: 17),
//                         ),
//                       ),
//                       // ListTile(
//                       //   trailing: Icon(Icons.settings),
//                       //   onTap: () async {
//                       //     _onSelectItem(0, "ST");
//                       //   },
//                       //   title: Text(
//                       //     "settings",
//                       //     style: TextStyle(fontSize: 17),
//                       //   ),
//                       // ),
//                       ListTile(
//                         trailing: Icon(Icons.web),
//                         onTap: () async {
//                           NetConnection.networkConnection(context)
//                               .then((value) async {
//                             if (value == true) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => WebViewTest()),
//                               );
//                             } else {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => NoNetwork()),
//                               );
//                             }
//                           });
//                         },
//                         title: Text(
//                           "webview",
//                           style: TextStyle(fontSize: 17),
//                         ),
//                       ),
//                       ListTile(
//                         trailing: Icon(Icons.settings),
//                         onTap: () async {
//                           final prefs = await SharedPreferences.getInstance();
//                           await prefs.remove('company_id');
//                           popup.showAlertDialog(context);
//                         },
//                         title: Text(
//                           "un-register",
//                           style: TextStyle(fontSize: 17),
//                         ),
//                       ),
//                       ListTile(
//                         trailing: Icon(Icons.logout),
//                         onTap: () async {
//                           final prefs = await SharedPreferences.getInstance();
//                           await prefs.remove('st_username');
//                           await prefs.remove('st_pwd');
//                           String? userType = prefs.getString("user_type");
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => StaffLogin()));
//                         },
//                         title: Text(
//                           "logout",
//                           style: TextStyle(fontSize: 17),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           body: TabBarView(
//             physics: NeverScrollableScrollPhysics(),
//             controller: _tabController,
//             children: myTabs.map((Tab tab) {
//               final String label = tab.text!.toLowerCase();
//               return Center(
//                 child: Container(
//                   child: _getDrawerItemWidget(
//                       Provider.of<Controller>(context, listen: false)
//                           .menu_index!,
//                       size),
//                 ),
//               );
//             }).toList(),
//           ),
//         ));
//   }
// }

// Future<bool> _onBackPressed(BuildContext context) async {
//   return await showDialog(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         // title: const Text('AlertDialog Title'),
//         content: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: ListBody(
//             children: const <Widget>[
//               Text('Do you want to exit from this app'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('cancel'),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           TextButton(
//             child: const Text('Ok'),
//             onPressed: () {
//               exit(0);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
