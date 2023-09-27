import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customSnackbar.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:salesapp/screen/ADMIN_/adminController.dart';
import 'package:salesapp/screen/ORDER/3_staffLoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyDetails extends StatefulWidget {
  String? type;
  String? msg;
  int? br_length;

  CompanyDetails({this.type, this.msg, required this.br_length});
  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  String? cid;
  String? firstMenu;
  String? versof;
  String? data;
  String? fingerprint;
  String? selected;

  CustomSnackbar _snackbar = CustomSnackbar();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCid();
    // if (widget.type == " ") {
    if (widget.br_length! > 0) {
      //  Future(buildPopupDialog(context));
      SchedulerBinding.instance.addPostFrameCallback((_) {
        buildPopupDialog(context);
      });
    }
    // }
  }

  getCid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cid = prefs.getString("cid");
    versof = prefs.getString("versof");

    fingerprint = prefs.getString("fp");
    print("fingerprint-----$fingerprint");
    if (cid != null) {
      Provider.of<AdminController>(context, listen: false)
          .getCategoryReport(cid!);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: P_Settings.detailscolor,
      appBar: widget.type == ""
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: P_Settings.wavecolor,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(6.0),
                child: Center(
                    child: Text(
                  " ",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                )),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Company Details",
                  style: TextStyle(
                      fontSize: 16,
                      color: P_Settings.headingColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // SizedBox(
            //   height: size.height * 0.003,
            // ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Consumer<Controller>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return Container(
                      height: size.height * 0.9,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    if (value.companyList.length > 0) {
                      return Container(
                        margin: EdgeInsets.only(left: 30),
                        height: size.height * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            Row(
                              children: [
                                Icon(Icons.business),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text("company name "),
                                ),
                                Flexible(
                                  child: Text(
                                      ": ${(value.companyList[0]["cnme"] == null) && (value.companyList[0]["cnme"].isEmpty) ? "" : value.companyList[0]["cnme"]}"),
                                ),
                                //  Flexible(child: )
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.business),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text("company id"),
                                ),
                                Flexible(
                                  child: Text(
                                    ": ${(value.companyList[0]["cid"] == null) && (value.companyList[0]["cid"].isEmpty) ? "" : value.companyList[0]["cid"]}",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                            value.branch_name == null
                                ? Container()
                                : SizedBox(
                                    height: size.height * 0.02,
                                  ),
                            value.branch_name == null
                                ? Container()
                                : Row(
                                    children: [
                                      Icon(Icons.code),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Container(
                                        width: size.width * 0.3,
                                        child: Text("branch name"),
                                      ),
                                      Flexible(
                                        child: Text(
                                          ": ${(value.branch_name == null) && (value.branch_name!.isEmpty) ? "" : value.branch_name}",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.numbers_rounded),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text("Order Series"),
                                ),
                                Text(
                                  ": ${(value.companyList[0]["os"] == null) && (value.companyList[0]["os"].isEmpty) ? "" : value.companyList[0]["os"]}",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.fingerprint),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text("fingerprint"),
                                ),
                                Flexible(
                                  child: Text(
                                    ": ${(value.companyList[0]["fp"] == null) && (value.companyList[0]["fp"].isEmpty) ? "" : value.companyList[0]["fp"]}",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.book),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text("Address1"),
                                ),
                                Flexible(
                                  child: Text(
                                    ": ${value.companyList[0]['ad1']}",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            "${value.companyList[0]['ad2']}" == null
                                ? Container()
                                : Row(
                                    children: [
                                      Icon(Icons.book),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Container(
                                        width: size.width * 0.3,
                                        child: Text("Address2"),
                                      ),
                                      Flexible(
                                        child: Text(
                                          ": ${value.companyList[0]['ad2']}",
                                          style: TextStyle(fontSize: 13),
                                          // value.reportList![index]['filter_names'],
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            //  Row(
                            //     children: [
                            //       Icon(Icons.pin),
                            //       SizedBox(
                            //         width: size.width * 0.02,
                            //       ),
                            //       Container(
                            //         width: size.width * 0.3,
                            //         child: Text("PinCode"),
                            //       ),
                            //       Text(
                            //         ": ",
                            //         // value.reportList![index]['filter_names'],
                            //       ),
                            //     ],
                            //   ),
                            //   SizedBox(
                            //     height: size.height * 0.02,
                            //   ),
                            Row(
                              children: [
                                Icon(Icons.business),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text("CompanyPrefix"),
                                ),
                                Flexible(
                                  child: Text(
                                    ": ${value.companyList[0]["cpre"]}",
                                    style: TextStyle(fontSize: 13),
                                    // value.reportList![index]['filter_names'],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.landscape),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text("Land"),
                                ),
                                Flexible(
                                  child: Text(
                                    ": ${value.companyList[0]["land"]}",
                                    style: TextStyle(fontSize: 13),
                                    // value.reportList![index]['filter_names'],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text("Mobile"),
                                ),
                                Flexible(
                                  child: Text(
                                    ": ${value.companyList[0]["mob"]}",
                                    style: TextStyle(fontSize: 13),
                                    // value.reportList![index]['filter_names'],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.design_services),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text("GST"),
                                ),
                                Flexible(
                                  child: Text(
                                    ": ${value.companyList[0]["gst"]}",
                                    style: TextStyle(fontSize: 13),
                                    // value.reportList![index]['filter_names'],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Icon(Icons.copy_rounded),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.3,
                                  child: Text("Country Code     "),
                                ),
                                Flexible(
                                  child: Text(
                                    ": ${value.companyList[0]["ccode"]}",
                                    style: TextStyle(fontSize: 13),
                                    // value.reportList![index]['filter_names'],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.005,
                            ),
                            widget.type == "drawer call"
                                ? Container()
                                : Text(
                                    widget.msg != ""
                                        ? widget.msg.toString()
                                        : "Company Registration Successfull",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            widget.type == "drawer call" || widget.msg != ""
                                ? Container()
                                : ElevatedButton(
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool("continueClicked", true);
                                      String? userType =
                                          prefs.getString("userType");
                                      print(
                                          "compny deatils userType----$userType");
      
                                      firstMenu = prefs.getString("firstMenu");
                                      print("first---------$firstMenu");
      
                                      if (firstMenu != null) {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .menu_index = firstMenu;
      
                                        print(Provider.of<Controller>(context,
                                                listen: false)
                                            .menu_index);
                                      }
      
                                      String? cid = prefs.getString("cid");
      
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getAreaDetails(
                                              cid!, 0, "company details");
      
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .cid = cid;
      
                                      print("cid-----${cid}");
                                      if (userType == "staff") {
                                        print("stffjknkdf");
      
                                        await OrderAppDB.instance
                                            .deleteFromTableCommonQuery(
                                                "staffDetailsTable", "");
      
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getStaffDetails(
                                                cid, 0, "company details");
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getSettings(context, cid,
                                                "company details");
      
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StaffLogin()),
                                        );
                                      } else if (userType == "admin") {
                                        print("adminjknkdf");
                                        await OrderAppDB.instance
                                            .deleteFromTableCommonQuery(
                                                "userTable", "");
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .getUserType();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StaffLogin()),
                                        );
                                      }
                                    },
                                    child: Text("Continue"),
                                  ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        child: Column(children: [Text("")]),
                      );
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  buildPopupDialog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
      backgroundColor: Colors.white,

              content: Consumer<Controller>(builder: (context, value, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.grey[200],
                      // height: 50,
                      child: DropdownButton<String>(
                        value: selected,
                        // isDense: true,
                        hint: const Text(
                          "Select Branch",
                          style: TextStyle(fontSize: 13),
                        ),
                        // isExpanded: true,
                        autofocus: false,
                        underline: const SizedBox(),
                        elevation: 0,
                        items: value.branch_List
                            .map((item) => DropdownMenuItem<String>(
                                value: item["br_id"].toString(),
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    item["br_name"].toString(),
                                    style: const TextStyle(fontSize: 13),
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
                            // versof = prefs.getString("versof");
                            // Provider.of<Controller>(context, listen: false)
                            //     .getCustomer(genArea!,
                            //         value.settingsList1[0]["set_value"]);
                            // Provider.of<Controller>(context, listen: false)
                            //     .todayOrder(s[0], gen_condition!);
                            // Provider.of<Controller>(context, listen: false)
                            //     .todayCollection(s[0], gen_condition!);
                            // Provider.of<Controller>(context, listen: false)
                            //     .todaySales(s[0], gen_condition!, "");
                            Provider.of<Controller>(context, listen: false)
                                .setDropdowndata(selected!, context);
                            Navigator.pop(context);

                            // var res = await OrderAppDB.instance
                            //     .updateRegistrationtable(
                            //       value.br_addr_map
                            //         );
                          }
                        },
                        child: const Text(
                          "SAVE",
                          style: TextStyle(fontSize: 13),
                        ))
                  ],
                );
              }),
            );
          });
        });
  }
}
