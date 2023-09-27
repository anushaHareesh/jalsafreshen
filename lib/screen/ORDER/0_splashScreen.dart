import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/screen/ADMIN_/adminController.dart';
import 'package:salesapp/screen/ORDER/0_dashnew.dart';
import 'package:salesapp/screen/ORDER/1_companyRegistrationScreen.dart';
import 'package:salesapp/screen/ORDER/2_companyDetailsscreen.dart';
import 'package:salesapp/screen/ORDER/3_staffLoginScreen.dart';
import 'package:salesapp/screen/ORDER/5_dashboard.dart';
import 'package:salesapp/screen/ORDER/externalDir.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  String? cid;
  String? com_cid;
  String? fp;
  bool? isautodownload;
  String? st_uname;
  String? st_pwd;
  String? userType;
  String? firstMenu;
  String? versof;
  bool? continueClicked;
  bool? staffLog;
  String? dataFile;
  String? os;

  ExternalDir externalDir = ExternalDir();

  navigate() async {
    await Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      cid = prefs.getString("company_id");
      os = prefs.getString("os");
      userType = prefs.getString("user_type");
      st_uname = prefs.getString("st_username");
      versof = prefs.getString("versof");
      st_pwd = prefs.getString("st_pwd");
      firstMenu = prefs.getString("firstMenu");
      com_cid = prefs.getString("cid");
      isautodownload = prefs.getBool("isautodownload");
      continueClicked = prefs.getBool("continueClicked");
      staffLog = prefs.getBool("staffLog");
      print("st-----$st_uname---$st_pwd");
      print("continueClicked..........$staffLog......$continueClicked");

      if (com_cid != null) {
        Provider.of<Controller>(context, listen: false).cid = com_cid;
      }
      if (firstMenu != null) {
        Provider.of<Controller>(context, listen: false).menu_index = firstMenu;

        print(Provider.of<Controller>(context, listen: false).menu_index);
      }
      print("versof----$versof");
      if (versof != "0") {
        Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false, // set to false
                pageBuilder: (_, __, ___) {
                  if (cid != null) {
                    if (continueClicked != null && continueClicked!) {
                      print("continueClicked.............$continueClicked");
                      if (st_uname != null &&
                          st_pwd != null &&
                          staffLog != null &&
                          staffLog!) {
                        return Dashboard();
                      } else {
                        return StaffLogin();
                      }
                    } else {
                      if (os != null && os!.isNotEmpty) {
                        Provider.of<Controller>(context, listen: false)
                            .getCompanyData(context);
                        return CompanyDetails(
                          type: "",
                          msg: "",
                          br_length: 0,
                        );
                      } else {
                        return RegistrationScreen();
                      }
                    }
                  } else {
                    return RegistrationScreen();
                  }
                }));
      }
    });
  }

  shared() async {
    var status = await Permission.storage.status;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fp = prefs.getString("fp");
    print("fingerPrint......$fp");

    if (com_cid != null) {
      Provider.of<AdminController>(context, listen: false)
          .getCategoryReport(com_cid!);
      Provider.of<Controller>(context, listen: false).adminDashboard(com_cid!);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).fetchMenusFromMenuTable();
    Provider.of<Controller>(context, listen: false)
        .verifyRegistration(context, "splash");
    shared();
    navigate();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: P_Settings.wavecolor,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: size.height * 0.4,
            ),
            Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  "asset/logo_black_bg.png",
                )),
          ],
        )),
      ),
    );
  }
}
