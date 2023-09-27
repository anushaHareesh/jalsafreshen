import 'dart:math';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/screen/ADMIN_/adminModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class AdminDashboard extends StatefulWidget {
  // const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  DateTime date = DateTime.now();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String? formattedDate;
  String? sid;
  String? heading;
  String? updateDate;
  Color parseColor(String color) {
    print("Colorrrrr...$color");
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  final rnd = math.Random();

  sharedPref() async {
    print("helooo");
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    heading = prefs.getString('heading');
    updateDate = prefs.getString('updateDate');
    print("heading ......$heading");
    // Provider.of<Controller>(context, listen: false).todayOrder(s[0], context);
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cid = prefs.getString("cid");
    Provider.of<Controller>(context, listen: false).adminDashboard(cid!);

    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    formattedDate = DateFormat('yyyy-MM-dd').format(date);
    // s = formattedDate!.split(" ");
    // TODO: implement initState
    super.initState();
    sharedPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SmartRefresher(
        enablePullDown: true,
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: Consumer<Controller>(
          builder: (context, value, child) {
            if (value.isAdminLoading) {
              // return Container();
              return SpinKitFadingCircle(
                color: P_Settings.wavecolor,
              );
            } else {
              return Column(
                children: [
                  Container(
                    height: size.height * 0.04,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   radius: 15,
                        //   child: Icon(
                        //     Icons.person,
                        //     color: P_Settings.wavecolor,
                        //   ),
                        // ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        // Text("${value.cname}",
                        //     style: TextStyle(
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.bold,
                        //         color: P_Settings.wavecolor)),
                        // Text("  - Admin",
                        //     style: TextStyle(
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.bold,
                        //         color: P_Settings.collection1,
                        //         fontStyle: FontStyle.italic)),
                        SizedBox(
                          width: size.width * 0.1,
                        ),

                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          child: ListTile(
                            title: value.heading == null
                                ? SpinKitThreeBounce(
                                    color: P_Settings.wavecolor, size: 14)
                                : Row(
                                    children: [
                                      Text("${value.heading}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: P_Settings.wavecolor)),
                                      Flexible(
                                        child: Text(" : ${value.updateDate}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: P_Settings.extracolor)),
                                      ),
                                    ],
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Divider(thickness: 2),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: value.adminDashboardList.length,
                      itemBuilder: (context, index) {
                        return rowChild(value.adminDashboardList[index], size);
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    )
        //
        );
  }

  Widget rowChild(Today list, Size size) {
    print("listtt$list");
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(list.group.toString(),
              style: GoogleFonts.alike(
                  textStyle: Theme.of(context).textTheme.bodyText2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: P_Settings.wavecolor)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: list.data!.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: list.tileCount == 1 ? 1 : 2,
                  childAspectRatio: list.tileCount == 1 ? 3.2 : 1.1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (contxt, indx) {
                return Container(
                  child: Card(
                    color:
                        // Colors.red[300],
                        parseColor(
                      list.data![indx].color.toString(),
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.all(4.0),
                    child: list.tileCount == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: size.width * 0.3),
                                  Container(
                                    height: size.height * 0.05,
                                    width: size.width * 0.11,
                                    child: Image.asset(
                                      'asset/3.png',
                                      height: 20.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: size.width * 0.3),
                                    Text(list.data![indx].caption.toString(),
                                        style: GoogleFonts.alike(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            fontSize: 14,
                                            color: Colors.white)),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Text(list.data![indx].cvalue.toString(),
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ]),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: size.height * 0.05,
                                width: size.width * 0.1,
                                child: Image.asset(
                                  'asset/3.png',
                                  height: 20.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(list.data![indx].caption.toString(),
                                  style: GoogleFonts.alike(
                                      textStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      fontSize: 14,
                                      color: Colors.white)),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(list.data![indx].cvalue.toString(),
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
