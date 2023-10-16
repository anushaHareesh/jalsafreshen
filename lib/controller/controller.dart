import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:salesapp/components/customSnackbar.dart';
import 'package:salesapp/components/sunmi.dart';
import 'package:salesapp/db_helper.dart';
import 'package:salesapp/model/accounthead_model.dart';
import 'package:salesapp/model/productCompany_model.dart';
import 'package:salesapp/model/productUnitsModel.dart';
import 'package:salesapp/model/productsCategory_model.dart';
import 'package:salesapp/model/registration_model.dart';
import 'package:salesapp/model/settings_model.dart';
import 'package:salesapp/model/sideMenu_model.dart';
import 'package:salesapp/model/userType_model.dart';
import 'package:salesapp/model/verify_registrationModel.dart';
import 'package:salesapp/model/wallet_model.dart';
import 'package:salesapp/screen/ADMIN_/adminModel.dart';
import 'package:salesapp/screen/ORDER/2_companyDetailsscreen.dart';
import 'package:salesapp/screen/ORDER/externalDir.dart';
import 'package:salesapp/screen/printing_test/imin_printing_report.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../components/network_connectivity.dart';
import '../components/popupPayment.dart';
import '../model/balanceGet_model.dart';
import '../model/productdetails_model.dart';
import '../model/staffarea_model.dart';
import '../model/staffdetails_model.dart';
import '../screen/ORDER/0_dashnew.dart';
import '../screen/ORDER/test_screen.dart';

class Controller extends ChangeNotifier {
  bool? fromDb;
  int? br_length;
  TextEditingController customertext = TextEditingController();
  String? selectedItem;
  double? package;
  double gross = 0.0;
  double gross_tot = 0.0;
  double roundoff = 0.0;
  double dis_tot = 0.0;
  double saleReportTotal = 0.0;
  double cess_tot = 0.0;
  double tax_tot = 0.0;
  String? selectunit;
  String? branch_name;
  String? selectedBr;
  String? selectedunit_X001;
  bool isCartLoading = false;
  bool prNullvalue = false;
  Map<String, dynamic> printSalesData = {};
  List prUnitSaleListData2 = [];
  double disc_amt = 0.0;
  double net_amt = 0.0;
  double orderNetAmount = 0.0;
  double? calculatedRate;
  double taxable_rate = 0.0;
  bool boolCustomerSet = false;
  double salesTotal = 0.0;
  String? packName;
  double tax = 0.0;
  double cgst_amt = 0.0;
  double cgst_per = 0.0;
  double sgst_amt = 0.0;
  double sgst_per = 0.0;
  double igst_amt = 0.0;
  double igst_per = 0.0;
  double disc_per = 0.0;
  double cess = 0.0;
  bool isLoading = false;
  bool isCompleted = false;
  bool isUpload = false;
  bool filterCompany = false;
  bool salefilterCompany = false;
  bool returnfilterCompany = false;

  String? salefilteredeValue;
  String? returnfilteredeValue;
  Map br_addr_map = {};
  String? filteredeValue;
  bool isAdminLoading = false;
  String? menu_index;
  ExternalDir externalDir = ExternalDir();
  bool isListLoading = false;
  int? selectedTabIndex;
  String? userName;
  String? fromDate;
  String? todate;
  String? selectedAreaId;
  String? selectedUnit;
  CustomSnackbar snackbar = CustomSnackbar();
  bool isSearch = false;
  bool isreportSearch = false;
  String? areaId;
  bool flag = false;
  List<String> gridHeader = [];
  String? areaSelecton;
  String? customer_Name;
  String? customer_Id;
  String? packageSelection;
  int returnCount = 0;
  bool isVisible = false;
  double returnTotal = 0.0;
  bool? noreportdata;
  bool? continueClicked;
  bool? staffLog;
  bool returnprice = false;
  int? shopVisited;
  int? noshopVisited;
  List<bool> selected = [];
  List<bool> isDown = [];
  List<bool> isUp = [];

  List<bool> saleItemselected = [];

  List<bool> filterComselected = [];
  List<bool> returnselected = [];
  List<bool> returnirtemExists = [];
  // Map<String, dynamic> printSalesData = {};
  String? frstDropDown;
  bool isautodownload = false;

  // List<bool> returnSelected = [];

  String? areaidFrompopup;
  String? customerpop;
  List<bool> isExpanded = [];
  List<Today> adminDashboardList = [];
  bool returnqty = false;
  List<bool> isVisibleTable = [];
  List<Map<String, dynamic>> collectionList = [];
  List<Map<String, dynamic>> branch_List = [];

  List<Map<String, dynamic>> queryResult = [];

  List<Map<String, dynamic>> productcompanyList = [];
  List<Map<String, dynamic>> fetchcollectionList = [];
  List<bool> settingOption = [];
  List<Map<String, dynamic>> filterList = [];
  List<Map<String, dynamic>> sortList = [];
  List<Map<String, dynamic>> filteredProductList = [];
  List<Map<String, dynamic>> salefilteredProductList = [];
  List<Map<String, dynamic>> returnfilteredProductList = [];
  List<Map<String, dynamic>> salesitemList2 = [];
  List<Map<String, dynamic>> salesitemListdata2 = [];
  List<Map<String, dynamic>> orderitemList2 = [];
  List<Map<String, dynamic>> orderitemListdata2 = [];
  bool iscollLoading = false;
  // List<Map<String, dynamic>> returnList = [];
  bool filter = false;
  bool isDownloaded = false;
  // String? custmerSelection;
  int? customerCount;
  List<String> tableColumn = [];
  List<Map<String, dynamic>> res = [];
  List<String> tableHistorydataColumn = [];
  // List<Map<String, dynamic>> reportOriginalList1 = [];
  String? editedRate;
  String? order_id;
  String? searchkey;
  String? reportSearchkey;
  String? sname;
  String? sid;
  String? userType;
  String? updateDate;
  String? orderTotal1;
  String? saleTot;
  List<dynamic> orderTotal2 = [];
  String? ordernumber;
  String? cid;
  String? cname;
  int? qtyinc;
  int? quan;
  int? returnqtyinc;
  String? itemRate;
  List<CD> c_d = [];
  List<Map<String, dynamic>> historyList = [];
  List<Map<String, dynamic>> reportOriginalList = [];
  // List<Map<String, dynamic>> settingsList = [];
  List<Map<String, dynamic>> settingsList1 = [];

  List<Map<String, dynamic>> walletList = [];
  List<Map<String, dynamic>> productUnitList = [];
  List productUnit_X001 = [];

  List<Map<String, dynamic>> historydataList = [];
  List<Map<String, dynamic>> staffOrderTotal = [];
  String? area;
  String? splittedCode;
  double amt = 0.0;
  List<CD> data = [];
  double? totalPrice;
  double? returntotalPrice;
  String? totrate;
  String? priceval;
  List<String> areaAutoComplete = [];
  List<Map<String, dynamic>> menuList = [];
  List<Map<String, dynamic>> reportData = [];
  List<Map<String, dynamic>> sumPrice = [];
  List<Map<String, dynamic>> collectionsumPrice = [];
  List<DropdownButton> listDropdown = [];

  String collectionAmount = "0.0";
  String returnAmount = "0.0";
  String ordrAmount = "0.0";
  String salesAmount = "0.0";
  String cashSaleAmt = "0.0";
  String creditSaleAmt = "0.0";

  String? remarkCount;
  String? orderCount;
  String? collectionCount;
  String? salesCount;
  String? ret_count;
  String? cs_cnt;
  String? cs_amt;
  String? cr_cnt;
  String? cr_amt;
  String? can_bill_count;
  String? can_bill_amt;

  List<Map<String, dynamic>> remarkList = [];
  List<Map<String, dynamic>> remarkStaff = [];
  String? firstMenu;
  List<Map<String, dynamic>> listWidget = [];
  List<TextEditingController> controller = [];
  List<TextEditingController> qty = [];
  String? dfcusCode;
  String? dfCusName;
  String? br_id;
  // List<TextEditingController> rateController = [];
  List<TextEditingController> salesqty = [];
  List<TextEditingController> orderqty = [];

  List<TextEditingController> returnsqty = [];
  List<TextEditingController> salesqty_X001 = [];
  List<TextEditingController> salesrate = [];
  List<TextEditingController> orderrate = [];

  List<TextEditingController> salesrate_X001 = [];

  List<TextEditingController> orderrate_X001 = [];

  List<TextEditingController> discount_prercent = [];
  List<TextEditingController> discount_prercent_X001 = [];
  List<TextEditingController> discount_amount = [];
  List<TextEditingController> discount_amount_X001 = [];

  // List<TextEditingController> coconutRate = [];

  List<bool> rateEdit = [];
  String? count;
  int salebagLength = 0;
  String? sof;
  String? versof;
  String? vermsg;
  String? heading;
  String? fp;
  List<Map<String, dynamic>> bagList = [];
  List<Map<String, dynamic>> salebagList = [];
  List<Map<String, dynamic>> returnbagList = [];

  List<Map<String, dynamic>> newList = [];
  // List<Map<String, dynamic>> newList = [];

