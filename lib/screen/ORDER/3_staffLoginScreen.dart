import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customPopup.dart';
import 'package:salesapp/components/unregister_popup.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:salesapp/screen/ORDER/0_dashnew.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '6_downloadedPage.dart';

class StaffLogin extends StatelessWidget {
  // String? userType;
  // StaffLogin({this.userType});
  DateTime now = DateTime.now();

  String? date;
  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  CustomPopup popup = CustomPopup();
  List<String> result = [];
  String? userType;
  Unreg popupunreg = Unreg();
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<bool> visible = ValueNotifier(false);

  StaffLogin({Key? key}) : super(key: key);

  toggle() {
    visible.value = !visible.value;
  }

  @override
  Widget build(BuildContext context) {
    print("jkcjk------$userType");
    double topInsets = MediaQuery.of(context).viewInsets.top;

    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    print("staff log date $date");
    print("now date $now");
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: P_Settings.wavecolor,
          actions: [
            // IconButton(
            //     onPressed: () async {
            //       await OrderAppDB.instance
            //           .deleteFromTableCommonQuery("userTable", "");
            //       await OrderAppDB.instance
            //           .deleteFromTableCommonQuery("maxSeriesTable", "");
            //     },
            //     icon: Icon(Icons.delete)),
            // IconButton(
            //   onPressed: () async {
            //     List<Map<String, dynamic>> list =
            //         await OrderAppDB.instance.getListOfTables();
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => TableList(list: list)),
            //     );
            //   },
            //   icon: Icon(Icons.table_bar),
            // ),
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  // row has two child icon and text.
                  child: GestureDetector(
                    onTap: () async {
                      print("unregister clickedd");
                      popupunreg.showAlertDialog(context);
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('company_id');
                      await prefs.remove("continueClicked");
                      await prefs.remove("staffLog");
                      // isautodownload = prefs.getBool("isautodownload");
                    },
                    child: Row(
                      children: const [
                        Text("un-register"),
                      ],
                    ),
                  ),
                ),
                // popupmenu item 2
              ],
              offset: const Offset(0, 50),
              // color: Colors.grey,
              elevation: 2,
            ),
          ],
        ),
        body: InkWell(
          // onTap: () {
          //   FocusScope.of(context).requestFocus(FocusNode());
          // },
          child: Form(
            key: _formKey,
            child: Container(
              child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight),
                      child: Container(
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: P_Settings.wavecolor,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 40,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      Text('Login',
                                          style: GoogleFonts.alike(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              fontSize: 28,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    children: <Widget>[
                                      customTextField("Username", controller1,
                                          "staff", context),

                                      customTextField("Password", controller2,
                                          "password", context),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 17.0, right: 17),
                                        child: SizedBox(
                                          height: size.height * 0.06,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  P_Settings.wavecolor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20), // <-- Radius
                                              ),
                                            ),
                                            onPressed: () async {
                                              result.clear();
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              userType =
                                                  prefs.getString("userType");

                                              print("usertype staff $userType");
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                if (userType == "admin") {
                                                  result = await OrderAppDB
                                                      .instance
                                                      .selectUser(
                                                          controller1.text,
                                                          controller2.text);

                                                  if (result.isEmpty) {
                                                    visible.value = true;
                                                    print(
                                                        "visible===${visible.value}");
                                                  } else if (result[0] ==
                                                      "success") {
                                                    visible.value = false;
                                                    final prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    await prefs.setString(
                                                        'sid', result[1]);
                                                    await prefs.setString(
                                                        'st_username',
                                                        controller1.text);
                                                    await prefs.setString(
                                                        'st_pwd',
                                                        controller2.text);
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .areaSelecton = null;
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .areaidFrompopup = null;
                                                    // Provider.of<Controller>(
                                                    //             context,
                                                    //             listen: false).userName=
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Dashboard()),
                                                    );
                                                  }
                                                } else if (userType ==
                                                    "staff") {
                                                  String user =
                                                      controller1.text.trim();
                                                  String pwd =
                                                      controller2.text.trim();

                                                  result = await OrderAppDB
                                                      .instance
                                                      .selectStaff(user, pwd);
                                                  print("selection----$result");
                                                  if (result.isEmpty) {
                                                    visible.value = true;
                                                    print(
                                                        "visible===${visible.value}");
                                                  } else if (result[0] ==
                                                      "success") {
                                                    visible.value = false;
                                                    print(
                                                        "result login......${result[0]}");
                                                    Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .sname =
                                                        controller1.text;

                                                    final prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    await prefs.setString(
                                                        'sid', result[1]);
                                                    await prefs.setString(
                                                        'st_username', user);
                                                    await prefs.setString(
                                                        'st_pwd', pwd);
                                                    print(
                                                        "visible===${visible.value}");
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .insertStaffLogDetails(
                                                            result[1],
                                                            controller1.text,
                                                            date!);
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .areaSelecton = null;
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .areaidFrompopup = null;
                                                    prefs.setBool(
                                                        "staffLog", true);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Dashboard()),
                                                    );
                                                  }

                                                  //  await OrderAppDB.instance.getArea(controller1.text);
                                                }
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: const <Widget>[
                                                Text(
                                                  'LOGIN',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 7, right: 7, top: 25),
                                        child: SizedBox(
                                          height: size.height * 0.07,
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 20,
                                              ),

                                              MaterialButton(
                                                onPressed: () {
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .verifyRegistration(
                                                          context, "");

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DownloadedPage(
                                                                type: "",
                                                                context:
                                                                    context)),
                                                  );
                                                },
                                                color: P_Settings
                                                    .roundedButtonColor,
                                                textColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                shape: const CircleBorder(),
                                                child: Icon(
                                                  Icons.download,
                                                  size: 24,
                                                  color: P_Settings.wavecolor,
                                                ),
                                              ),
                                              //////////////////////////////

                                              MaterialButton(
                                                onPressed: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? cid =
                                                      prefs.getString("cid");
                                                  String? userType = prefs
                                                      .getString("userType");

                                                  if (userType == "admin") {
                                                    await OrderAppDB.instance
                                                        .deleteFromTableCommonQuery(
                                                            "userTable", "");
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .getUserType();
                                                  } else if (userType ==
                                                      "staff") {
                                                    await OrderAppDB.instance
                                                        .deleteFromTableCommonQuery(
                                                            "staffDetailsTable",
                                                            "");
                                                    // await OrderAppDB.instance
                                                    //     .deleteFromTableCommonQuery(
                                                    //         "staffDetailsTable",
                                                    //         "");

                                                    print("staff cid----$cid");

                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .getStaffDetails(
                                                            cid!, 0, "");
                                                  }

                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        popup.buildPopupDialog(
                                                            "",
                                                            context,
                                                            "Details Saved",
                                                            "staffLogin",
                                                            0,
                                                            "",
                                                            "",
                                                            ""),
                                                  );
                                                },
                                                color: P_Settings
                                                    .roundedButtonColor,
                                                textColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                shape: const CircleBorder(),
                                                child: Icon(
                                                  Icons.refresh,
                                                  size: 24,
                                                  color: P_Settings.wavecolor,
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () {
                                                  CustomPopup popu =
                                                      CustomPopup();
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        popup.buildPopupDialog(
                                                            "",
                                                            context,
                                                            "Do you want to exit???",
                                                            "exit",
                                                            0,
                                                            "",
                                                            "",
                                                            ""),
                                                  );
                                                },
                                                color: P_Settings
                                                    .roundedButtonColor,
                                                textColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                shape: const CircleBorder(),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 24,
                                                  color: P_Settings.wavecolor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      ValueListenableBuilder(
                                          valueListenable: visible,
                                          builder: (BuildContext context,
                                              bool v, Widget? child) {
                                            print("value===${visible.value}");
                                            return Visibility(
                                              visible: v,
                                              child: const Text(
                                                "Incorrect Username or Password!!!",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            );
                                          })
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////
  Widget customTextField(String hinttext, TextEditingController controllerValue,
      String type, BuildContext context) {
    double topInsets = MediaQuery.of(context).viewInsets.top;
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: _isObscure,
          builder: (context, value, child) {
            return TextFormField(
              // textCapitalization: TextCapitalization.characters,
              obscureText: type == "password" ? _isObscure.value : false,
              scrollPadding:
                  EdgeInsets.only(bottom: topInsets + size.height * 0.34),
              controller: controllerValue,
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
                  prefixIcon: type == "password"
                      ? const Icon(Icons.password)
                      : const Icon(Icons.person),
                  suffixIcon: type == "password"
                      ? IconButton(
                          icon: Icon(
                            _isObscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            _isObscure.value = !_isObscure.value;
                            print("_isObscure $_isObscure");
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  hintText: hinttext.toString()),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Please Enter $hinttext';
                }
                return null;
              },
            );
          },
        ),
      ),
    );
  }
}

//////////////////////////////
Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
      backgroundColor: Colors.white,

        // title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit from this app'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