  List<Map<String, dynamic>> newreportList = [];
  List<Map<String, dynamic>> remarkreportList = [];
  List<Map<String, dynamic>> masterList = [];
  List<Map<String, dynamic>> orderdetailsList = [];
  bool settingsRateOption = false;
  List<Map<String, dynamic>> staffList = [];
  List<Map<String, dynamic>> staffId = [];
  List<Map<String, dynamic>> productName = [];
  List<Map<String, dynamic>> areDetails = [];
  List<Map<String, dynamic>> cmpDetails = [];
  List<Map<String, dynamic>> custmerDetails = [];
  List<Map<String, dynamic>> areaList = [];
  List<Map<String, dynamic>> companyList = [];
  List<Map<String, dynamic>> customerList = [];
  List<Map<String, dynamic>> todayOrderList = [];
  List<Map<String, dynamic>> todayCollectionList = [];
  List<Map<String, dynamic>> todaySalesList = [];
  List<Map<String, dynamic>> copyCus = [];
  List<Map<String, dynamic>> prodctItems = [];
  List<Map<String, dynamic>> ordernum = [];
  List<Map<String, dynamic>> approximateSum = [];
  // List<WalletModal> wallet = [];
  StaffDetails staffModel = StaffDetails();
  UserTypeModel userTypemodel = UserTypeModel();
  Balance balanceModel = Balance();
  AccountHead accountHead = AccountHead();
  StaffArea staffArea = StaffArea();
  ProductDetails proDetails = ProductDetails();
  String? path;
  String? textFile;
  bool? customer_visibility = false;
  String? product_code;

//////////////////////////////REGISTRATION ///////////////////////////
  Future<RegistrationData?> postRegistration(
      String company_code,
      String? fingerprints,
      String phoneno,
      String deviceinfo,
      BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
      print("Text fp...$fingerprints");
      print("company_code.........$company_code");
      // String dsd="helloo";
      String appType = company_code.substring(10, 12);
      print("apptytpe----$appType");
      if (value == true) {
        try {
          Uri url =
              Uri.parse("https://trafiqerp.in/order/fj/get_registration.php");
          Map body = {
            'company_code': company_code,
            'fcode': fingerprints,
            'deviceinfo': deviceinfo,
            'phoneno': phoneno
          };
          print("body----${body}");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          print("body ${body}");
          var map = jsonDecode(response.body);
          print("map register ${map}");
          // print("response ${response}");
          RegistrationData regModel = RegistrationData.fromJson(map);

          userType = regModel.type;
          print("usertype----$userType");
          sof = regModel.sof;
          fp = regModel.fp;
          String? msg = regModel.msg;
          print("fp----- $fp");
          print("sof----${sof}");
          if (sof == "1") {
            if (appType == 'SM') {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("company_id", company_code);
              /////////////// insert into local db /////////////////////
              late CD dataDetails;
              String? fp1 = regModel.fp;
              print("fingerprint......$fp1");
              prefs.setString("fp", fp!);
              // String randoms = getRandomString(2);
              // print("randomhhh----$randoms");
              if (map["os"] == null || map["os"].isEmpty) {
                isLoading = false;
                notifyListeners();
                CustomSnackbar snackbar = CustomSnackbar();
                snackbar.showSnackbar(context, "Series is Missing", "");
              } else {
                String? os = regModel.os;
                regModel.c_d![0].cid;
                cid = regModel.cid;
                cname = regModel.c_d![0].cnme;
                notifyListeners();
                await externalDir.fileWrite(fp1!);
                for (var item in regModel.c_d!) {
                  print("ciddddddddd......$item");
                  c_d.add(item);
                }
                verifyRegistration(context, "");
                await OrderAppDB.instance
                    .deleteFromTableCommonQuery('registrationTable', "");
                await OrderAppDB.instance
                    .deleteFromTableCommonQuery('menuTable', "");
                var res = await OrderAppDB.instance
                    .insertRegistrationDetails(regModel);
                print("inserted ${res}");
                isLoading = false;
                notifyListeners();
                prefs.setString("userType", userType!);
                prefs.setString("cid", cid!);
                prefs.setString("os", os!);
                prefs.setString("cname", cname!);
                String? user = prefs.getString("userType");
                if (map["br"].length > 0) {
                  branch_List.clear();
                  for (var item in map["br"]) {
                    branch_List.add(item);
                  }
                  br_length = branch_List.length;
                  // buildPopupDialog(context);
                }
                int brlen;
                print("fnjdxf----$user");
                if (branch_List.isEmpty || branch_List.length == 0) {
                  brlen = 0;
                  getCompanyData(context);
                } else {
                  brlen = branch_List.length;
                }
                getMaxSerialNumber(os);
                getMenuAPi(cid!, fp1, company_code, context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyDetails(
                            type: "",
                            msg: "",
                            br_length: brlen,
                          )),
                );
              }
            } else {
               isLoading = false;
                notifyListeners();
              CustomSnackbar snackbar = CustomSnackbar();
              snackbar.showSnackbar(context, "Invalid Apk Key", "");
            }
          }
          /////////////////////////////////////////////////////
          if (sof == "0") {
             isLoading = false;
                notifyListeners();
            CustomSnackbar snackbar = CustomSnackbar();
            snackbar.showSnackbar(context, msg.toString(), "");
          }

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  static getRandomString(length, [characterString]) {
    String _chars = characterString ??
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  // buildPopupDialog(
  //   BuildContext context,
  // ) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(
  //             builder: (BuildContext context, StateSetter setState) {
  //           return AlertDialog(
  //               content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 color: Colors.grey[200],
  //                 // height: 50,
  //                 child: DropdownButton<String>(
  //                   value: selectedBr,
  //                   // isDense: true,
  //                   hint: const Text(
  //                     "Select Branch",
  //                     style: TextStyle(fontSize: 13),
  //                   ),
  //                   // isExpanded: true,
  //                   autofocus: false,
  //                   underline: const SizedBox(),
  //                   elevation: 0,
  //                   items: branch_List
  //                       .map((item) => DropdownMenuItem<String>(
  //                           value: item["br_id"].toString(),
  //                           child: SizedBox(
  //                             width: 200,
  //                             child: Text(
  //                               item["br_name"].toString(),
  //                               style: const TextStyle(fontSize: 13),
  //                             ),
  //                           )))
  //                       .toList(),
  //                   onChanged: (item) {
  //                     print("clicked");

  //                     if (item != null) {
  //                       setState(() {
  //                         selectedBr = item;
  //                       });
  //                       print("se;ected---$item");
  //                     }
  //                   },
  //                 ),
  //               ),
  //               ElevatedButton(
  //                   onPressed: () async {
  //                     if (selected != null) {
  //                       setDropdowndata(selectedBr!, context);
  //                       Navigator.pop(context);

  //                       // var res = await OrderAppDB.instance
  //                       //     .updateRegistrationtable(
  //                       //       value.br_addr_map
  //                       //         );
  //                     }
  //                   },
  //                   child: const Text(
  //                     "SAVE",
  //                     style: TextStyle(fontSize: 13),
  //                   ))
  //             ],
  //           ));
  //         });
  //       });
  // }

//////////////////////VERIFY REGISTRATION/////////////////////////////
  Future<RegistrationData?> verifyRegistration(
      BuildContext context, String type) async {
    NetConnection.networkConnection(context).then((value) async {
      String? compny_code;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      compny_code = prefs.getString("company_id");
      String? cid = prefs.getString("cid");
      String? fp = prefs.getString("fp");
      ///////////////// find app version/////////////////////////
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // String version = packageInfo.version;
      // print("App new version $version");
      ///////////////////////////////////////////////////////////
      Map map = {
        '0': compny_code,
        "1": fp,
      };

      List list = [];
      list.add(map);
      var jsonen = jsonEncode(list);
      print("json----$jsonen");
      print("listrrr----$list");
      if (value == true) {
        try {
          Uri url = Uri.parse(" ");
          Map body = {
            'json_result': jsonen,
          };
          // Map test={'json_result':[{"0":"RONPBQ9AAXVO","1":"ssss"}]};
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);

          print("verify--$map");
          VerifyRegistration verRegModel = VerifyRegistration.fromJson(map);
          versof = verRegModel.sof;
          vermsg = verRegModel.error;
          print("vermsg----$vermsg");

          // /////////////////////////////////////////////////////
          print("cid----fp-----$compny_code---$fp");
          if (fp != null && compny_code != null) {
            print("entereddddsd");
            // prefs.setString("versof", versof!);
            // prefs.setString("vermsg", vermsg!);
            print("versofbhg----${vermsg}");
            getCompanyData(context);
            if (versof == "0") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompanyDetails(
                          type: "",
                          msg: vermsg,
                          br_length: br_length,
                        )),
              );
            } else {
              if (type == "splash") {
                getSettings(context, cid!, "");
              }
            }
          }

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  //////////////////////GET MENU////////////////////////////////////////
  Future<RegistrationData?> getMenuAPi(String company_code, String fp,
      String apk_key, BuildContext context) async {
    var res;
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        print("company_code---fp-${company_code}---${fp}..${apk_key}");

        try {
          Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_menu.php");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? br_id1 = prefs.getString("br_id");

          String branch_id;
          if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
            branch_id = " ";
          } else {
            branch_id = br_id1;
          }
          Map body = {
            'apk_key': apk_key,
            'company_code': company_code,
            'fingerprint': fp,
            'br_id': branch_id
          };
          print("body.........$body");
          http.Response response = await http.post(
            url,
            body: body,
          );

          print("bodymenuuuuuu ${body}");
          var map = jsonDecode(response.body);
          print("map menu ${map}");
          SideMenu sidemenuModel = SideMenu.fromJson(map);
          firstMenu = sidemenuModel.first;
          menu_index = firstMenu;
          print("menuitem----${sidemenuModel.menu![0].menu_name}");
          print("firstMenu----$firstMenu");

          prefs.setString("firstMenu", firstMenu!);
          for (var menuItem in sidemenuModel.menu!) {
            print("menuitem----${menuItem.menu_name}");
            res = await OrderAppDB.instance
                .insertMenuTable(menuItem.menu_index!, menuItem.menu_name!);
            // menuList.add(menuItem);
          }
          print("insertion----$res");
          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  /////////////////////////// GET BALANCE ////////////////////////////
  Future<Balance?> getBalance(String? cid, String? code) async {
    print("get balance...............${cid}");
    var restaff;
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_balance.php");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      Map body = {'cid': cid, 'code': code, 'br_id': branch_id};
      http.Response response = await http.post(
        url,
        body: body,
      );

      List map = jsonDecode(response.body);
      print("map ${map}");
      if (map != null) {
        for (var getbal in map) {
          balanceModel = Balance.fromJson(getbal);
        }
      }
      print("inserted staff ${balanceModel.ba}");
      return balanceModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /////////////////////// GET STAFF DETAILS////////////////////////////////
  Future<StaffDetails?> getStaffDetails(
      String cid, int index, String page) async {
    var restaff;
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_staff.php");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      Map body = {'cid': cid, 'br_id': branch_id};
      isDownloaded = true;
      isCompleted = true;
      if (page != "company details") {
        isLoading = true;
        notifyListeners();
      }
      http.Response response = await http.post(
        url,
        body: body,
      );
      List map = jsonDecode(response.body);
      await OrderAppDB.instance
          .deleteFromTableCommonQuery("staffDetailsTable", "");
      print("getStaffDetails...............${map}");

      for (var staff in map) {
        staffModel = StaffDetails.fromJson(staff);
        restaff = await OrderAppDB.instance.insertStaffDetails(staffModel);
      }
      print("inserted staff ${restaff}");
      isDownloaded = false;
      isDown[index] = true;
      if (page != "company details") {
        isLoading = false;
        notifyListeners();
      }
      return staffModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////FETCH MENU TABLE ///////////////////////////////
  fetchMenusFromMenuTable() async {
    var res = await OrderAppDB.instance.selectAllcommon('menuTable', "");

    print("menu from table----$res");
    menuList.clear();

    for (var menu in res) {
      menuList.add(menu);
    }
    print("menuList----${menuList}");

    notifyListeners();
  }

/////////////////GET USER TYPE//////////////////////////////////////
  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cid = prefs.getString("cid");
    print("getuserType...............${cid}");
    var resuser;
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_user.php");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      Map body = {'cid': cid, 'br_id': branch_id};

      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body user ${body}");
      var map = jsonDecode(response.body);
      print("mapuser ${map}");

      for (var user in map) {
        print("user----${user}");
        userTypemodel = UserTypeModel.fromJson(user);
        resuser = await OrderAppDB.instance.insertUserType(userTypemodel);
        // print("inserted ${restaff}");
      }
      print("inserted user ${resuser}");

      /////////////// insert into local db /////////////////////
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

////////////////////// GET STAFF AREA ///////////////////////////////////
  Future<StaffArea?> getAreaDetails(String cid, int index, String page) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_area.php");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      Map body = {'cid': cid, 'br_id': branch_id};
      isDownloaded = true;
      isCompleted = true;
      if (page != "company details") {
        isLoading = true;
        notifyListeners();
      }

      print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body ${body}");
      List map = jsonDecode(response.body);
      print("maparea ${map}");
      await OrderAppDB.instance
          .deleteFromTableCommonQuery('areaDetailsTable', "");

      for (var staffarea in map) {
        print("staffarea----${staffarea.length}");
        staffArea = StaffArea.fromJson(staffarea);
        var staffar =
            await OrderAppDB.instance.insertStaffAreaDetails(staffArea);
        print("inserted ${staffar}");
      }
      isDownloaded = false;
      isDown[index] = true;
      if (page != "company details") {
        isLoading = false;
        notifyListeners();
      }
      // isLoading = false;
      /////////////// insert into local db /////////////////////
      notifyListeners();
      return staffArea;
    } catch (e) {
      print(e);
      return null;
    }
  }

//////////////////////////////////GET ACCOUNT HEADS//////////////////////////////////////
  Future<AccountHead?> getaccountHeadsDetails(
      BuildContext context, String s, String cid, int index) async {
    print("cid...............${cid}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString("userType");
    String? sid = prefs.getString("sid");

    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_achead.php");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      Map body = {'cid': cid, 'br_id': branch_id};

      isDownloaded = true;
      isCompleted = true;
      isLoading = true;
      notifyListeners();
      print("compny----${cid}");
      http.Response response = await http.post(
        url,
        body: body,
      );
      print("body ${body}");
      List map = jsonDecode(response.body);
      print("accnt map ${map}");
      await OrderAppDB.instance
          .deleteFromTableCommonQuery("accountHeadsTable", "");

      for (var ahead in map) {
        print("ahead------${ahead}");
        accountHead = AccountHead.fromJson(ahead);
        var account = await OrderAppDB.instance.insertAccoundHeads(accountHead);
      }

      String? us = await prefs.getString('st_username');
      String? pwd = await prefs.getString('st_pwd');
      if (us != null && pwd != null) {
        if (areaidFrompopup != null) {
          dashboardSummery(sid!, s, areaidFrompopup!, context);
        } else {
          if (userType == "staff") {
            print("satfff");
            dashboardSummery(sid!, s, "", context);
          }
        }
      }
      isDownloaded = false;
      isDown[index] = true;
      isLoading = false;

      notifyListeners();

      // return accountHead;
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////// GET WALLET ///////////////////////////////////////
  Future<WalletModal?> getWallet(BuildContext context, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cid = prefs.getString("cid");
    NetConnection.networkConnection(context).then((value) async {
      // await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
      if (value == true) {
        try {
          Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_wallet.php");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? br_id1 = prefs.getString("br_id");

          String branch_id;
          if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
            branch_id = " ";
          } else {
            branch_id = br_id1;
          }
          Map body = {'cid': cid, 'br_id': branch_id};
          isDownloaded = true;
          isCompleted = true;
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          await OrderAppDB.instance
              .deleteFromTableCommonQuery("walletTable", "");
          var map = jsonDecode(response.body);
          print("map ${map}");
          WalletModal walletModal;
          // walletModal.
          for (var item in map) {
            walletModal = WalletModal.fromJson(item);
            await OrderAppDB.instance.insertwalletTable(walletModal);
            // menuList.add(menuItem);
          }
          isDownloaded = false;
          isDown[index] = true;
          isLoading = false;

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

////////////////////////get settings///////////////////////////////////////
  getSettings(BuildContext context, String cid, String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? cid = prefs.getString("cid");
    NetConnection.networkConnection(context).then((value) async {
      // await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
      if (value == true) {
        try {
          Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_settings.php");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? br_id1 = prefs.getString("br_id");

          String branch_id;
          if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
            branch_id = " ";
          } else {
            branch_id = br_id1;
          }
          Map body = {'cid': cid, 'br_id': branch_id};
          // isDownloaded = true;
          // isCompleted = true;
          // isLoading = true;
          // notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
          );
          var map = jsonDecode(response.body);
          await OrderAppDB.instance
              .deleteFromTableCommonQuery("settingsTable", "");
          print("map ${map}");

          SettingsModel settingsModal;
          // walletModal.
          for (var item in map) {
            settingsModal = SettingsModel.fromJson(item);
            await OrderAppDB.instance.insertsettingsTable(settingsModal);
            // menuList.add(menuItem);
          }
          // isDownloaded = false;
          // isDown[index] = true;
          // isLoading = false;

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  /////////////////////////SAVE RETURN TABLE //////////////////////////////////
  saveReturnDetails(
      String cid, List<Map<String, dynamic>> om, BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("haiii");
          Uri url =
              Uri.parse("https://trafiqerp.in/order/fj/stock_return_save.php");
          isLoading = true;
          notifyListeners();
          // print("body--${body}");
          var mapBody = jsonEncode(om);
          print("mapBody--${mapBody}");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? br_id1 = prefs.getString("br_id");

          String branch_id;
          if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
            branch_id = " ";
          } else {
            branch_id = br_id1;
          }
          var jsonD = jsonDecode(mapBody);

          http.Response response = await http.post(
            url,
            body: {'cid': cid, 'om': mapBody, 'br_id': branch_id},
          );
          print("after");
          var map = jsonDecode(response.body);
          print("response return----${map}");

          for (var item in map) {
            if (item["stock_r_id"] != null) {
              await OrderAppDB.instance.upadteCommonQuery("returnMasterTable",
                  "status='${item["stock_r_id"]}'", "id='${item["id"]}'");
            }
          }
          isLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  ///////////////DASHBOARD DATA ///////////////////////////
  adminDashboard(String cid) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_today.php");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      Map body = {'cid': cid, 'br_id': branch_id};
      isAdminLoading = true;
      // notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );

      print("body ${body}");
      var map = jsonDecode(response.body);
      print("TodayDash  ${map}");
      late Today todayDetails;
      isAdminLoading = false;
      notifyListeners();
      AdminDash admin = AdminDash.fromJson(map);
      heading = admin.caption;
      updateDate = admin.cvalue;

      print("Tffff${admin.today![0].group}");

      prefs.setString("heading", heading!);
      prefs.setString("updateDate", updateDate!);
      adminDashboardList.clear();

      for (var item in admin.today!) {
        adminDashboardList.add(item);
        // print("item-----${item.tileCount}");
      }
      print("TodayDash ${adminDashboardList}");

      notifyListeners();
      // return staffArea;
    } catch (e) {
      print("errordash Data $e");
      return null;
    }
  }

  ///////////////////////GET PRODUCT DETAILS//////////////////////////
  Future<ProductDetails?> getProductDetails(String cid, int index) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_prod.php");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      Map body = {'cid': cid, 'br_id': branch_id};
      print("compny----${cid}");
      isDownloaded = true;
      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );
      await OrderAppDB.instance
          .deleteFromTableCommonQuery("productDetailsTable", "");
      // print("body ${body}");
      List map = jsonDecode(response.body);
      print("productDetailsTable--map ${map}");
      for (var pro in map) {
        proDetails = ProductDetails.fromJson(pro);
        var product =
            await OrderAppDB.instance.insertProductDetails(proDetails);
      }
      isDownloaded = false;
      isDown[index] = true;

      isLoading = false;
      notifyListeners();
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      return null;
    }
  }

  //////////////////ORDER SAVE AND SEND/////////////////////////
  saveOrderDetails(
      String cid, List<Map<String, dynamic>> om, BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("haiii");
          Uri url = Uri.parse("https://trafiqerp.in/order/fj/order_save.php");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? br_id1 = prefs.getString("br_id");

          String branch_id;
          if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
            branch_id = " ";
          } else {
            branch_id = br_id1;
          }
          isLoading = true;
          notifyListeners();
          // print("body--${body}");
          var mapBody = jsonEncode(om);
          print("mapBody order--${mapBody}");

          // var jsonD = jsonDecode(mapBody);
          var body = {'cid': cid, 'om': mapBody, 'br_id': branch_id};
          print("body----------$body");
          http.Response response = await http.post(
            url,
            body: {'cid': cid, 'om': mapBody},
          );

          print("order response.........$response");

          var map = jsonDecode(response.body);
          print("response----${map}");

          for (var item in map) {
            if (item["order_id"] != null) {
              await OrderAppDB.instance.upadteCommonQuery("orderMasterTable",
                  "status='${item["order_id"]}'", "id='${item["id"]}'");
            }
          }
          isLoading = false;

          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  ////////////////////////////////////////////////////////////////////////////
  saveSalesDetails(
      String cid, List<Map<String, dynamic>> om, BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          print("haiii");
          // Uri url = Uri.parse(
          //     "http://192.168.18.128/order app/order/fj/sale_save.php");

          Uri url = Uri.parse("https://trafiqerp.in/order/fj/sale_save.php");
          isLoading = true;
          notifyListeners();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? br_id1 = prefs.getString("br_id");
          var mapBody = jsonEncode(om);
          print("mapBody--${mapBody}");
          String branch_id;
          if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
            branch_id = " ";
          } else {
            branch_id = br_id1;
          }
          // // var jsonD = jsonDecode(mapBody);
          // var body = {
          //   'cid': cid,
          //   'br_id': br_id,
          //   'om': mapBody,
          // };
          // print("body sales ---------$body");
          http.Response response = await http.post(
            url,
            body: {'cid': cid, 'br_id': branch_id, 'om': mapBody},
          );
          print("after-----$response");
          var map = jsonDecode(response.body);
          print("response sales----${map}");
          for (var item in map) {
            if (item["s_id"] != null) {
              print("itemtt----${item["s_id"]}");
              await OrderAppDB.instance.upadteCommonQuery("salesMasterTable",
                  "status = 1", "sales_id='${item["s_id"]}'");
            }
          }
          isLoading = false;
          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

/////////////////////////////GET PRODUCT CATEGORY//////////////////////////////
  Future<ProductsCategoryModel?> getProductCategory(
      String cid, int index) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_cat.php");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      Map body = {'cid': cid, 'br_id': branch_id};
      print("compny----${cid}");
      isDownloaded = true;
      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );
      // print("body ${body}");
      await OrderAppDB.instance
          .deleteFromTableCommonQuery("productsCategory", "");
      List map = jsonDecode(response.body);
      print("map ${map}");
      ProductsCategoryModel category;
      for (var cat in map) {
        category = ProductsCategoryModel.fromJson(cat);
        var product = await OrderAppDB.instance.insertProductCategory(category);
        isDownloaded = false;
        isDown[index] = true;
        isLoading = false;
        notifyListeners();

        // print("inserted ${account}");
      }
      /////////////// insert into local db /////////////////////
      // notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////////////GET COMPANY/////////////////////////////////
  Future<ProductCompanymodel?> getProductCompany(String cid, int index) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_com.php");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      Map body = {'cid': cid, 'br_id': branch_id};
      print("compny----${cid}");
      isDownloaded = true;
      isCompleted = true;
      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );
      await OrderAppDB.instance.deleteFromTableCommonQuery("companyTable", "");
      // print("body ${body}");
      List map = jsonDecode(response.body);
      print("map ${map}");
      ProductCompanymodel productCompany;
      for (var proComp in map) {
        productCompany = ProductCompanymodel.fromJson(proComp);
        var product =
            await OrderAppDB.instance.insertProductCompany(productCompany);
      }
      isDownloaded = false;
      isDown[index] = true;
      isLoading = false;
      notifyListeners();
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///////////////////////////////////////////////////////////////////////////
  Future<ProductCompanymodel?> getProductUnits(String cid, int index) async {
    print("cid...............${cid}");
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_unit.php");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      Map body = {'cid': cid, 'br_id': branch_id};
      print("compny----${cid}");
      isDownloaded = true;
      isCompleted = true;
      isLoading = true;
      notifyListeners();

      http.Response response = await http.post(
        url,
        body: body,
      );
      await OrderAppDB.instance.deleteFromTableCommonQuery("productUnits", "");
      // print("body ${body}");
      List map = jsonDecode(response.body);
      print("productUnits  --- ${map}");
      ProductUnitsModel productUnits;
      for (var prounit in map) {
        productUnits = ProductUnitsModel.fromJson(prounit);
        var product = await OrderAppDB.instance.insertProductUnit(productUnits);
      }
      isDownloaded = false;
      isDown[index] = true;
      isLoading = false;
      notifyListeners();
      /////////////// insert into local db /////////////////////
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////////fetch productunits///////////////////////////////////////////////
  fetchProductUnits(int code) async {
    try {
      productUnitList.clear();
      print("codeeeeeeee   $code");
      var res = await OrderAppDB.instance
          .selectAllcommon('productUnits', "pid='$code'");
      print("unit result..........$res");
      productUnitList.clear();
      for (var item in res) {
        productUnitList.add(item);
        productUnit_X001.add(item);
      }
      print("product length...........${productUnitList.length}");
      print("ProductUnits  ----$productUnit_X001");
      notifyListeners();
    } catch (e) {
      print("error...$e");
      return null;
    }
    print("codecode  ----$code");
  }

  ///////////////////////////////////////////////////////////////////
  packageDataSelection(int code) async {
    // areaSelecton.clear();
    print("code.......$code");
    areaidFrompopup = area;
    List<Map<String, dynamic>> result = await OrderAppDB.instance
        .selectAllcommon('productUnits', "pid='${code}'");
    packageSelection = result[0]["unit_name"];
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString("areaSelectionPopup", areaSelecton!);
    print("unit name...---$packageSelection");
    notifyListeners();
  }

// /////////////////////////////INSERT into SALES bag and master table///////////////////////////////////////////////
  insertToSalesbagAndMaster(
      String os,
      String date,
      String time,
      String customer_id,
      String staff_id,
      String aid,
      double total_price,
      double gross_tot,
      double tax_tot,
      double dis_tot,
      double cess_tot,
      BuildContext context,
      String payment_mode,
      double roundoff,
      String cancel_staff,
      String cancel_time
      // double baserate,
      ) async {
    List<Map<String, dynamic>> om = [];
    print("fhnjdroundoff---$roundoff");
    // String salesOs = "S" + "$os";
    // int sales_id = await OrderAppDB.instance
    //     .getMaxCommonQuery('salesDetailTable', 'sales_id', "os='${os}'");
    int sales_id = await OrderAppDB.instance
        .calculateMaxSeries('${os}', 'salesMasterTable', 'sales_id');
    // print("base rate insert.............$baserate");
    int rowNum = 1;
    print("salebagList length........${salebagList}");
    if (salebagList.length > 0) {
      String billNo = "${os}" + "${sales_id}";
      print("bill no........$total_price");
      var result = await OrderAppDB.instance.insertsalesMasterandDetailsTable(
          sales_id,
          0,
          0.0,
          0.0,
          "",
          "",
          date,
          time,
          os,
          customer_id,
          "",
          billNo,
          staff_id,
          aid,
          0,
          payment_mode.toString(),
          "",
          "",
          rowNum,
          "salesMasterTable",
          "",
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          gross_tot,
          dis_tot,
          tax_tot,
          cess_tot,
          0.0,
          total_price,
          roundoff,
          0,
          0,
          0.0,
          0.0,
          0.0,
          0,
          cancel_staff,
          cancel_time);

      for (var item in salebagList) {
        print("item....$item");
        double gross = item["unit_rate"] * item["qty"];
        await OrderAppDB.instance.insertsalesMasterandDetailsTable(
            sales_id,
            item["qty"],
            item["rate"],
            item["unit_rate"],
            item["code"],
            item["hsn"],
            date,
            time,
            os,
            customer_id,
            "",
            billNo,
            staff_id,
            aid,
            0,
            "",
            "",
            item["unit_name"],
            rowNum,
            "salesDetailTable",
            item["itemName"],
            gross,
            item["discount_amt"],
            item["discount_per"],
            item["tax_amt"],
            item["tax_per"],
            item["cgst_per"],
            item["cgst_amt"],
            item["sgst_per"],
            item["sgst_amt"],
            item["igst_per"],
            item["igst_amt"],
            item["ces_amt"],
            item["ces_per"],
            0.0,
            0.0,
            0.0,
            item["net_amt"],
            0.0,
            item["net_amt"],
            roundoff,
            0,
            0,
            0.0,
            item["baserate"],
            item["package"],
            0,
            cancel_staff,
            cancel_time);
        rowNum = rowNum + 1;
      }
    }

    print("set----$settingsList1");
    if (settingsList1[2]["set_value"] == "YES") {
      uploadSalesData(cid!, context, 0, "comomn popup");
    }
    await OrderAppDB.instance.deleteFromTableCommonQuery(
        "salesBagTable", "os='${os}' AND customerid='${customer_id}'");

    salebagList.clear();
    notifyListeners();
    return sales_id;
  }

  //////////////insert to order master and details///////////////////////
  insertToOrderbagAndMaster(
    String os,
    String date,
    String time,
    String customer_id,
    String user_id,
    String aid,
    double total_price,
    BuildContext context,
  ) async {
    print("hhjk--$os--$date");
    List<Map<String, dynamic>> om = [];
    String ordOs = "O" + "$os";
    int order_id = await OrderAppDB.instance
        .calculateMaxSeries('${ordOs}', 'orderMasterTable', 'order_id');
    print("order max........$order_id");
    int rowNum = 1;
    if (bagList.length > 0) {
      await OrderAppDB.instance.insertorderMasterandDetailsTable(
        "",
        order_id,
        0,
        0.0,
        " ",
        date,
        time,
        ordOs,
        customer_id,
        user_id,
        aid,
        0,
        "",
        rowNum,
        "orderMasterTable",
        total_price,
        0.0,
        0.0,
      );

      for (var item in bagList) {
        print("orderid---$item");
        double rate = double.parse(item["rate"]);
        await OrderAppDB.instance.insertorderMasterandDetailsTable(
          item["itemName"],
          order_id,
          item["qty"],
          rate,
          item["code"],
          date,
          time,
          ordOs,
          customer_id,
          user_id,
          aid,
          0,
          item['unit_name'],
          rowNum,
          "orderDetailTable",
          total_price,
          item["package"],
          item["baserate"],
        );
        rowNum = rowNum + 1;
      }
    }
    print("set----$settingsList1");
    if (settingsList1[1]["set_value"] == "YES") {
      uploadOrdersData(cid!, context, 0, "comomn popup");
    }

    await OrderAppDB.instance.deleteFromTableCommonQuery(
        "orderBagTable", "os='${ordOs}' AND customerid='${customer_id}'");

    bagList.clear();
    notifyListeners();
  }

///////////////////////insertreturnMasterandDetailsTable//////////////////////////////
  insertreturnMasterandDetailsTable(
    String os,
    String date,
    String time,
    String customer_id,
    String user_id,
    String aid,
    double total_price,
    String? refNo,
    String? reason,
    BuildContext context,
  ) async {
    print(
        "values--------$date--$time$customer_id-$user_id--$aid--$total_price--$refNo--$reason--$os");

    int return_id = await OrderAppDB.instance
        .calculateMaxSeries('$os', 'returnMasterTable', 'return_id');
    print("return_id----$return_id");
    int rowNum = 1;
    if (returnbagList.length > 0) {
      await OrderAppDB.instance.insertreturnMasterandDetailsTable(
          "",
          return_id,
          0,
          0.0,
          " ",
          date,
          time,
          os,
          customer_id,
          user_id,
          aid,
          0,
          "",
          rowNum,
          "returnMasterTable",
          total_price,
          reason!,
          refNo!,
          0.0,
          0.0,
          0.0);

      for (var item in returnbagList) {
        print("item---${item["unit"]}");
        // double rate = double.parse(item["rate"]);
        await OrderAppDB.instance.insertreturnMasterandDetailsTable(
            item["itemName"],
            return_id,
            item["qty"],
            double.parse(item["rate"]),
            item["code"],
            date,
            time,
            os,
            customer_id,
            user_id,
            aid,
            0,
            item["unit_name"],
            rowNum,
            "returnDetailTable",
            total_price,
            "",
            "",
            0.0,
            item["baserate"],
            item["package"]);
        rowNum = rowNum + 1;
      }
    }

    print("set------$settingsList1");

    if (settingsList1[0]["set_value"] == "YES") {
      uploadReturnData(cid!, context, 0, "comomn popup");
    }
    returnbagList.clear();
    await OrderAppDB.instance.deleteFromTableCommonQuery(
        "returnBagTable", "os='${os}' AND customerid='${customer_id}'");
    notifyListeners();
  }

  //////////////////staff log details insertion//////////////////////
  insertStaffLogDetails(String sid, String sname, String datetime) async {
    var logdata =
        await OrderAppDB.instance.insertStaffLoignDetails(sid, sname, datetime);
    notifyListeners();
  }

//////////////////////////////////UPDATE ////////////////////
  /////////////////////////////updateqty/////////////////////
  updateQty(String qty, int cartrowno, String customerId, String rate) async {
    List<Map<String, dynamic>> res = await OrderAppDB.instance
        .updateQtyOrderBagTable(qty, cartrowno, customerId, rate);
    print("res-----$res");
    if (res.length >= 0) {
      bagList.clear();
      for (var item in res) {
        bagList.add(item);
      }
      print("re from controller----$res");
      notifyListeners();
    }
  }
//////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////
  returnupdateQty(
      String qty, int cartrowno, String customerId, String rate) async {
    List<Map<String, dynamic>> res = await OrderAppDB.instance
        .updateQtyreturnBagTable(qty, cartrowno, customerId, rate);
    print("res-----$res");
    if (res.length >= 0) {
      returnbagList.clear();
      for (var item in res) {
        returnbagList.add(item);
      }
      print("re from controller----$res");
      notifyListeners();
    }
  }

  ////////////////////////////////////////////////////////////////////
  salesupdateQty(
      String qty, int cartrowno, String customerId, String rate) async {
    print("qtyuuu----$qty");
    List<Map<String, dynamic>> res = await OrderAppDB.instance
        .updateQtySalesBagTable(qty, cartrowno, customerId, rate);
    if (res.length >= 0) {
      salebagList.clear();
      for (var item in res) {
        salebagList.add(item);
      }
      print("re from controller----$res");
      notifyListeners();
    }
  }

  /////////////////// SELECT //////////////////////
  //////////////////////SELECT WALLET ////////////////////////////////////////////////////
  fetchwallet() async {
    walletList.clear();
    var res = await OrderAppDB.instance
        .selectAllcommon('walletTable', "waid not in (-3)");
    for (var item in res) {
      walletList.add(item);
    }
    print("fetch wallet-----$walletList");
  }

  ////////////////////remark selection/////////
  fetchremarkFromTable(String custmerId) async {
    remarkList.clear();
    var res = await OrderAppDB.instance
        .selectAllcommonwithdesc('remarksTable', "rem_cusid='${custmerId}'");

    for (var menu in res) {
      remarkList.add(menu);
    }
    print("remarkList----${remarkList}");

    notifyListeners();
  }

  ///////////////////////FETCH PRODUCT COMPANY LIST ///////////////////////////////////////
  fetchProductCompanyList() async {
    try {
      List<
          Map<String,
              dynamic>> result = await OrderAppDB.instance.executeGeneralQuery(
          "Select '0' comid,'All' comanme union all select comid,comanme from companyTable");
      print("resulttttt.....$result");
      productcompanyList.clear();
      if (result != 0) {
        for (var item in result) {
          productcompanyList.add(item);
        }
      }
      print("executeGeneralQuery---$productcompanyList");
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

///////////////filter company////////////////////////////
  filterwithCompany(String cusId, String comId, String type) async {
    isLoading = true;
    List<Map<String, dynamic>> result = [];
    // notifyListeners();
    // List<Map<String, dynamic>> result = await OrderAppDB.instance
    //     .selectAllcommon('productDetailsTable', "companyId='${comId}'");
    if (type == "sale order") {
      filterCompany = true;

      result =
          await OrderAppDB.instance.selectfrombagandfilterList(cusId, comId);
      filteredProductList.clear();
      for (var item in result) {
        filteredProductList.add(item);
      }
      var length = filteredProductList.length;
      print("filter list length.........$length");
      filterComselected = List.generate(length, (index) => false);
      print("filteredProductList--$filteredProductList");
    }
    if (type == "sales") {
      salefilterCompany = true;

      result = await OrderAppDB.instance
          .selectfromsalesbagandfilterList(cusId, comId);
      salefilteredProductList.clear();
      for (var item in result) {
        salefilteredProductList.add(item);
      }
      var length = salefilteredProductList.length;
      print("filter list length.........$length");
      filterComselected = List.generate(length, (index) => false);
      print("filteredProductList--$salefilteredProductList");
    }
    if (type == "return") {
      returnfilterCompany = true;

      result = await OrderAppDB.instance
          .selectfromreturnbagandfilterList(cusId, comId);
      returnfilteredProductList.clear();
      for (var item in result) {
        returnfilteredProductList.add(item);
      }
      var length = returnfilteredProductList.length;
      print("filter list length.........$length");
      filterComselected = List.generate(length, (index) => false);
      print("filteredProductList--$returnfilteredProductList");
    }

    print("products filter-----$result");

    isLoading = false;
    notifyListeners();
  }

///////////////////////////////////////////////////////
  getCompanyData(BuildContext context) async {
    try {
      isLoading = true;
      // notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cid = prefs.getString("cid");
      print('cojhkjd---$cid');
      var res = await OrderAppDB.instance.selectCompany("cid='${cid}'");
      print("res companyList----${res}");
      for (var item in res) {
        companyList.add(item);
      }
      print("companyList ----${companyList}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }

    notifyListeners();
  }

  ///////////////////////GET AREA///////////////////////////////
  getArea(String? sid) async {
    String areaName;
    print("staff...............${sid}");
    try {
      areaList = await OrderAppDB.instance.getArea(sid!);
      print("areaList----${areaList}");
      print("areaList before ----${areDetails}");
      areDetails.clear();

      for (var item in areaList) {
        areDetails.add(item);
      }

      print("areaList adding ----${areDetails}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  /////////////////////GET CUSTOMER////////////////////////////////
  getCustomer(String? aid) async {
    String arid;
    print("aid...............${aid}");
    try {
      print("custmerDetails after clear----${custmerDetails}");
      custmerDetails.clear();
      if (aid == null) {
        arid = ' ';
      } else {
        arid = aid;
      }
      customerList = await OrderAppDB.instance.getCustomer(arid);
      print("customerList----${customerList}");
      for (var item in customerList) {
        custmerDetails.add(item);
      }
      print("custmr length----${custmerDetails.length}");
      print("custmerDetails adding $custmerDetails");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  ////////////////////////////////////////
  setCustomerName(String? cusName) {
    customer_Name = cusName;
    print("customer name.controller...$cusName..$customer_Name");
    boolCustomerSet = true;
    notifyListeners();
  }

  //////////////////////GET PRODUCT LIST/////////////////////////////////
  getProductList(String customerId) async {
    print("haii---");
    int flag = 0;
    productName.clear();

    try {
      isLoading = true;
      // notifyListeners();
      prodctItems =
          await OrderAppDB.instance.selectfromOrderbagTable(customerId);
      print("product item list in orderlist----${prodctItems}");
      productName.clear();
      for (var item in prodctItems) {
        productName.add(item);
      }
      var length = productName.length;
      print("product namess.......$productName");
      print("text length----$length");
      qty = List.generate(length, (index) => TextEditingController());
      selected = List.generate(length, (index) => false);

      for (int i = 0; i < productName.length; i++) {
        if (productName[i]["qty"] != null) {
          qty[i].text = productName[i]["qty"].toString();
        } else {
          qty[i].text = "1";
        }

        print("quantity innnnn............$qty");
      }
      // rateController =
      //     List.generate(length, (index) => TextEditingController());

      returnselected = List.generate(length, (index) => false);
      returnirtemExists = List.generate(length, (index) => false);

      isLoading = false;
      notifyListeners();
      print("product name bag----${productName}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

//////////////////////////////////////////////////////////
  getreturnList(String customerId, String postiion) async {
    print("haii---$customerId");
    int flag = 0;
    productName.clear();

    try {
      isLoading = true;
      // notifyListeners();
      prodctItems =
          await OrderAppDB.instance.selectfromreturnbagTable(customerId);
      print("product item list in orderlist----${prodctItems}");
      productName.clear();
      for (var item in prodctItems) {
        productName.add(item);
      }
      var length = productName.length;
      print("product namess.......$productName");
      print("text length----$length");
      qty = List.generate(length, (index) => TextEditingController());
      selected = List.generate(length, (index) => false);

      for (int i = 0; i < productName.length; i++) {
        if (productName[i]["qty"] != null) {
          qty[i].text = productName[i]["qty"].toString();
        } else {
          qty[i].text = "0";
        }

        print("quantity innnnn............$qty");
      }
      returnselected = List.generate(length, (index) => false);
      returnirtemExists = List.generate(length, (index) => false);

      isLoading = false;
      notifyListeners();
      print("product name return----${productName}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }
  /////////////////////////////////////////////////////////
  // getreturnList(String customerId, String postiion) async {
  //   print("haii---");
  //   int flag = 0;
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //     if (postiion == "orderform") {
  //       prodctItems = await OrderAppDB.instance
  //           .selectAllcommon("productDetailsTable", '');
  //     } else {
  //       prodctItems =
  //           await OrderAppDB.instance.selectfromreturnbagTable(customerId);
  //     }

  //     print("prodctItemsdfddfd----${prodctItems.length}");
  //     productName.clear();

  //     for (var item in prodctItems) {
  //       productName.add(item);
  //     }
  //     var length = productName.length;
  //     qty = List.generate(length, (index) => TextEditingController());
  //     selected = List.generate(length, (index) => false);
  //     print("selected-------$qty--$selected");

  //     // returnselected = List.generate(length, (index) => false);
  //     // returnirtemExists = List.generate(length, (index) => false);
  //     isLoading = false;
  //     notifyListeners();
  //     print("product name-return---${productName}");

  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  //   notifyListeners();
  // }

/////////////////////////////////////////////////////////////////
  getSaleProductList(String customerId) async {
    print("customer id......$customerId");
    print("haii---");
    int flag = 0;
    productName.clear();
    try {
      isLoading = true;
      // notifyListeners();
      prodctItems =
          await OrderAppDB.instance.selectfromsalebagTable(customerId);
      print("prodctItems-salesbag---${prodctItems}");
      productName.clear();
      for (var i in prodctItems) {
        productName.add(i);
      }
      var length = productName.length;
      print("product item listttttt....................${productName}");

      print("text length-------$length");
      qty = List.generate(length, (index) => TextEditingController());
      // coconutRate = List.generate(length, (index) => TextEditingController());
      // listDropdown=List.generate(length, (index) => DropdownButton())
      selected = List.generate(length, (index) => false);
      // returnselected = List.generate(length, (index) => false);
      for (int i = 0; i < productName.length; i++) {
        if (productName[i]["qty"] != null || productName[i]["qty"] == 0) {
          qty[i].text = productName[i]["qty"].toString();
        } else {
          qty[i].text = "0";
          // notifyListeners();
        }
        print("new quantity-------${qty[i].text}");
      }
      // for (int i = 0; i < productName.length; i++) {
      //   coconutRate[i].text = productName[i]['prrate1'].toString();
      // }
      isLoading = false;
      notifyListeners();
      print("product name----${productName}");

      notifyListeners();
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return productName;
  }

//////////////////GET ORDER NUMBER///////////////////////////////////
  getOrderno() async {
    try {
      ordernum = await OrderAppDB.instance.getOrderNo();
      print("ordernum----${ordernum}");

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  ///////////////GET BAG DETAILS/////////////////////
  getBagDetails(String customerId, String os) async {
    bagList.clear();
    isLoading = true;
    notifyListeners();
    // String oos="O"+"$os";

    List<Map<String, dynamic>> res =
        await OrderAppDB.instance.getOrderBagTable(customerId, os);

    for (var item in res) {
      bagList.add(item);
    }
    notifyListeners();

    rateEdit = List.generate(bagList.length, (index) => false);

    print("bagggg-------$bagList");
    // rateController =
    //     List.generate(bagList.length, (index) => TextEditingController());
    orderqty =
        List.generate(bagList.length, (index) => TextEditingController());
    orderrate =
        List.generate(bagList.length, (index) => TextEditingController());
    for (int i = 0; i < bagList.length; i++) {
      orderrate[i].text = bagList[i]["rate"];
      orderqty[i].text = bagList[i]["qty"].toString();
    }

    generateTextEditingController("sale order");
    print("bagList vxdvxd----$bagList");

    isLoading = false;
    notifyListeners();
    return bagList;
  }

//////////////////////////////////////////////////////
  getSaleBagDetails(String customerId, String os, String type,
      BuildContext context, String areaId, String areaName) async {
    PaymentSelect paysheet = PaymentSelect();

    String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    List<String> s = date.split(" ");
    print("customer id sale .................$customerId...$os");
    salebagList.clear();

    isCartLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> res =
        await OrderAppDB.instance.getSaleBagTable(customerId, os);
    for (var item in res) {
      salebagList.add(item);
    }
    salebagLength = salebagList.length;
    notifyListeners();

    print("salebagList innnnnsale----$salebagList");

    rateEdit = List.generate(salebagList.length, (index) => false);
    salesqty =
        List.generate(salebagList.length, (index) => TextEditingController());
    salesrate =
        List.generate(salebagList.length, (index) => TextEditingController());
    discount_prercent =
        List.generate(salebagList.length, (index) => TextEditingController());
    discount_amount =
        List.generate(salebagList.length, (index) => TextEditingController());

    generateTextEditingController("sales");
    print("salebagList vxdvxd----$salebagList");
    if (type == "from save") {
      if (salebagLength > 0) {
        print("value.salnjjjj-----}");
        paysheet.showpaymentSheet(context, areaId, areaName, customerId, s[0],
            s[1], " ", " ", orderTotal2[11]);
      }
    }

    isCartLoading = false;
    notifyListeners();
    return salebagList;
  }

////////////////////////////////////////////////////////////////////
  getreturnBagDetails(String customerId, String os) async {
    print("customer id sale .................$customerId...$os");

    isLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> res =
        await OrderAppDB.instance.getreturnBagTable(customerId, os);
    returnbagList.clear();
    for (var item in res) {
      returnbagList.add(item);
    }
    // rateEdit = List.generate(salebagList.length, (index) => false);
    returnsqty =
        List.generate(returnbagList.length, (index) => TextEditingController());

    generateTextEditingController("return");
    print("returnbagList vxdvxd----$returnbagList");

    isLoading = false;
    notifyListeners();
    return returnbagList;
  }

  ////////////////////GET HISTORY DATA/////////////////////////
  getSaleHistoryData(String table, String? condition) async {
    isLoading = true;
    print("haiiii");
    historydataList.clear();
    tableHistorydataColumn.clear();
    List<Map<String, dynamic>> result =
        await OrderAppDB.instance.todaySaleHistory(table, condition);

    for (var item in result) {
      historydataList.add(item);
    }
    print("historydataList----$historydataList");
    var list = historydataList[0].keys.toList();
    print("**list----$list");
    for (var item in list) {
      print(item);
      tableHistorydataColumn.add(item);
    }
    isLoading = false;
    notifyListeners();

    notifyListeners();
  }

/////////////////////////////////////////////////////////////////
  getHistoryData(String table, String? condition) async {
    isLoading = true;
    print("haiiii");
    historydataList.clear();
    tableHistorydataColumn.clear();
    List<Map<String, dynamic>> result =
        await OrderAppDB.instance.selectCommonQuery(table, condition);

    for (var item in result) {
      historydataList.add(item);
    }
    print("historydataList----$historydataList");
    var list = historydataList[0].keys.toList();
    print("**list----$list");
    for (var item in list) {
      print(item);
      tableHistorydataColumn.add(item);
    }
    isLoading = false;
    notifyListeners();

    notifyListeners();
  }

  /////////////////SELCT TOTAL ORDER FROM MASTER TABLE///////////
  getOrderMasterTotal(String table, String? condition) async {
    print("inside select data");

    List<Map<String, dynamic>> result =
        await OrderAppDB.instance.selectAllcommon(table, condition);
    print("resulttttt.....$result");
    if (result != 0) {
      for (var item in result) {
        staffOrderTotal.add(item);
      }
    }

    print("staff order total........$staffOrderTotal");
    notifyListeners();
  }
  // selectedSet() {
  //   var length = productName.length;
  //   qty = List.generate(length, (index) => TextEditingController());

  //   selected = List.generate(length, (index) => false);
  // }
////////////////////////////GET SHOP VISITED//////////////////////////////////////
  // getShopVisited(String userId, String date) async {
  //   shopVisited = await OrderAppDB.instance.getShopsVisited(userId, date);
  //   var res = await OrderAppDB.instance.countCustomer(areaidFrompopup);
  //   print("col--ret-- $collectionCount--$orderCount--$remarkCount--$ret_count");
  //   if (res != null) {
  //     customerCount = res.length;
  //   }
  //   if (collectionCount == 0 &&
  //       orderCount == 0 &&
  //       remarkCount == null &&
  //       ret_count == null) {
  //     print("collection--");
  //     noshopVisited = customerCount;
  //   } else {
  //     noshopVisited = customerCount! - shopVisited!;
  //   }
  //   notifyListeners();
  // }

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  setCname() async {
    final prefs = await SharedPreferences.getInstance();
    String? came = prefs.getString("cname");
    cname = came;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////
  setSname() async {
    final prefs = await SharedPreferences.getInstance();
    String? same = prefs.getString("st_username");

    sname = same;
    notifyListeners();
  }

  customerListClear() {
    customerList.clear();
    notifyListeners();
  }

  setSplittedCode(String splitted) {
    splittedCode = splitted;
    notifyListeners();
  }

  ////////////////////////////////
  generateTextEditingController(String type) {
    var length;
    if (type == "sale order") {
      length = bagList.length;
    }
    if (type == "sales") {
      length = salebagList.length;
    }
    if (type == "return") {
      length = returnbagList.length;
    }
    print("text length----$length");
    controller = List.generate(length, (index) => TextEditingController());
    print("length----$length");
    // notifyListeners();
  }

/////////////////////////////////////////////////////////////
  Future<dynamic> setStaffid(String sname) async {
    print("Sname.............$sname");
    try {
      ordernum = await OrderAppDB.instance.setStaffid(sname);
      print("ordernum----${ordernum}");

      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////

  deleteFromOrderBagTable(int cartrowno, String customerId, int index) async {
    print("cartrowno--$cartrowno--index----$index");
    List<Map<String, dynamic>> res = await OrderAppDB.instance
        .deleteFromOrderbagTable(cartrowno, customerId);

    bagList.clear();
    for (var item in res) {
      bagList.add(item);
    }
    print("after delete------$res");
    controller.removeAt(index);
    print("controllers----$controller");
    generateTextEditingController("sale order");
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////
  deleteFromreturnBagTable(int cartrowno, String customerId, int index) async {
    print("cartrowno--$cartrowno--index----$index");
    List<Map<String, dynamic>> res = await OrderAppDB.instance
        .deleteFromreturnbagTable(cartrowno, customerId);

    returnbagList.clear();
    for (var item in res) {
      returnbagList.add(item);
    }
    print("after delete------$res");
    controller.removeAt(index);
    print("controllers----$controller");
    generateTextEditingController("return");
    notifyListeners();
  }

/////////////////////////////////////////////////////////////
  deleteFromSalesBagTable(
    String customerId,
  ) async {
    print("cartrowno--$customerId");
    List<Map<String, dynamic>> res =
        await OrderAppDB.instance.deleteFromSalesagTable(customerId);

    bagList.clear();
    for (var item in res) {
      bagList.add(item);
    }
    print("after delete------$res");
    // controller.removeAt(index);
    print("controllers----$controller");
    generateTextEditingController("sales");
    notifyListeners();
  }

  ////////////// update remarks /////////////////////////////
  // updateRemarks(String customerId, String remark) async {
  //   print("remark.....${customerId}${remark}");
  //   // res = await OrderAppDB.instance.updateRemarks(customerId, remark);
  //   if (res != null) {
  //     for (var item in res) {
  //       remarkList.add(item);
  //     }
  //   }

  //   print("re from controller----$res");
  //   notifyListeners();
  // }
  //////////////////// CALCULATION ///////////////////////////
  calculateorderTotal(String os, String customerId) async {
    orderTotal1 = await OrderAppDB.instance.gettotalSum(os, customerId);
    print("orderTotal1---$orderTotal1");
    notifyListeners();
  }

  calculatereturnTotal(String os, String customerId) async {
    String s = await OrderAppDB.instance.getreturntotalSum(os, customerId);
    returnTotal = double.parse(s);
    print("returnTotal---$returnTotal");
    notifyListeners();
  }

  /////////calculate total////////////////
  calculatesalesTotal(String os, String customerId) async {
    try {
      print("calculate sales updated tot....$os...$customerId");
      List res = await OrderAppDB.instance.getsaletotalSum(os, customerId);
      print("respongtyht...........$res");
      double sTotal = double.parse(res[0]);
      gross_tot = double.parse(res[5]);
      tax_tot = res[9];
      cess_tot = double.parse(res[4]);
      // print("result sale...${res[3].runtimeType}");
      dis_tot = double.parse(res[3]);
      print("result sale...${res[10].runtimeType}");
      roundoff = res[10];
      print("result sale.22..${roundoff}");

      salesTotal = roundoff + sTotal;

      print(
          "result sal-----......$roundoff....${salesTotal}----${gross_tot}---${tax_tot}---${cess_tot}--${dis_tot}");

      print("salesTotal---$salesTotal");
      notifyListeners();
      orderTotal2.clear();
      if (res.length > 0) {
        for (var item in res) {
          print("sfhdsj----$item");

          orderTotal2.add(item);
        }
      }
      print("orderTotal2.....$orderTotal2");
      notifyListeners();
    } catch (e) {
      print(e);
    }
    // return res[0];
  }

/////////////////////////////////////////////////
  calculateAmt(String rate, String _controller) {
    amt = double.parse(rate) * double.parse(_controller);
    // notifyListeners();
  }

  // calculatereturnTotal() async {
  //   returnTotal = 0;
  //   for (int i = 0; i < returnList.length; i++) {
  //     print(" returnList[i]-${returnList[i]["total"]}");
  //     returnTotal = returnTotal + double.parse(returnList[i]["total"]);
  //   }

  //   print("orderTotal---$returnTotal");
  //   // notifyListeners();
  // }

  ////////////////count from table///////
  countFromTable(String table, String os, String customerId) async {
    isLoading = true;
    // notifyListeners();
    print("table--customerId-$table-$customerId--$os");
    count = await OrderAppDB.instance
        .countCommonQuery(table, "os='${os}' AND customerid='${customerId}'");
    print("count..............$count");
    isLoading = false;

    notifyListeners();
  }

///////////////////////////////////////////////////////////////
  // countQty(String table) async {
  //   isLoading = true;
  //   // notifyListeners();
  //   // print("table--customerId-$table);
  //   qtyup = await OrderAppDB.instance.countCommonQuery(table, " ");
  //   print("qtyup..............$qtyup");
  //   isLoading = false;

  //   notifyListeners();
  // }

///////////////////////////////////////////////////////////////////////////
  qtyIncrement() {
    qtyinc = 1 + qtyinc!;
    print("qty increment-----$qtyinc");
    notifyListeners();
  }

  // int qtyup = 0;
  // qtyups(int index) {
  //   qtyup = 1 + qtyup;
  //   qty[index].text = qtyup.toString();
  //   notifyListeners();
  // }

  returnqtyIncrement() {
    returnqty = true;
    returnqtyinc = 1 + returnqtyinc!;
    print("qty-----$returnqtyinc");
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////
  qtyDecrement() {
    returnqty = true;
    qtyinc = qtyinc! - 1;
    print("qty-----$qtyinc");
    notifyListeners();
  }

  // int qtyup = 0;
  qtyups(int index, String table, String itemcode, String customerId,
      String os) async {
    String quan;
    var qtyup = await OrderAppDB.instance.countqty(table,
        "code='${itemcode}' AND customerid='${customerId}' AND os='${os}' ");
    print("quantity update.............$qtyup");
    quan = qtyup;
    print("qyu............$quan");
    // qtyup = 1 + qtyup;
    qty[index].text = quan;
    notifyListeners();
  }

  returnqtyDecrement() {
    returnqtyinc = returnqtyinc! - 1;
    print("qty-----$qtyinc");
    notifyListeners();
  }

  /////////////////////////////////////////////////
  setIssearch(bool issearch) {
    isSearch = issearch;
    notifyListeners();
  }

  setreportsearch(bool issearch) {
    isreportSearch = issearch;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////
  setQty(double qty) {
    qtyinc = qty.toInt();
    print("qty.......$qty");
    // notifyListeners();
  }

  setreturnQty(int qty) {
    returnqtyinc = qty;
    // notifyListeners();
  }

/////////////////////
  setPrice(String rate) {
    totrate = rate;
    print("rate.$rate");
    notifyListeners();
  }

  ///////////////////////////////////
  setAmt(
    String price,
  ) {
    totalPrice = double.parse(price);
    priceval = double.parse(price).toStringAsFixed(2);
    // notifyListeners();
  }

  setreturnAmt(
    String price,
  ) {
    returntotalPrice = double.parse(price);
    priceval = double.parse(price).toStringAsFixed(2);
    print("priceval........$returntotalPrice...$priceval");
    // notifyListeners();
  }

  totalCalculation(String rate) {
    totalPrice = double.parse(rate) * qtyinc!;
    priceval = totalPrice!.toStringAsFixed(2);
    print("total pri-----$totalPrice");
    notifyListeners();
  }

  returntotalCalculation(String rate) {
    returnprice = true;
    returntotalPrice = double.parse(rate) * returnqtyinc!;
    priceval = returntotalPrice!.toStringAsFixed(2);
    print("total pri-----$returntotalPrice.....$priceval");
    notifyListeners();
  }

  setisVisible(bool isvis) {
    isVisible = isvis;
    notifyListeners();
  }

  ////////////////////////////////////////////////////
  editRate(String rate, int index) {
    rateEdit[index] = true;
    editedRate = rate;
    notifyListeners();
  }

  generateEditRateList() {
    var length = bagList.length;
    List.generate(length, (index) => false);
    // notifyListeners();
  }

  ///////////////////////////////////////////////////////
  setSettingOption(int length) {
    settingOption = List.generate(length, (index) => false);
    notifyListeners();
  }
////////////////////////////////Remarks/////////////////////////////////////
  // insertRemarks(String date, String Cus_id, String ser, String text,
  //     String sttid, String cancel, String status) async {
  //   var logdata =
  //       await OrderAppDB.instance.insertremarkTable(date, Cus_id, ser, text,sttid,cancel,status);
  //   notifyListeners();
  // }
  ///////////////////////////////////////////////////////////////////////
  // downloadAllPages(String cid) async {
  //   isLoading = true;
  //   print("isloaading---$isLoading");
  //   notifyListeners();
  //   // getaccountHeadsDetails(cid, "all");
  //   getProductCategory(cid, "all");
  //   getProductCompany(cid, "all");
  //   // getProductDetails(cid, "all");
  //   isLoading = false;
  //   print("isloaading---$isLoading");

  //   notifyListeners();
  // }

  //////////////////////TODAY COLLECTION AND ORDER//////////////////////////////////////////
  Future<dynamic> todayOrder(String date, String? condition) async {
    isLoading = true;
    print("haiiii");
    var result = await OrderAppDB.instance.todayOrder(date, condition!);
    print("aftr cut----$result");
    todayOrderList.clear();

    if (result != null) {
      for (var item in result) {
        todayOrderList.add(item);
      }
      isExpanded = List.generate(todayOrderList.length, (index) => false);
      isVisibleTable = List.generate(todayOrderList.length, (index) => false);
    }

    print("todayOrderList----$todayOrderList");
    isLoading = false;
    notifyListeners();
  }

  ///////////////////////////////////////////////
  Future<dynamic> todayCollection(String date, String condition) async {
    iscollLoading = true;
    print("haiiii");
    print("contrler date----$date");
    var result = await OrderAppDB.instance.todayCollection(date, condition);

    print("aftr cut----$result");
    todayCollectionList.clear();
    if (result != null) {
      for (var item in result) {
        todayCollectionList.add(item);
      }
      isExpanded = List.generate(todayCollectionList.length, (index) => false);
      isVisibleTable =
          List.generate(todayCollectionList.length, (index) => false);
    }

    print("todayCollectionList----$todayCollectionList");
    iscollLoading = false;
    notifyListeners();
  }

///////////////////////// today sales ///////////////////
  Future<dynamic> todaySales(String date, String condition, String type) async {
    isLoading = true;
    print("haiiii");
    print("contrler date--$condition--$type");
    var result = await OrderAppDB.instance.todaySales(date, condition, type);
    print("today sale report---$result");
    todaySalesList.clear();

    if (result != null) {
      print("fhjhf");
      for (var item in result) {
        DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(item["Date"]);
        String date1 = DateFormat('dd-MM-yyyy').format(tempDate);
        Map<String, dynamic> map1 = {
          "cus_name": item["cus_name"],
          "ba": item["ba"],
          "gstin": item["gstin"],
          "sales_id": item["sales_id"],
          "roundoff": item["roundoff"],
          "sale_Num": item["sale_Num"],
          "Cus_id": item["Cus_id"],
          "Date": date1,
          "count": item["count"],
          "grossTot": item["grossTot"],
          "payment_mode": item["payment_mode"],
          "creditoption": item["creditoption"],
          "net_amt": item["net_amt"],
          "taxtot": item["taxtot"],
          "distot": item["distot"],
          "cancel": item["cancel"]
        };
        todaySalesList.add(map1);
      }
      print("today sales date ----$todaySalesList");
      saleReportTotal = 0.0;

      for (int i = 0; i < todaySalesList.length; i++) {
        saleReportTotal = saleReportTotal + todaySalesList[i]["net_amt"];
      }

      isExpanded = List.generate(todaySalesList.length, (index) => false);
      isVisibleTable = List.generate(todaySalesList.length, (index) => false);
    } else {
      saleReportTotal = 0.0;
    }

    isLoading = false;
    notifyListeners();
  }

//////////////////////////////////////////////////////////
  selectReportFromOrder(BuildContext context, String userId, String date,
      String likeCondition) async {
    print("report userId----$userId");
    reportOriginalList.clear();
    Map map = {};
    isLoading = true;
    // notifyListeners();
    var res = await OrderAppDB.instance
        .getReportDataFromOrderDetails(userId, date, context, likeCondition);

    print("result-cxc----$res");
    reportData.clear();
    if (res != null && res.length > 0) {
      for (var item in res) {
        reportData.add(item);
      }
    } else {
      noreportdata = true;

      // notifyListeners();
      // snackbar.showSnackbar(context, "please download customers !!!");
    }
    print('report data----${reportData}');
    isLoading = false;
    notifyListeners();
  }

  /////////////////////////////////////////////
  ////////////////// remark from filter //////////////
  //  setRemarkfilterReports(String remark, String  remarked) {
  //   isLoading = true;
  //   notifyListeners();
  //   if (fltrType == "balance") {
  //     filterList = reportData.where((element) {
  //       //  print('${element["bln"].runtimeType}') ;
  //       return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //       // return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //     }).toList();
  //     isLoading = false;

  //     notifyListeners();
  //   }
  //   if (fltrType == "order amount") {
  //     filterList = reportData.where((element) {
  //       //  print('${element["bln"].runtimeType}') ;
  //       return (element["order_value"] > minPrice &&
  //           element["order_value"] < maxPrice);
  //       // return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //     }).toList();
  //     isLoading = false;

  //     notifyListeners();
  //   }
  //   print("filters-----$filterList");
  //   notifyListeners();
  // }

  ///////////////////////////////////////////////////////
  setDateFilter(String fromDate, String toDate) {
    print("remarked......$fromDate $toDate");
  }

  /////////////////////////////////////////////
  searchfromreport(BuildContext context, String userId, String date) async {
    print("searchkey----$reportSearchkey");

    if (reportSearchkey!.isEmpty) {
      // isreportSearch = false;
      newreportList = reportData;
    } else {
      print("re----${reportData.length}");
      // newreportList.clear();
      newreportList = await OrderAppDB.instance.getReportDataFromOrderDetails(
          userId, date, context, " A.hname LIKE '$reportSearchkey%' ");
      print("newreportList-----$newreportList");

      // newreportList = reportData
      //     .where((element) => element["name"]
      //         .toLowerCase()
      //         .contains(reportSearchkey!.toLowerCase()))
      //     .toList();

      notifyListeners();
    }
  }

///////////////// dashboard summery /////////////
  Future<dynamic> dashboardSummery(
      String sid, String date, String aid, BuildContext context) async {
    print("stafff  iddd $sid");
    double d1 = 0.0;
    double d = 0.0;
    double d2 = 0.0;
    double d4 = 0.0;

    var res = await OrderAppDB.instance.dashboardSummery(sid, date, aid);
    var result = await OrderAppDB.instance.countCustomer(areaidFrompopup);
    print("resultresult-- $res");
    if (result.length > 0) {
      customerCount = result.length;
      notifyListeners();
    }

    print("customerCount----$customerCount");
    orderCount = res[0]["ordCnt"].toString();
    salesCount = res[0]["saleCnt"].toString();
    collectionCount = res[0]["colCnt"].toString();
    // print("collectioncount...$collectionCount");
    // remarkCount = res[0]["rmCnt"].toString();
    // print("remarkCount...$remarkCount");
    // ret_count = res[0]["retCnt"].toString();
    cs_cnt = res[0]["saleCntCS"].toString();
    cs_amt = res[0]["saleValCS"].toString();
    cr_cnt = res[0]["saleCntCR"].toString();
    cr_amt = res[0]["saleValCR"].toString();
    can_bill_count = res[0]["canCnt"].toString();
    can_bill_amt = res[0]["canAmt"].toString();

    print("jhfjsd-----${res[0]["colVal"]}--${res[0]["ordVal"]}");
    if (res[0]["colVal"] != null) {
      if (res[0]["colVal"] == 0) {
        d1 = 0.0;
      } else {
        d1 = res[0]["colVal"];
      }
    }
    collectionAmount = d1.toStringAsFixed(2);
    if (res[0]["ordVal"] != null) {
      if (res[0]["ordVal"] == 0) {
        d2 = 0.0;
      } else {
        d2 = res[0]["ordVal"];
      }
    }
    ordrAmount = d2.toStringAsFixed(2);
    if (res[0]["saleVal"] != null) {
      if (res[0]["saleVal"] == 0) {
        d = 0.0;
      } else {
        d = res[0]["saleVal"];
      }
    }
    salesAmount = d.toStringAsFixed(2);
    print("salesAmount----${res[0]["saleVal"]}");
    if (res[0]["retVal"] != null) {
      if (res[0]["retVal"] == 0) {
        d4 = 0.0;
      } else {
        d4 = res[0]["retVal"];
      }
    }
    returnAmount = d4.toStringAsFixed(2);
    if (res[0]["saleValCR"] != null) {
      if (res[0]["saleValCR"] == 0) {
        d4 = 0.0;
      } else {
        d4 = res[0]["saleValCR"];
      }
    }
    creditSaleAmt = d4.toStringAsFixed(2);
    if (res[0]["saleValCS"] != null) {
      if (res[0]["saleValCS"] == 0) {
        d4 = 0.0;
      } else {
        d4 = res[0]["saleValCS"];
      }
    }
    cashSaleAmt = d4.toStringAsFixed(2);
    if (res[0]["canAmt"] != null) {
      if (res[0]["canAmt"] == 0) {
        d4 = 0.0;
      } else {
        d4 = res[0]["canAmt"];
      }
    }
    can_bill_amt = d4.toStringAsFixed(2);
    shopVisited = res[0]["cusCount"];

    if (customerCount == null || customerCount == "null") {
      snackbar.showSnackbar(context, "Please download Customers", "");
    } else {
      noshopVisited = customerCount! - shopVisited!;
    }
    notifyListeners();
  }
  ///////////////////////////////////////////////////////////////////
//   Future<dynamic> mainDashAmounts(String sid, String date) async {
//     collectionAmount = await OrderAppDB.instance.sumCommonQuery("rec_amoun,t",
//         'collectionTable', "rec_staffid='$sid' AND rec_date='$date'");
//     ordrAmount = await OrderAppDB.instance.sumCommonQuery(
//         "total_price",
//         'orderMasterTable',
//         "userid='$sid' AND orderdate='$date' AND areaid='$areaidFrompopup'");
//     returnAmount = await OrderAppDB.instance.sumCommonQuery(
//         "total_price",
//         'returnMasterTable',
//         "userid='$sid' AND return_date='$date' AND areaid='$areaidFrompopup'");
//     if (collectionAmount == null || collectionAmount.isEmpty) {
//       collectionAmount = "0.0";
//     }
//     if (ordrAmount == null || ordrAmount.isEmpty) {
//       ordrAmount = "0.0";
//     }
//     if (returnAmount == null || returnAmount.isEmpty) {
//       returnAmount = "0.0";
//     }
//     print("Amount---$collectionAmount--$ordrAmount");
//     notifyListeners();
//   }
// ////////////////////////////////////////////////////////////////////

//   Future<dynamic> mainDashtileValues(String sid, String date) async {
//     print("haiii pty");
//     String condition = " ";
//     if (areaidFrompopup != null) {
//       // condition = "and areaid='$areaidFrompopup'";
//       // condition = " and "
//     }

//     orderCount = await OrderAppDB.instance.countCommonQuery("orderMasterTable",
//         " userid='$sid' AND orderdate='$date' $condition");
//     collectionCount = await OrderAppDB.instance.countCommonQuery(
//         "collectionTable", "rec_staffid='$sid' AND rec_date='$date'");
//     // print("collection count---$collectionCount");
//     remarkCount = await OrderAppDB.instance.countCommonQuery(
//         "remarksTable", "rem_staffid='$sid' AND rem_date='$date'");
//     // print("remarkCountt---$remarkCount");

//     ret_count = await OrderAppDB.instance.countCommonQuery("returnMasterTable",
//         "userid='$sid' AND return_date='$date' $condition");
//     print("ret_count---$ret_count");

//     // if (collectionCount == 0 &&
//     //     orderCount == 0 &&
//     //     remarkCount == 0 &&
//     //     ret_count == 0) {
//     //   shopVisited = 0;
//     // }
//     print("no shop--$noshopVisited");
//     print("shop visited---$shopVisited");
//     notifyListeners();
//   }

/////////////////////////////////////////////////////////////////
  setFilter(bool filters) {
    filter = filters;
    // notifyListeners();
  }

  // filterReports(
  //     String fltrType, double? minPrice, double? maxPrice, String? remark) {
  //   filterList.clear();
  //   print("minPrice-maxPrice-$minPrice--$maxPrice");
  //   isLoading = true;
  //   notifyListeners();
  //   if (fltrType == "balance") {
  //     filterList = reportData.where((element) {
  //       //  print('${element["bln"].runtimeType}') ;
  //       return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //       // return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //     }).toList();
  //     isLoading = false;

  //     notifyListeners();
  //   }
  //   if (fltrType == "order amount") {
  //     for (var item in reportData) {
  //       if (item["order_value"] != null && item["order_value"] != 0) {
  //         if (item["order_value"] > minPrice &&
  //             item["order_value"] < maxPrice) {
  //           filterList.add(item);
  //         }
  //       }
  //     }

  //     // print('hfjkd----$filterList');
  //     isLoading = false;
  //     notifyListeners();
  //   }

  //   if (fltrType == "collection") {
  //     for (var item in reportData) {
  //       if (item["collection_sum"] != null && item["collection_sum"] != 0) {
  //         if (item["collection_sum"] > minPrice &&
  //             item["collection_sum"] < maxPrice) {
  //           filterList.add(item);
  //         }
  //       }
  //     }

  //     // print('hfjkd----$filterList');
  //     isLoading = false;
  //     notifyListeners();
  //   }
  //   if (fltrType == "remark") {
  //     if (remark == "Remarked") {
  //       filterList = reportData.where((element) {
  //         //  print('${element["bln"].runtimeType}') ;
  //         return (element["remark_count"] != null &&
  //             element["remark_count"] != 0);
  //         // return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //       }).toList();
  //     } else {
  //       filterList = reportData.where((element) {
  //         //  print('${element["bln"].runtimeType}') ;
  //         return (element["remark_count"] == null ||
  //             element["remark_count"] == 0);
  //         // return (element["bln"] > minPrice && element["bln"] < maxPrice);
  //       }).toList();
  //     }

  //     isLoading = false;

  //     notifyListeners();
  //   }
  //   print("filters-----$filterList");
  //   notifyListeners();
  // }

  toggleExpansion(int index) {
    for (int i = 0; i < isExpanded.length; i++) {
      if (isExpanded[index] != isExpanded[i] && isExpanded[i]) {
        isExpanded[i] = !isExpanded[i];
        isVisibleTable[i] = !isVisibleTable[i];
      }
    }
  }

  areaSelection(String area) async {
    // areaSelecton.clear();
    print("area.......$area");
    areaidFrompopup = area;
    List<Map<String, dynamic>> result = await OrderAppDB.instance
        .selectAllcommon('areaDetailsTable', "aid='${area}'");
    areaSelecton = result[0]["aname"];
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("areaSelectionPopup", areaSelecton!);
    print("area---$areaidFrompopup");
    notifyListeners();
  }

  // ///////////////////////////////////////////////////////////////////
  //   packageDataSelection(String pid) async {
  //   // areaSelecton.clear();
  //   print("area.......$area");
  //   areaidFrompopup = area;
  //   List<Map<String, dynamic>> result = await OrderAppDB.instance
  //       .selectAllcommon('productUnits', "pid='${pid}'");
  //   areaSelecton = result[0]["aname"];
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString("areaSelectionPopup", areaSelecton!);
  //   print("area---$areaidFrompopup");
  //   notifyListeners();
  // }

  //////////////////////////////////////////////////////////////////////////
  fetchtotalcollectionFromTable(String cusid) async {
    fetchcollectionList.clear();
    isLoading = true;
    var res = await OrderAppDB.instance
        .selectAllcommonwithdesc('collectionTable', "rec_cusid = '$cusid'");
    if (res != null) {
      for (var menu in res) {
        fetchcollectionList.add(menu);
      }
    }
    print("fetchcollectionList----${fetchcollectionList}");
    isLoading = false;
    notifyListeners();
  }

  /////////////////////// fetch collection table ////////////
  fetchrcollectionFromTable(String custmerId, String todaydate) async {
    collectionList.clear();

    var res = await OrderAppDB.instance
        .selectAllcommonwithdesc('collectionTable', "rec_cusid='${custmerId}'");

    for (var menu in res) {
      collectionList.add(menu);
    }
    print("collectionList----${collectionList}");
    notifyListeners();
  }

  clearList(List list) {
    list.clear();
    print("list.length----${list.length}");
    notifyListeners();
  }

  ///////////////Return////////////////////////
  // addToreturnList(Map<String, dynamic> value) {
  //   print("value---${value}");
  //   bool flag = false;
  //   int i;
  //   if (returnList.length > 0) {
  //     print("return length----${returnList.length}");
  //     for (i = 0; i < returnList.length; i++) {
  //       print("hyyyyy----${returnList[i]["code"]}");
  //       if (returnList[i]["code"] == value["code"]) {
  //         flag = true;
  //         break;
  //       } else {
  //         flag = false;
  //       }
  //     }
  //     if (flag == true) {
  //       print(
  //           "returnList[i]------------------${returnList[i]["total"].runtimeType}");
  //       print("value[i]------------------${value["total"].runtimeType}");

  //       returnList[i]["qty"] = returnList[i]["qty"] + value["qty"];
  //       double d =
  //           double.parse(returnList[i]["total"]) + double.parse(value["total"]);
  //       returnList[i]["total"] = d.toString();
  //       print("qty--${returnList[i]["qty"]}");
  //     } else {
  //       returnList.add(value);
  //     }
  //   } else {
  //     returnList.add(value);
  //   }
  //   returnCount = returnList.length;
  //   print("return List----$returnList");
  //   notifyListeners();
  // }

  // // selectfromreturnList(){
  // //   returnList.
  // // }

  // deleteFromreturnList(index) {
  //   returnList.removeAt(index);
  //   returnCount = returnCount - 1;
  //   notifyListeners();
  // }

  updatereturnQty(int index, int updteretrnQty, double rate) {
    print("index---updteretrnQty-$index--$updteretrnQty---$rate");
    for (int i = 0; i < returnbagList.length; i++) {
      if (i == index) {
        returnbagList[i]["qty"] = updteretrnQty;
        returnbagList[i]["total"] = rate.toStringAsFixed(2);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  uploadOrdersData(
      String cid, BuildContext context, int? index, String page) async {
    List<Map<String, dynamic>> resultQuery = [];
    List<Map<String, dynamic>> om = [];

    var result = await OrderAppDB.instance.selectMasterTable();
    print("output------$result");
    if (result.length > 0) {
      isUpload = true;
      notifyListeners();
      String jsonE = jsonEncode(result);
      var jsonDe = jsonDecode(jsonE);
      print("jsonDe--${jsonDe}");
      for (var item in jsonDe) {
        resultQuery = await OrderAppDB.instance.selectDetailTable(item["oid"]);
        item["od"] = resultQuery;
        om.add(item);
      }
      print("onnnmm---$om");
      if (om.length > 0) {
        print("entede");
        saveOrderDetails(cid, om, context);
      }
      isUpload = false;
      if (page == "upload page") {
        isUp[index!] = true;
      }

      notifyListeners();
      print("om----$om");
    } else {
      isUp[index!] = false;
      notifyListeners();
      snackbar.showSnackbar(context, "Nothing to upload!!!", "");
    }

    notifyListeners();
  }

  ////////////////////////upload salesdata////////////////////////////////////////
  uploadSalesData(
      String cid, BuildContext context, int? index, String page) async {
    List<Map<String, dynamic>> resultQuery = [];
    List<Map<String, dynamic>> om = [];
    notifyListeners();
    var result = await OrderAppDB.instance.selectSalesMasterTable();
    print("output------$result");
    if (result.length > 0) {
      isUpload = true;
      String jsonE = jsonEncode(result);
      var jsonDe = jsonDecode(jsonE);
      print("jsonDe--${jsonDe}");
      for (var item in jsonDe) {
        print("item,hd----$item");
        resultQuery =
            await OrderAppDB.instance.selectSalesDetailTable(item["s_id"]);
        item["od"] = resultQuery;
        om.add(item);
      }
      if (om.length > 0) {
        print("entede");
        saveSalesDetails(cid, om, context);
      }
      isUpload = false;
      if (page == "upload page") {
        isUp[index!] = true;
      }
      notifyListeners();
      print("om----$om");
    } else {
      isUp[index!] = false;
      notifyListeners();
      snackbar.showSnackbar(context, "Nothing to upload!!!", "");
    }

    notifyListeners();
  }

  /////////////////////////upload customer/////////////////////////////////////////
  uploadCustomers(BuildContext context, int? index, String page) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          var result =
              await OrderAppDB.instance.selectAllcommon('customerTable', "");
          if (result.length > 0) {
            Uri url = Uri.parse("https://trafiqerp.in/order/fj/cus_save.php");
            isUpload = true;
            isLoading = true;
            notifyListeners();
            var customer = await OrderAppDB.instance.uploadCustomer();
            print("customer result----$customer");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? cid = prefs.getString("cid");
            String cm = jsonEncode(customer);
            print("cm----$cm");

            String? br_id1 = prefs.getString("br_id");

            String branch_id;
            if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
              branch_id = " ";
            } else {
              branch_id = br_id1;
            }
            Map body = {
              'cid': cid,
              'br_id': branch_id,
              'cm': cm,
            };
            print("order body.....$body");
            http.Response response = await http.post(
              url,
              body: body,
            );
            isUpload = false;
            if (page == "upload page") {
              isUp[index!] = true;
            }
            isLoading = false;
            notifyListeners();
            // print("response----$response");
            var map = jsonDecode(response.body);
            print("map customer......... ${map}");
            if (map.length > 0) {
              await OrderAppDB.instance
                  .deleteFromTableCommonQuery("customerTable", "");
            }
          } else {
            isUp[index!] = false;
            notifyListeners();
            snackbar.showSnackbar(context, "Nothing to upload!!!", "");
          }
          notifyListeners();
        } catch (e) {
          print(e);
        }
      }
    });
  }

  ////////////////////////upload return data////////////////////////
  uploadReturnData(
      String cid, BuildContext context, int? index, String page) async {
    List<Map<String, dynamic>> resultQuery = [];
    List<Map<String, dynamic>> om = [];

    var result = await OrderAppDB.instance.selectReturnMasterTable();
    print("output------$result");
    if (result.length > 0) {
      isUpload = true;
      notifyListeners();

      String jsonE = jsonEncode(result);
      var jsonDe = jsonDecode(jsonE);
      print("jsonDe--${jsonDe}");
      for (var item in jsonDe) {
        resultQuery =
            await OrderAppDB.instance.selectReturnDetailTable(item["srid"]);
        item["od"] = resultQuery;
        om.add(item);
      }
      if (om.length > 0) {
        print("entede");
        saveReturnDetails(cid, om, context);
        isUpload = false;
        if (page == "upload page") {
          isUp[index!] = true;
        }
        notifyListeners();
      }
    } else {
      isUp[index!] = false;
      notifyListeners();

      snackbar.showSnackbar(context, "Nothing to upload!!!", "");
    }
    print("om----$om");
    notifyListeners();
  }

  /////////////////////////upload customer/////////////////////////////////////////
  uploadRemarks(BuildContext context, int index, String page) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          var result = await OrderAppDB.instance.uploadRemark();
          print("remark result......$result");
          if (result.length > 0) {
            Uri url = Uri.parse("https://trafiqerp.in/order/fj/rem_save.php");
            isUpload = true;
            isLoading = true;
            notifyListeners();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? cid = prefs.getString("cid");
            String rm = jsonEncode(result);
            print("collection----$rm");

            String? br_id1 = prefs.getString("br_id");

            String branch_id;
            if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
              branch_id = " ";
            } else {
              branch_id = br_id1;
            }
            Map body = {
              'cid': cid,
              'br_id': branch_id,
              'rm': rm,
            };
            print("remark map......$body");
            http.Response response = await http.post(
              url,
              body: body,
            );
            isLoading = false;
            notifyListeners();
            // print("response----$response");
            var map = jsonDecode(response.body);
            print("response remark----${map}");
            for (var item in map) {
              print("update data.......$map");
              if (item["rid"] != null) {
                print("update data1.......$map");
                await OrderAppDB.instance.upadteCommonQuery(
                    "remarksTable",
                    "rem_status='${item["rid"]}'",
                    "rem_row_num='${item["phid"]}'");
              }
            }
            isUpload = false;
            if (page == "upload page") {
              isUp[index] = true;
            }
          } else {
            isUp[index] = false;
            notifyListeners();
            snackbar.showSnackbar(context, "Nothing to upload!!!", "");
          }

          notifyListeners();
        } catch (e) {
          print(e);
        }
      }
    });
    print("haicollection");
  }

  /////////////////UPLOAD COLLECTION TABLE//////////////////

  uploadCollectionData(BuildContext context, int? index, String page) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          var result = await OrderAppDB.instance.uploadCollections();
          print("collection result......$result");
          if (result.length > 0) {
            Uri url = Uri.parse("https://trafiqerp.in/order/fj/col_save.php");
            isUpload = true;
            isLoading = true;
            notifyListeners();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? cid = prefs.getString("cid");
            String rm = jsonEncode(result);
            print("collection----$rm");

            String? br_id1 = prefs.getString("br_id");

            String branch_id;
            if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
              branch_id = " ";
            } else {
              branch_id = br_id1;
            }
            Map body = {'cid': cid, 'rm': rm, 'br_id': branch_id};
            print("collection map......$body");
            http.Response response = await http.post(
              url,
              body: body,
            );
            isLoading = false;
            notifyListeners();
            // print("response----$response");
            var map = jsonDecode(response.body);
            print("response collection----${map}");
            for (var item in map) {
              print("update data.......$map");
              if (item["col_id"] != null) {
                print("update data1.......");
                await OrderAppDB.instance.upadteCommonQuery(
                    "collectionTable",
                    "rec_status='${item["col_id"]}'",
                    "rec_row_num='${item["phid"]}'");
              }
            }
            isUpload = false;
            if (page == "upload page") {
              isUp[index!] = true;
            }
          } else {
            isUp[index!] = false;
            notifyListeners();
            snackbar.showSnackbar(context, "Nothing to upload!!!", "");
          }

          notifyListeners();
        } catch (e) {
          print(e);
        }
      }
    });
    print("haicollection");
  }
  // getProductItems(String table) async {
  //   productName.clear();
  //   try {
  //     isLoading = true;
  //     // notifyListeners();
  //     prodctItems = await OrderAppDB.instance.selectCommonquery(table, '');
  //     print("prodctItems----${prodctItems}");

  //     for (var item in prodctItems) {
  //       productName.add(item);
  //       // productName.add(item["code"] + '-' + item["item"]);
  //       // notifyListeners();
  //     }
  //     var length = productName.length;
  //     print("text length----$length");
  //     qty = List.generate(length, (index) => TextEditingController());
  //     isLoading = false;
  //     notifyListeners();
  //     print("product name----${productName}");
  //     // print("product productRate----${productRate}");
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  //   notifyListeners();
  // }

  ////////////////////////SEARCH PROCESS ////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  searchProcess(String customerId, String os, String comid, String type,
      List<Map<String, dynamic>> list, BuildContext context) async {
    print("searchkey--comid-$type-$searchkey---$comid----$os");
    List<Map<String, dynamic>> result = [];
    List<Map<String, dynamic>> list = type == 'sales'
        ? await OrderAppDB.instance.selectfromsalebagTable(customerId)
        : type == 'sale order'
            ? await OrderAppDB.instance.selectfromOrderbagTable(customerId)
            : await OrderAppDB.instance.selectfromreturnbagTable(customerId);
    // List<Map<String, dynamic>> orderlist =
    //     await OrderAppDB.instance.selectfromOrderbagTable(customerId);
    newList.clear();
    print("jhkzsfz----$list");
    if (searchkey!.isEmpty) {
      newList = list;
      var length = newList.length;
      print("text length----$length");
      qty = List.generate(length, (index) => TextEditingController());
      selected = List.generate(length, (index) => false);
    } else {
      // newList.clear();
      isListLoading = true;
      notifyListeners();
      print("else is search");
      isSearch = true;

      // List<Map<String, dynamic>> res =
      //     await OrderAppDB.instance.getOrderBagTable(customerId, os);
      // for (var item in res) {
      //   bagList.add(item);
      // }
// print("jhfdjkhfjd----$bagList");

      print(" nw list---$productName");
      newList = list
          .where((product) =>
              product["pritem"]
                  .toLowerCase()
                  .contains(searchkey!.toLowerCase()) ||
              product["prcode"]
                  .toLowerCase()
                  .contains(searchkey!.toLowerCase()) ||
              product["prcategoryId"]
                  .toLowerCase()
                  .contains(searchkey!.toLowerCase()))
          .toList();

      // result = await OrderAppDB.instance.searchItem(
      //     'productDetailsTable',
      //     searchkey!,
      //     'item',
      //     'code',
      //     'categoryId',
      //     " and companyId='${comid}'");

      for (var item in result) {
        newList.add(item);
      }

      print("newlist-----------$newList");
      isListLoading = false;
      notifyListeners();
      var length = newList.length;
      selected = List.generate(length, (index) => false);
      qty = List.generate(length, (index) => TextEditingController());
      // rateController =
      //     List.generate(length, (index) => TextEditingController());

      for (int i = 0; i < newList.length; i++) {
        if (newList[i]["qty"] != null) {
          qty[i].text = newList[i]["qty"].toString();
          // rateController[i].text = newList[i]["prrate1"].toString();
        } else {
          qty[i].text = "1";
        }
      }

      print("baglis length----${bagList}");
      if (newList.length > 0) {
        print("enterde");
        if (type == "sale order") {
          List lis = await getBagDetails(customerId, os);
          for (var item = 0; item < newList.length; item++) {
            print("newList[item]----${newList[item]}");

            for (var i = 0; i < bagList.length; i++) {
              print("bagList[item]----${bagList[i]}");

              if (bagList[i]["code"] == newList[item]["code"]) {
                print("ifff");
                selected[item] = true;
                break;
              } else {
                print("else----");
                selected[item] = false;
              }
            }
          }
        }
        if (type == "return") {
          List lis = await getreturnBagDetails(customerId, os);

          for (var item = 0; item < newList.length; item++) {
            print("newList[item]-return---${newList[item]}");

            for (var i = 0; i < returnbagList.length; i++) {
              print("bagList[item]----${returnbagList[i]}");

              if (returnbagList[i]["code"] == newList[item]["code"]) {
                print("codes are equal......");
                selected[item] = true;
                break;
              } else {
                print("else----");
                selected[item] = false;
              }
            }
          }
        }
        if (type == "sales") {
          List lis =
              await getSaleBagDetails(customerId, os, "", context, "", "");

          for (var item = 0; item < newList.length; item++) {
            print("newList[item]----${newList[item]}");

            for (var i = 0; i < salebagList.length; i++) {
              print("bagList[item]----${salebagList[i]}");

              if (salebagList[i]["code"] == newList[item]["code"]) {
                print("ifff");
                selected[item] = true;
                break;
              } else {
                print("else----");
                selected[item] = false;
              }
            }
          }
        }
      }

      print("text length----$length");

      print("selected[item]-----${selected}");

      // notifyListeners();
    }

    print("nw list---$newList");
    notifyListeners();
  }

//////////////////////////////////////////////////////////////////
  searchProcess_X001(
      String customerId,
      String os,
      String comid,
      String type,
      List<Map<String, dynamic>> list1,
      String type1,
      BuildContext context) async {
    print("searchkey--comid-$type-$searchkey---$comid----$os---$list1");
    List<Map<String, dynamic>> result = [];
    List<Map<String, dynamic>> list = await OrderAppDB.instance
        .selectfromsalebagTable_X001(customerId, type1);

    //     await OrderAppDB.instance.selectfromOrderbagTable(customerId);
    // newList.clear();
    print("jhkzsffz----$list");
    isListLoading = true;
    notifyListeners();
    // newList.clear();
    if (searchkey!.isEmpty) {
      // newList.clear();

      newList = list;
      var length = newList.length;
      print("text length----$length");
      qty = List.generate(length, (index) => TextEditingController());
      selected = List.generate(length, (index) => false);
    } else {
      // newList.clear();

      print("else is search");
      isSearch = true;
      newList = list
          .where((product) =>
              product["pritem"]
                  .toLowerCase()
                  .contains(searchkey!.toLowerCase()) ||
              product["pritem"].toLowerCase().startsWith(
                    searchkey!.toLowerCase(),
                  ) ||
              // product["prcode"]
              //     .toLowerCase()
              //     .contains(searchkey!.toLowerCase())

              //     ||
              product["prcode"].toLowerCase().startsWith(
                    searchkey!.toLowerCase(),
                  ))
          .toList();
      print("nw list---$salesitemList2");
      // newList = list
      //     .where((product) =>
      //             product["pritem"]
      //                 .toLowerCase()
      //                 .startsWith(searchkey!.toLowerCase()) ||
      //             product["prcode"]
      //                 .toLowerCase()
      //                 .startsWith(searchkey!.toLowerCase())
      //         //      ||
      //         // product["prcategoryId"]
      //         //     .toLowerCase()
      //         //     .contains(searchkey!.toLowerCase())
      //         )
      //     .toList();

      // result = await OrderAppDB.instance.searchItem(
      //     'productDetailsTable',
      //     searchkey!,
      //     'item',
      //     'code',
      //     'categoryId',
      //     " and companyId='${comid}'");

      for (var item in result) {
        newList.add(item);
      }

      print("newlist-----------$newList");
      isListLoading = false;
      notifyListeners();
      var length = newList.length;
      selected = List.generate(length, (index) => false);
      orderrate_X001 =
          List.generate(length, (index) => TextEditingController());
      salesrate_X001 =
          List.generate(length, (index) => TextEditingController());
      // rateController =
      //     List.generate(length, (index) => TextEditingController());
      salesqty_X001 = List.generate(length, (index) => TextEditingController());
      qty = List.generate(length, (index) => TextEditingController());
      discount_prercent_X001 =
          List.generate(length, (index) => TextEditingController());
      discount_amount_X001 =
          List.generate(length, (index) => TextEditingController());

      for (int i = 0; i < newList.length; i++) {
        if (newList[i]["qty"] != null) {
          orderrate_X001[i].text = newList[i]["prrate1"].toString();
          qty[i].text = newList[i]["qty"].toString();
        } else {
          qty[i].text = "0";
        }
      }
      notifyListeners();
      print("baglis length----${bagList}");
      if (newList.length > 0) {
        print("enterde");
        if (type == "sale order") {
          List lis = await getBagDetails(customerId, os);
          for (var item = 0; item < newList.length; item++) {
            print("newList[item]----${newList[item]}");

            for (var i = 0; i < bagList.length; i++) {
              print("bagList[item]----${bagList[i]}");

              if (bagList[i]["code"] == newList[item]["code"]) {
                print("ifff");
                selected[item] = true;
                break;
              } else {
                print("else----");
                selected[item] = false;
              }
            }
          }
        }
        if (type == "return") {
          List lis = await getreturnBagDetails(customerId, os);

          for (var item = 0; item < newList.length; item++) {
            print("newList[item]-return---${newList[item]}");

            for (var i = 0; i < returnbagList.length; i++) {
              print("bagList[item]----${returnbagList[i]}");

              if (returnbagList[i]["code"] == newList[item]["code"]) {
                print("codes are equal......");
                selected[item] = true;
                break;
              } else {
                print("else----");
                selected[item] = false;
              }
            }
          }
        }
        if (type == "sales") {
          List lis =
              await getSaleBagDetails(customerId, os, "", context, "", "");

          for (var item = 0; item < newList.length; item++) {
            print("newList[item]----${newList[item]}");

            for (var i = 0; i < salebagList.length; i++) {
              print("bagList[item]----${salebagList[i]}");

              if (salebagList[i]["code"] == newList[item]["code"]) {
                print("ifff");
                selected[item] = true;
                break;
              } else {
                print("else----");
                selected[item] = false;
              }
            }
          }
        }
      }

      print("text length----$length");

      print("selected[item]-----${selected}");

      // notifyListeners();
    }

    print("nw list---$newList");
    notifyListeners();
  }
////////////////////////////////////////////////////////////////
  // searchProcess1(String customerId, String os, String comid, String type,
  //     List<Map<String, dynamic>> list) async {
  //   print("searchkey--comid--$searchkey---$comid----$os");
  //   List<Map<String, dynamic>> result = [];
  //   newList.clear();

  //   if (searchkey!.isEmpty) {
  //     newList = productName;
  //     var length = newList.length;
  //     print("text length----$length");
  //     qty = List.generate(length, (index) => TextEditingController());
  //     selected = List.generate(length, (index) => false);
  //   } else {
  //     // newList.clear();
  //     isListLoading = true;
  //     notifyListeners();
  //     print("else is search");
  //     isSearch = true;

  //     if (comid == "") {
  //       result = await OrderAppDB.instance.searchItem('productDetailsTable',
  //           searchkey!, 'item', 'code', 'categoryId', " ");
  //     } else {
  //       result = await OrderAppDB.instance.searchItem(
  //           'productDetailsTable',
  //           searchkey!,
  //           'item',
  //           'code',
  //           'categoryId',
  //           " and companyId='${comid}'");
  //     }

  //     for (var item in result) {
  //       newList.add(item);
  //     }

  //     isListLoading = false;
  //     notifyListeners();
  //     var length = newList.length;
  //     selected = List.generate(length, (index) => false);
  //     qty = List.generate(length, (index) => TextEditingController());

  //     print("baglis length----${bagList}");
  //     if (newList.length > 0) {
  //       print("enterde");
  //       if (type == "sale order") {
  //         List lis = await getBagDetails(customerId, os);
  //         for (var item = 0; item < newList.length; item++) {
  //           print("newList[item]----${newList[item]}");

  //           for (var i = 0; i < bagList.length; i++) {
  //             print("bagList[item]----${bagList[i]}");

  //             if (bagList[i]["code"] == newList[item]["code"]) {
  //               print("ifff");
  //               selected[item] = true;
  //               break;
  //             } else {
  //               print("else----");
  //               selected[item] = false;
  //             }
  //           }
  //         }
  //       }
  //     }

  //     print("text length----$length");

  //     print("selected[item]-----${selected}");

  //     // notifyListeners();
  //   }

  //   print("nw list---$newList");
  //   notifyListeners();
  // }

  ///////////////////////////////////////////////////////////
  String rawCalculation(
      double rate,
      double qty,
      double disc_per,
      double disc_amount,
      double tax_per,
      double cess_per,
      String method,
      int state_status,
      int index,
      bool onSub,
      String? disCalc) {
    flag = false;

    print(
        "attribute----$rate----$qty-$state_status---$disCalc --$disc_per--$disc_amount--$tax_per--$cess_per--$method");
    if (method == "0") {
      /////////////////////////////////method=="0" - excluisive , method=1 - inclusive
      taxable_rate = rate;
    } else if (method == "1") {
      double percnt = tax_per + cess_per;
      taxable_rate = rate * (1 - (percnt / (100 + percnt)));
      print("exclusive tax....$percnt...$taxable_rate");
    }
    print("exclusive tax......$taxable_rate");
    // qty=qty+1;
    gross = taxable_rate * qty;
    print("gros----$gross");

    if (disCalc == "disc_amt") {
      disc_per = (disc_amount / gross) * 100;
      disc_amt = disc_amount;
      print("discount_prercent---$disc_amount---${discount_prercent.length}");
      if (onSub) {
        discount_prercent[index].text = disc_per.toStringAsFixed(4);
      }
      print("disc_per----$disc_per");
    }

    if (disCalc == "disc_per") {
      print("yes hay---$disc_per");
      disc_amt = (gross * disc_per) / 100;
      if (onSub) {
        discount_amount[index].text = disc_amt.toStringAsFixed(2);
      }
      print("disc-amt----$disc_amt");
    }

    if (disCalc == "qty") {
      disc_amt = double.parse(discount_amount[index].text);
      disc_per = double.parse(discount_prercent[index].text);
      print("disc-amt qty----$disc_amt...$disc_per");
    }

    // if (disCalc == "rate") {
    //   rateController[index].text = taxable_rate.toStringAsFixed(2);
    //   // disc_amt = double.parse(discount_amount[index].text);
    //   // disc_per = double.parse(discount_prercent[index].text);
    //   print("disc-amt qty----$disc_amt...$disc_per");
    // }

    if (state_status == 0) {
      ///////state_status=0--loacal///////////state_status=1----inter-state
      cgst_per = tax_per / 2;
      sgst_per = tax_per / 2;
      igst_per = 0;
    } else {
      cgst_per = 0;
      sgst_per = 0;
      igst_per = tax_per;
    }

    if (disCalc == "") {
      print("inside nothingg.....");
      disc_per = (disc_amount / taxable_rate) * 100;
      disc_amt = disc_amount;
      print("rsr....$disc_per....$disc_amt..");
    }

    tax = (gross - disc_amt) * (tax_per / 100);
    print("tax....$tax....$gross... $disc_amt...$tax_per");
    if (tax < 0) {
      tax = 0.00;
    }
    cgst_amt = (gross - disc_amt) * (cgst_per / 100);
    sgst_amt = (gross - disc_amt) * (sgst_per / 100);
    igst_amt = (gross - disc_amt) * (igst_per / 100);
    cess = (gross - disc_amt) * (cess_per / 100);
    net_amt = ((gross - disc_amt) + tax + cess);
    if (net_amt < 0) {
      net_amt = 0.00;
    }
    print("netamount.cal...$net_amt");

    print(
        "disc_per calcu mod=0..$tax..$gross... $disc_amt...$tax_per-----$net_amt");
    notifyListeners();
    return "success";
  }

  //////////////////////////////////////////////////////
  String rawCalculation_X001(
      double rate,
      double qty,
      double disc_per,
      double disc_amount,
      double tax_per,
      double cess_per,
      String method,
      int state_status,
      int index,
      bool onSub,
      String? disCalc) {
    flag = false;

    print(
        "attribute----$rate----$qty-$state_status---$disCalc --$disc_per--$disc_amount--$tax_per--$cess_per--$method");
    if (method == "0") {
      /////////////////////////////////method=="0" - excluisive , method=1 - inclusive
      taxable_rate = rate;
    } else if (method == "1") {
      double percnt = tax_per + cess_per;
      taxable_rate = rate * (1 - (percnt / (100 + percnt)));
      print("exclusive tax....$percnt...$taxable_rate");
    }
    print("exclusive tax......$taxable_rate");
    // qty=qty+1;
    gross = taxable_rate * qty;
    print("gros----$gross");

    if (disCalc == "disc_amt") {
      disc_per = (disc_amount / gross) * 100;
      disc_amt = disc_amount;
      print("discount_prercent---$disc_amount---${discount_prercent.length}");
      if (onSub) {
        discount_prercent_X001[index].text = disc_per.toStringAsFixed(4);
      }
      print("disc_per----$disc_per");
    }

    if (disCalc == "disc_per") {
      print("yes hay---$disc_per");
      disc_amt = (gross * disc_per) / 100;
      if (onSub) {
        discount_amount_X001[index].text = disc_amt.toStringAsFixed(2);
      }
      print("disc-amt----$disc_amt");
    }

    if (disCalc == "qty") {
      disc_amt = double.parse(discount_amount_X001[index].text);
      disc_per = double.parse(discount_prercent_X001[index].text);
      print("disc-amt qty----$disc_amt...$disc_per");
    }

    // if (disCalc == "rate") {
    //   rateController[index].text = taxable_rate.toStringAsFixed(2);
    //   // disc_amt = double.parse(discount_amount[index].text);
    //   // disc_per = double.parse(discount_prercent[index].text);
    //   print("disc-amt qty----$disc_amt...$disc_per");
    // }

    if (state_status == 0) {
      ///////state_status=0--loacal///////////state_status=1----inter-state
      cgst_per = tax_per / 2;
      sgst_per = tax_per / 2;
      igst_per = 0;
    } else {
      cgst_per = 0;
      sgst_per = 0;
      igst_per = tax_per;
    }

    if (disCalc == "") {
      print("inside nothingg.....");
      disc_per = (disc_amount / taxable_rate) * 100;
      disc_amt = disc_amount;
      print("rsr....$disc_per....$disc_amt..");
    }

    tax = (gross - disc_amt) * (tax_per / 100);
    print("tax....$tax....$gross... $disc_amt...$tax_per");
    if (tax < 0) {
      tax = 0.00;
    }
    cgst_amt = (gross - disc_amt) * (cgst_per / 100);
    sgst_amt = (gross - disc_amt) * (sgst_per / 100);
    igst_amt = (gross - disc_amt) * (igst_per / 100);
    cess = (gross - disc_amt) * (cess_per / 100);
    net_amt = ((gross - disc_amt) + tax + cess);
    if (net_amt < 0) {
      net_amt = 0.00;
    }
    notifyListeners();
    print("netamount.cal...$net_amt");

    print(
        "disc_per calcu mod=0..$tax..$gross... $disc_amt...$tax_per-----$net_amt");
    // notifyListeners();
    return "success";
  }

  ///////////////////////////////////////////////////////
  // keyContainsListcheck(String key, int index) {
  //   print("rhdhsz---$key-$returnList");
  //   bool exist = returnList.any((element) => element.values.contains(key));
  //   returnirtemExists[index] = exist;
  //   print("existss--$returnirtemExists");
  //   notifyListeners();
  // }

  selectSettings(String condition) async {
    settingsList1.clear();
    var res = await OrderAppDB.instance
        .selectAllcommon('settingsTable', "$condition");
    for (var item in res) {
      settingsList1.add(item);
    }
    print("settingsList1--$settingsList1");
    notifyListeners();
  }

  setDate(String date1, String date2) {
    fromDate = date1;
    todate = date2;
    print("gtyy----$fromDate");
    //  notifyListeners();
  }

///////////////////////// get max /////////////////////////////////////
  getMaxSerialNumber(String os) async {
    print("series............$os");
    try {
      Uri url = Uri.parse("https://trafiqerp.in/order/fj/get_max_sl.php");
      String ordOs = "O" + "$os";
      String salesOs = "$os";
      String collOs = "C" + "$os";
      String retOs = "R" + "$os";
      String remOs = "M" + "$os";

      List<Map<String, dynamic>> tabledel = [
        {
          "table_name": "order_master",
          "field": "order_no",
          "series": "${ordOs}"
        },
        {
          "table_name": "sale_master",
          "field": "bill_no",
          "series": "${salesOs}"
        },
        {
          "table_name": "collection",
          "field": "collection_series",
          "series": "${collOs}"
        },
        {
          "table_name": "stock_return_master",
          "field": "stock_r_no",
          "series": "${retOs}"
        },
        // {
        //   "table_name": "stock_return_master",
        //   "field": "stock_r_no",
        //   "series": "${retOs}"
        // }
      ];
      print("table..............$tabledel");
      Map body = {
        'cid': cid,
        'table': tabledel,
      };

      var varJsonEncode = jsonEncode(body);
      print("body user:......... ${varJsonEncode}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? br_id1 = prefs.getString("br_id");

      String branch_id;
      if (br_id1 == null || br_id1 == " " || br_id1 == "null") {
        branch_id = " ";
      } else {
        branch_id = br_id1;
      }
      http.Response response = await http.post(
        url,
        body: {'cid': cid, 'br_id': branch_id, 'table': varJsonEncode},
      );
      var map = jsonDecode(response.body);

      print("maxseris-----$map");
      var selectReslt =
          await OrderAppDB.instance.selectAllcommon('maxSeriesTable', '');
      print("mapuser ${map}");
      for (var item in map) {
        print("tablename........${item['table_name']}....${item['series']}");
        String sval = item['series'].replaceAll(new RegExp(r'[^0-9]'), '');
        String series = item['series'].replaceAll(new RegExp(r'(\d+)'), '');
        print("value series............$sval....$series");

        if (selectReslt.length == 0) {
          await OrderAppDB.instance
              .insertSeriesTable(item['table_name'], series, sval);
        } else {
          OrderAppDB.instance.upadteCommonQuery(
              'maxSeriesTable', 'value="${sval}"', 'prefix="${series}"');
        }
      }
      ///////////////// insert into local db ///////////////////////
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  //////////////////////////////////
  calculateMaxSeries(String prefix, String table, int id) {
    // var qry = select value from maxseriestable where prefix = $prefix union ALL
    //     select max($id)+1 as value from $table order by value desc
  }
  queryExecuteResult(String query) async {
    queryResult.clear();
    print("print query..........");
    queryResult = await OrderAppDB.instance.executeQuery(query);
    print("queryResult---$queryResult");
    notifyListeners();
  }

//////////////////////////////////////////////////////////////
  printSales(
      String cid,
      BuildContext context,
      Map<String, dynamic> salesMasterData,
      String? areaName,
      String isCancelled) async {
    List<Map<String, dynamic>> taxableData = [];
    List<Map<String, dynamic>> resultQuery = [];

    // print("outputjknhjkjkkjj------${salesMasterData["sales_id"]}");
    List<Map<String, dynamic>> companyData = [];
    List<Map<String, dynamic>> staffData = [];
    taxableData = await OrderAppDB.instance
        .printTaxableDetails(salesMasterData["sales_id"]);
    resultQuery = await OrderAppDB.instance
        .selectSalesDetailTable(salesMasterData["sales_id"]);
    companyData =
        await OrderAppDB.instance.selectAllcommon('registrationTable', "");
    staffData =
        await OrderAppDB.instance.selectAllcommon('staffLoginDetailsTable', "");
    // print("company dataa.............$companyData");
    print("result quru----$companyData");
    printSalesData["company"] = companyData;
    printSalesData["staff"] = staffData;
    printSalesData["master"] = salesMasterData;
    printSalesData["detail"] = resultQuery;
    printSalesData["taxable_data"] = taxableData;

    IminPrint printer = IminPrint();
    printer.printReceipt(
        printSalesData, salesMasterData["payment_mode"], isCancelled);

    if (areaName != null && areaName.isNotEmpty && areaName != " ") {
      await EasyLoading.show(
        status: 'printing...',
        maskType: EasyLoadingMaskType.black,
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).push(
          PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) =>
                  Dashboard(type: "", areaName: areaName)
              // OrderForm(widget.areaname,"return"),
              ),
        );
      });

      await EasyLoading.dismiss();
    }

    notifyListeners();
  }

  ////////////////////////////////////////////////////////////
  fromSalesbagTable_X001(String custmerId, String type) async {
    print("dgsdgg---$type");
    var res =
        await OrderAppDB.instance.selectfromsalebagTable_X001(custmerId, type);
    salesitemList2.clear();
    for (var item in res) {
      salesitemList2.add(item);
    }
    salesrate_X001 = List.generate(
        salesitemList2.length, (index) => TextEditingController());
    salesqty_X001 = List.generate(
        salesitemList2.length, (index) => TextEditingController());
    discount_prercent_X001 = List.generate(
        salesitemList2.length, (index) => TextEditingController());
    discount_amount_X001 = List.generate(
        salesitemList2.length, (index) => TextEditingController());

    // for (var i = 0; i < salesitemList2.length; i++) {
    //   salesrate_X001[i].text = salesitemList2[i]["prrate1"];
    //   discount_prercent_X001[i].text="0.0";
    //   discount_amount_X001[i].text="0.0";

    //   if (salesitemList2[i]["qty"] == null) {
    //     salesqty_X001[i].text = "1";
    //   } else {
    //     salesqty_X001[i].text = salesitemList2[i]["qty"];
    //   }
    // }
    print("coconut form salesbag..................${salesitemList2}");
    notifyListeners();
  }

/////////////////////////////////////////////////
  fromOrderbagTable_X001(String custmerId, String type) async {
    // salesitemList2.clear();
    var res =
        await OrderAppDB.instance.selectfromsalebagTable_X001(custmerId, type);

    orderitemList2.clear();
    for (var item in res) {
      orderitemList2.add(item);
    }
    orderrate_X001 = List.generate(
        orderitemList2.length, (index) => TextEditingController());
    for (int i = 0; i < orderitemList2.length; i++) {
      orderrate_X001[i].text = orderitemList2[i]["prrate1"];
    }
    // rateController = List.generate(
    //     orderitemList2.length, (index) => TextEditingController());
    qty = List.generate(
        orderitemList2.length, (index) => TextEditingController());

    print("coconut form salesbag.${orderitemList2}");
    notifyListeners();
  }

  ///////////////////////////////////////////////
  Future fromSalesListData_X001(
      String custmerId, String prcode, int index) async {
    print(
        "inside sales bottomsheet........$custmerId........$prcode.....$index");
    salesitemListdata2.clear();
    prUnitSaleListData2.clear();
    isLoading = true;
    var res =
        await OrderAppDB.instance.fromsalebagTable_X001(custmerId, prcode);
    salesitemListdata2.clear();
    for (var item in res) {
      salesitemListdata2.add(item);

      prUnitSaleListData2.add(item["unit"]);
    }
    isLoading = false;
    notifyListeners();
    print("full data ......${salesitemListdata2}");
    print("prUnitSaleListData2.....${prUnitSaleListData2}");
    frstDropDown = prUnitSaleListData2[0];
    // selectedItem=prUnitSaleListData2[0];
    print("frstDropDown.....${frstDropDown}");
    notifyListeners();
  }

  /////////////////////////////////////////////////////////////////
  Future fromOrderListData_X001(
      String custmerId, String prcode, int index) async {
    print(
        "inside sales bottomsheet........$custmerId........$prcode.....$index");
    orderitemListdata2.clear();
    prUnitSaleListData2.clear();
    isLoading = true;
    var res =
        await OrderAppDB.instance.fromsalebagTable_X001(custmerId, prcode);
    orderitemListdata2.clear();
    for (var item in res) {
      orderitemListdata2.add(item);

      prUnitSaleListData2.add(item["unit"]);
    }
    isLoading = false;
    notifyListeners();
    print("full data .vcvc.....${orderitemListdata2}");
    print("prUnitSaleListData2.....${prUnitSaleListData2}");
    frstDropDown = prUnitSaleListData2[0];
    // selectedItem=prUnitSaleListData2[0];
    print("frstDropDown.....${frstDropDown}");
    notifyListeners();
  }

///////////////////////////////////////////////////////////////////
  setUnitSale_X001(String selected, int index) {
    double? calculatedRate;
    selectedunit_X001 = selected;

    for (int i = 0; i < salesitemListdata2.length; i++) {
      if (salesitemListdata2[i]["unit"] == selectedunit_X001) {
        print(
            "selected---${salesitemListdata2[i]["pkg"]}-----${salesitemListdata2[i]["rate1"]}");
        package = salesitemListdata2[i]["pkg"].toDouble();
        calculatedRate = salesitemListdata2[i]["pkg"] *
            double.parse(salesitemListdata2[i]["rate1"]);

        salesrate_X001[index].text = calculatedRate.toString();

        notifyListeners();
      }
    }

    notifyListeners();
  }

  ////////////////////////////////////////
  setUnitOrder_X001(String selected, int index) async {
    // double? calculatedRate;
    selectedunit_X001 = selected;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("selected-cxcd--${orderitemListdata2}----}");
    for (int i = 0; i < orderitemListdata2.length; i++) {
      if (orderitemListdata2[i]["unit"] == selectedunit_X001) {
        print(
            "selected---${orderitemListdata2[i]["pkg"]}-----${orderitemListdata2[i]["rate1"]}");
        package = orderitemListdata2[i]["pkg"].toDouble();

        calculatedRate = orderitemListdata2[i]["pkg"] *
            double.parse(orderitemListdata2[i]["rate1"]);
        notifyListeners();

        orderrate_X001[index].text = calculatedRate.toString();
        calculateOrderNetAmount(index, double.parse(orderrate_X001[index].text),
            double.parse(qty[index].text));
        notifyListeners();
        print("calculatedRate--xx--${orderrate_X001[index].text}---$index");

        notifyListeners();
      }
    }

    notifyListeners();
  }

  ////////////////////////////////////////
  calculateOrderNetAmount(int index, double rateA, double qtyA) {
    orderNetAmount = rateA * qtyA;
    print("rateA------$rateA------qtyA-----$qtyA----$orderNetAmount");
    notifyListeners();
  }

//////////////////////////////////////
  setDropdowndata(String s, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    for (int i = 0; i < branch_List.length; i++) {
      if (branch_List[i]["br_id"] == s) {
        branch_name = branch_List[i]["br_name"];
        br_id = s;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("br_id", s);
        prefs.setString("br_name", branch_name!);

        br_addr_map = {
          "br_id": s,
          "br_name": branch_name,
          "ad1": branch_List[i]["ad1"].toString(),
          "ad2": branch_List[i]["ad2"].toString(),
          "ad3": branch_List[i]["ad3"].toString(),
          "pcode": branch_List[i]["pcode"].toString(),
          "land": branch_List[i]["land"].toString(),
          "mob": branch_List[i]["mob"].toString(),
          "em": branch_List[i]["em"].toString(),
          "gst": branch_List[i]["gst"].toString(),
        };

        br_id = prefs.getString("br_id");
        branch_name = prefs.getString("br_name");
      }
    }

    var res = await OrderAppDB.instance.updateRegistrationtable(br_addr_map);
    isLoading = false;
    print("s------$s");
    getCompanyData(context);
    //  Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) => CompanyDetails(
    //                       type: "",
    //                       msg: "",
    //                       br_length: br_length,
    //                     )),
    //           );
    notifyListeners();
  }
}
