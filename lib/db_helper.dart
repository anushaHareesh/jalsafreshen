import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salesapp/model/accounthead_model.dart';
import 'package:salesapp/model/productUnitsModel.dart';
import 'package:salesapp/model/productdetails_model.dart';
import 'package:salesapp/model/productsCategory_model.dart';
import 'package:salesapp/model/settings_model.dart';
import 'package:salesapp/model/userType_model.dart';
import 'package:salesapp/model/wallet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model/productCompany_model.dart';
import 'model/registration_model.dart';
import 'model/staffarea_model.dart';
import 'model/staffdetails_model.dart';

class OrderAppDB {
  DateTime date = DateTime.now();
  String? formattedDate;
  var aidsplit;
  // String? areaidfromStaff;
  static final OrderAppDB instance = OrderAppDB._init();
  static Database? _database;
  OrderAppDB._init();
  /////////registration fields//////////
  static final id = 'id';
  static final cid = 'cid';
  static final fp = 'fp';
  static final os = 'os';
  static final c_d = 'c_d';
  static final cpre = 'cpre';
  static final ctype = 'ctype';
  static final hoid = 'hoid';
  static final cnme = 'cnme';
  static final ad1 = 'ad1';
  static final ad2 = 'ad2';
  static final pcode = 'pcode';
  static final ad3 = 'ad3';
  static final land = 'land';
  static final mob = 'mob';
  static final em = 'em';
  static final gst = 'gst';
  static final ccode = 'ccode';
  static final scode = 'scode';
  static final msg = 'msg';

/////////// staff details /////////////
  static final sid = 'sid';
  static final sname = 'sname';
  static final uname = 'uname';
  static final pwd = 'pwd';
  static final ph = 'ph';
  static final area = 'area';
  static final datetime = 'datetime';

  // int DB_VERSION = 2;

  //////////////Staff area details////////////////////////
  static final aid = 'aid';
  static final aname = 'aname';

  ///////////product units///////////////////////////////////
  static final unit_name = 'unit_name';
  static final package = 'package';

  //////////////account heads///////////////////////////////
  static final ac_code = 'ac_code';
  static final hname = 'hname';
  static final gtype = 'gtype';
  static final ac_ad1 = 'ac_ad1';
  static final ac_ad2 = 'ac_ad2';
  static final ac_ad3 = 'ac_ad3';
  static final area_id = 'area_id';
  static final phn = 'phn';
  static final ba = 'ba';
  static final ri = 'ri';
  static final rc = 'rc';
  static final ht = 'ht';
  static final mo = 'mo';
  static final ac_gst = 'ac_gst';
  static final ac = 'ac';
  static final cag = 'cag';
  /////////////////userTable/////////
  static final uid = 'uid';
  static final u_name = 'u_name';
  static final upwd = 'upwd';
  // static final status = 'cag';

  ///////////customr table///////////////
  // static final ac_code = 'uid';

  /////////////productdetails//////////
  static final pid = 'pid';
  static final code = 'code';
  static final ean = 'ean';
  static final item = 'item';
  static final unit = 'unit';
  static final categoryId = 'categoryId';
  static final companyId = 'companyId';
  static final stock = 'stock';
  static final hsn = 'hsn';
  static final tax = 'tax';
  static final prate = 'prate';
  static final mrp = 'mrp';
  static final cost = 'cost';
  static final rate1 = 'rate1';
  static final rate2 = 'rate2';
  static final rate3 = 'rate3';
  static final rate4 = 'rate4';
  static final priceflag = 'priceflag';

  ////////////////prooduct category///////////////
  static final cat_id = 'cat_id';
  static final cat_name = 'cat_name';
  ////////////////// product company ////////////////
  static final comid = 'comid';
  static final comanme = 'comanme';
///////////////// ORDER MASTER ////////////////////
  static final order_id = 'order_id';

  static final ordernum = 'ordernum';
  static final orderdate = 'orderdate';
  static final ordertime = 'ordertime';

  static final customerid = 'customerid';
  static final userid = 'userid';
  static final areaid = 'areaid';
  static final status = 'status';
  static final total_price = 'total_price';
/////////////////////// return master //////
  static final return_id = 'return_id';
  static final return_date = 'return_date';
  static final return_time = 'return_time';
  static final reason = 'reason';
  static final reference_no = 'reference_no';
///////////////////////////////////////////
  static final prefix = 'prefix';
  static final value = 'value';
  static final tabname = 'tabname';

/////////////////// cart table/////////////
  static final cartdate = 'cartdate';
  static final carttime = 'carttime';
  static final cartrowno = 'cartrowno';
  static final qty = 'qty';
  static final rate = 'rate';
  static final totalamount = 'totalamount';
  static final cstatus = 'cstatus';
  static final row_num = 'row_num';
  static final itemName = 'itemName';
  static final numberof_items = 'numberof_items';

////////////////////menu table////////////////
  static final menu_index = 'menu_index';
  static final menu_name = 'menu_name';
  static final user = 'user';

  ////////////settings//////////////////////
  static final set_id = 'set_id';
  static final set_code = 'set_code';
  static final set_value = 'set_value';
  static final set_type = 'set_type';

/////////wallet table//////////////////
  static final waid = 'waid';
  static final wname = 'wname';
////////////collection table///////////////
  static final rec_date = 'rec_date';
  static final rec_cusid = 'rec_cusid';
  static final rec_series = 'rec_series';
  static final rec_mode = 'rec_mode';
  static final rec_amount = 'rec_amount';
  static final rec_row_num = 'rec_row_num';
  static final rec_disc = 'rec_disc';
  static final rec_note = 'rec_note';
  static final rec_staffid = 'rec_staffid';
  static final rec_cancel = 'rec_cancel';
  static final rec_status = 'rec_status';
  static final rec_time = 'rec_time';
///////remark table//////////////////////

  static final rem_date = 'rem_date';
  static final rem_cusid = 'rem_cusid';
  static final rem_series = 'rem_series';
  static final rem_text = 'rem_text';
  static final rem_staffid = 'rem_staffid';
  static final rem_row_num = 'rem_row_num';
  static final rem_cancel = 'rem_cancel';
  static final rem_status = 'rem_status';
  static final rem_time = 'rem_time';

  //////////////////sales bag//////////////////
  static final method = 'method';
  static final discount_per = 'discount_per';
  static final discount_amt = 'discount_amt';

  ///////////////// sales details /////////
  static final item_name = 'item_name';
  static final hsn_code = 'hsn_code';
  static final gross_amount = 'gross_amount';
  static final tax_per = 'tax_per';
  static final tax_amt = 'tax_amt';
  static final ces_per = 'ces_per';
  static final ces_amt = 'ces_amt';
  static final dis_amt = 'dis_amt';
  static final dis_per = 'dis_per';
  static final net_amt = 'net_amt';
  static final sales_id = 'sales_id';
  static final unit_rate = 'unit_rate';
  ///////////// salesmastertable////////
  static final salestime = 'salestime';
  static final salesdate = 'salesdate';
  static final cus_type = 'cus_type';
  static final customer_id = 'customer_id';
  static final staff_id = 'staff_id';
  static final cgst_per = 'cgst_per';
  static final sgst_per = 'sgst_per';
  static final igst_per = 'igst_per';
  static final cgst_amt = 'cgst_amt';
  static final sgst_amt = 'sgst_amt';
  static final igst_amt = 'igst_amt';
  static final igst = 'igst';
  static final total_qty = 'total_qty';
  static final payment_mode = 'payment_mode';
  static final credit_option = 'credit_option';
  static final bill_no = 'bill_no';
  static final gross_tot = 'gross_tot';
  static final dis_tot = 'dis_tot';
  static final state_status = 'state_status';
  static final tax_tot = 'tax_tot';
  static final ces_tot = 'ces_tot';
  static final rounding = 'rounding';
  static final set_method = 'set_method';
  static final palign = 'palign';
  static final punderline = 'punderline';
  static final ptext = 'ptext';
  static final pwidth = 'pwidth';
  static final pbold = 'pbold';
  static final packing = 'packing';
  static final unitNum = 'unitNum';
  static final baserate = 'baserate';
  static final cancel = 'cancel';
  static final cancel_staff = 'cancel_staff';
  static final cancel_dateTime = 'cancel_dateTime';

  Future<Database> get database async {
    print("bjhs");
    if (_database != null) return _database!;
    _database = await _initDB("orderapp.db");
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    print("db---");
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(
      path,
      version: 1, onCreate: _createDB,
      //  onUpgrade: _upgradeDB
    );
  }

  // _upgradeDB(Database db, int oldVersion, int newVersion) {
  //   print("hszbds");
  //   // var batch = db.batch();
  //   print("old-----$oldVersion---$newVersion");

  //   if (oldVersion == 2) {
  //     print("yes");
  //     alterUserTable(db);
  //   }
  //   if (oldVersion == 4) {
  //     print("yes 4");
  //     alterstaffDetailsTable(db);
  //   }
  //   // batch.commit();
  // }

  // alterUserTable(Database db) {
  //   print("batch");
  //   db.execute('alter table userTable add column newClumn text;');
  //   //  batch.commit();
  // }

  // alterstaffDetailsTable(Database db) {
  //   print("batch 4");
  //   db.execute('alter table staffDetailsTable add column newClumn text;');
  //   //  batch.commit();
  // }

  Future _createDB(Database db, int version) async {
    print("table created");
    ///////////////orderapp store table ////////////////
    await db.execute('''
          CREATE TABLE registrationTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $cid TEXT NOT NULL,
            $fp TEXT NOT NULL,
            $os TEXT NOT NULL,
            $cpre TEXT,
            $ctype TEXT,
            $cnme TEXT,
            $ad1 TEXT,
            $ad2 TEXT,
            $ad3 TEXT,
            $pcode TEXT,
            $land TEXT,
            $mob TEXT,
            $em TEXT,
            $gst TEXT,
            $ccode TEXT,
            $scode TEXT,
            $msg TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE staffDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $sid TEXT NOT NULL,
            $sname TEXT,
            $uname TEXT,
            $pwd TEXT,
            $ad1 TEXT,
            $ad2 TEXT,
            $ad3 TEXT,
            $ph TEXT,
            $area TEXT    
          )
          ''');
    await db.execute('''
      CREATE TABLE userTable (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $uid TEXT NOT NULL,
        $u_name TEXT,
        $upwd TEXT,
        $status INTEGER
         )
         ''');

    await db.execute('''
          CREATE TABLE staffLoginDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $sid TEXT NOT NULL,
            $sname TEXT,
            $datetime TEXT    
          )
          ''');
    await db.execute('''
          CREATE TABLE areaDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $aid TEXT NOT NULL,
            $aname TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE customerTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $ac_code TEXT NOT NULL
         )
         ''');
    ////////////////account_haed table///////////////////
    await db.execute('''
          CREATE TABLE accountHeadsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $ac_code TEXT NOT NULL,
            $hname TEXT NOT NULL,
            $gtype TEXT NOT NULL,
            $ac_ad1 TEXT,
            $ac_ad2 TEXT,
            $ac_ad3 TEXT,
            $area_id TEXT,
            $phn TEXT,
            $ba REAL,
            $ri TEXT,
            $rc TEXT,
            $ht TEXT,
            $mo TEXT,
            $ac_gst TEXT,
            $ac TEXT,
            $cag TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE productDetailsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $pid INTEGER,
            $code TEXT NOT NULL,
            $ean TEXT,
            $item TEXT,
            $unit TEXT,
            $categoryId TEXT,
            $companyId TEXT,
            $stock TEXT,
            $hsn TEXT,
            $tax TEXT,
            $prate TEXT,
            $mrp TEXT,
            $cost TEXT,
            $rate1 TEXT,
            $rate2 TEXT,
            $rate3 TEXT,
            $rate4 TEXT,
            $priceflag TEXT

          )
          ''');
    //////////////////////////products category////////////////////
    await db.execute('''
          CREATE TABLE productsCategory (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $cat_id TEXT NOT NULL,
            $cat_name TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE companyTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $comid TEXT NOT NULL,
            $comanme TEXT
          )
          ''');
    /////////////// order master table//////////
    await db.execute('''
          CREATE TABLE orderMasterTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $order_id INTEGER,
            $orderdate TEXT,
            $ordertime TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $userid TEXT,
            $areaid TEXT,
            $status INTEGER,
            $total_price REAL
          )
          ''');
    ///////////// sales master table //////////////////

    await db.execute('''
          CREATE TABLE salesMasterTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $sales_id INTEGER,
            $salesdate TEXT,
            $salestime TEXT,
            $os TEXT NOT NULL,
            $cus_type TEXT,
            $bill_no TEXT,
            $customer_id TEXT,
            $staff_id TEXT,
            $areaid TEXT,
            $total_qty INTEGER,
            $payment_mode TEXT,
            $credit_option TEXT,
            $gross_tot REAL,
            $dis_tot REAL,
            $tax_tot REAL,
            $ces_tot REAL,
            $rounding REAL,
            $net_amt REAL,
            $state_status INTEGER,
            $status INTEGER,
            $cancel INTEGER,
            $cancel_staff TEXT,
            $cancel_dateTime TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE orderDetailTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $item TEXT,
            $os TEXT NOT NULL,
            $order_id INTEGER,
            $row_num INTEGER,
            $code TEXT,
            $qty INTEGER,
            $unit TEXT,
            $rate REAL,
            $packing TEXT,
            $baserate REAL  
          )
          ''');
    ///////////////////////////////
    await db.execute('''
          CREATE TABLE salesDetailTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $os TEXT NOT NULL,
            $sales_id INTEGER,
            $row_num INTEGER,
            $hsn TEXT,
            $item_name TEXT,
            $code TEXT,
            $qty INTEGER,
            $unit TEXT,
            $gross_amount REAL,
            $dis_amt REAL,
            $dis_per REAL,
            $tax_amt REAL,
            $tax_per REAL,
            $cgst_per REAL,
            $cgst_amt REAL,
            $sgst_per REAL,
            $sgst_amt REAL,
            $igst_per REAL,
            $igst_amt REAL,
            $ces_amt REAL,
            $ces_per REAL,
            $net_amt REAL,
            $rate REAL,
            $unit_rate REAL,  
            $packing TEXT,
            $baserate REAL
          )
          ''');
    await db.execute('''
          CREATE TABLE orderBagTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $itemName TEXT NOT NULL,
            $cartdate TEXT,
            $carttime TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $cartrowno INTEGER,
            $code TEXT,
            $qty REAL,
            $rate TEXT,
            $totalamount TEXT,
            $pid INTEGER,
            $unit_name TEXT,
            $package REAL,
            $baserate REAL,
            $cstatus INTEGER
          )
          ''');

    await db.execute('''
          CREATE TABLE returnBagTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $itemName TEXT NOT NULL,
            $cartdate TEXT,
            $carttime TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $cartrowno INTEGER,
            $code TEXT,
            $qty REAL,
            $rate TEXT,
            $totalamount TEXT,
            $pid INTEGER,
            $unit_name TEXT,
            $package REAL,
            $baserate REAL,
            $cstatus INTEGER
          )
          ''');
    ////////////////////////////////////////
    await db.execute('''
          CREATE TABLE salesBagTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $itemName TEXT NOT NULL,
            $cartdate TEXT,
            $carttime TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $cartrowno INTEGER,
            $code TEXT,
            $qty REAL,
            $rate REAL,
            $unit_rate REAL,
            $totalamount REAL,
            $method TEXT,
            $hsn TEXT,
            $tax_per REAL,
            $tax_amt REAL, 
            $cgst_per REAL,
            $cgst_amt REAL,
            $sgst_per REAL,
            $sgst_amt REAL,
            $igst_per REAL,
            $igst_amt REAL,
            $discount_per REAL,
            $discount_amt REAL,
            $ces_per REAL,
            $ces_amt REAL,
            $cstatus INTEGER,
            $net_amt REAL,
            $pid INTEGER,
            $unit_name TEXT,
            $package REAL,
            $baserate REAL
          )
          ''');
    await db.execute('''
          CREATE TABLE maxSeriesTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $tabname TEXT,
            $prefix TEXT,
            $value INTEGER    
          )
          ''');
    /////////////////////////////////////////
    await db.execute('''
          CREATE TABLE menuTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $menu_index TEXT NOT NULL,
            $menu_name TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE settingsTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $set_id INTEGER NOT NULL,
            $set_code TEXT,
            $set_value TEXT,
            $set_type INTEGER  
          )
          ''');

    await db.execute('''
          CREATE TABLE maxTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $tabname TEXT NOT NULL,
            $prefix TEXT,
            $value TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE walletTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $waid TEXT NOT NULL,
            $wname TEXT
          )
          ''');
    await db.execute('''
      CREATE TABLE collectionTable (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $rec_date TEXT NOT NULL,
        $rec_time TEXT,
        $rec_cusid TEXT,
        $rec_row_num INTEGER,
        $rec_series TEXT NOT NULL,
        $rec_mode TEXT,
        $rec_amount REAL,
        $rec_disc TEXT,
        $rec_note TEXT,
        $rec_staffid TEXT,
        $rec_cancel INTEGER,
        $rec_status INTEGER
      )
      ''');
    await db.execute('''
      CREATE TABLE remarksTable (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $rem_date TEXT NOT NULL,
        $rem_time TEXT,
        $rem_cusid TEXT,
        $rem_series TEXT NOT NULL,
        $rem_text TEXT,
        $rem_staffid TEXT,
        $rem_row_num INTEGER,
        $rem_cancel INTEGER,
        $rem_status INTEGER
      )
      ''');
    await db.execute('''
          CREATE TABLE returnMasterTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $return_id INTEGER,
            $return_date TEXT,
            $return_time TEXT,
            $os TEXT NOT NULL,
            $customerid TEXT,
            $userid TEXT,
            $areaid TEXT,
            $status TEXT,
            $reason TEXT,
            $reference_no TEXT,
            $total_price REAL
          )
          ''');
    await db.execute('''
          CREATE TABLE returnDetailTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $item TEXT,
            $os TEXT NOT NULL,
            $return_id INTEGER,
            $row_num INTEGER,
            $code TEXT,
            $qty INTEGER,
            $unit TEXT,
            $rate REAL,
            $packing TEXT,
            $baserate REAL    
          )
          ''');
    await db.execute('''
          CREATE TABLE printTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $ptext TEXT,
            $pwidth INTEGER,
            $palign TEXT,
            $punderline INTEGER,
            $pbold INTEGER
          )
          ''');
    await db.execute('''
          CREATE TABLE productUnits (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $pid INTEGER,
            $package REAL,
            $unit_name TEXT
          )
          ''');
  }

  ////////////////////////company details select///////////////////////////////////
  selectCompany(String? condition) async {
    List result;
    Database db = await instance.database;

    result =
        await db.rawQuery('select * from registrationTable where $condition');

    print("select * from registrationTable where $condition");

    print("company deta-=-$result");
    if (result.length > 0) {
      return result;
    } else {
      return null;
    }
  }

  //////////////////////////////////////////////
  Future insertorderBagTable(
    String itemName,
    String cartdate,
    String carttime,
    String os,
    String customerid,
    int cartrowno,
    String code,
    double qty,
    String rate,
    String totalamount,
    int pid,
    String? unit_name,
    double packagenm,
    double baseRate,
    int cstatus,
  ) async {
    print("qty--$qty");
    print("unit_name........$customerid...$unit_name");
    final db = await database;
    var res;
    var query3;
    var query2;
    List<Map<String, dynamic>> res1 = await db.rawQuery(
        'SELECT  * FROM orderBagTable WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}" AND unit_name="${unit_name}"');
    print("SELECT from ---$res1");
    if (res1.length == 1) {
      double qty1 = res1[0]["qty"];
      double updatedQty = qty1 + qty;
      double amount = double.parse(res1[0]["totalamount"]);
      print("res1.length----${res1.length}");

      double amount1 = double.parse(totalamount);
      double updatedAmount = amount + amount1;
      print("upadted qty--$qty---$updatedAmount");
      var res = await db.rawUpdate(
          'UPDATE orderBagTable SET qty=$qty , totalamount="${updatedAmount}" WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}"');
      print("response-------$res");
    } else {
      query2 =
          'INSERT INTO orderBagTable (itemName, cartdate, carttime , os, customerid, cartrowno, code, qty, rate, totalamount, pid, unit_name, package, baseRate, cstatus) VALUES ("${itemName}","${cartdate}","${carttime}", "${os}", "${customerid}", $cartrowno, "${code}", $qty, "${rate}", "${totalamount}",  $pid, "$unit_name", "$packagenm", $baseRate, $cstatus)';
      var res = await db.rawInsert(query2);
    }

    print("insert query result $res");
    print("insert-----$query2");
    return res;
  }

//////////////////////////////////////////////////////////////////////
  Future insertorderBagTable_X001(
    String itemName,
    String cartdate,
    String carttime,
    String os,
    String customerid,
    int cartrowno,
    String code,
    double qty,
    String rate,
    String totalamount,
    int pid,
    String? unit_name,
    double packagenm,
    double baseRate,
    int cstatus,
  ) async {
    print("qty--$qty");
    print("unit_name........$customerid...$unit_name");
    final db = await database;
    // var res;
    var query3;
    var query2;
    // List<Map<String, dynamic>> res1 = await db.rawQuery(
    //     'SELECT  * FROM orderBagTable WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}" AND unit_name="${unit_name}"');
    // print("insert x001 query result $res1");

    // if (res1.length == 1) {
    //   double qty1 = res1[0]["qty"];
    //   double updatedQty = qty1 + qty;
    //   double amount = double.parse(res1[0]["totalamount"]);
    //   print("res1.length----${res1.length}");

    //   double amount1 = double.parse(totalamount);
    //   double updatedAmount = amount + amount1;
    //   query2 = await db.rawUpdate(
    //       'UPDATE orderBagTable SET qty=$qty , totalamount="${totalamount}" WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}" AND unit_name="${unit_name}"');
    // } else {
    query2 =
        'INSERT INTO orderBagTable (itemName, cartdate, carttime , os, customerid, cartrowno, code, qty, rate, totalamount, pid, unit_name, package, baseRate, cstatus) VALUES ("${itemName}","${cartdate}","${carttime}", "${os}", "${customerid}", $cartrowno, "${code}", $qty, "${rate}", "${totalamount}",  $pid, "$unit_name", "$packagenm", $baseRate, $cstatus)';
    var res = await db.rawInsert(query2);
    // }

    print("insert query result $res");
    print("insert-----$query2");
    return res;
  }

//////////////////////////////////////////////////////////////////////
  insertreturnBagTable(
    String itemName,
    String cartdate,
    String carttime,
    String os,
    String customerid,
    int cartrowno,
    String code,
    double qty,
    String rate,
    String totalamount,
    int pid,
    String? unit_name,
    double packagenm,
    double baseRate,
    int cstatus,
  ) async {
    print("qty--$qty...$unit_name..$packagenm...$cartrowno");
    print("code...........$code");
    final db = await database;
    print("qty--$qty");
    print("unit_name...........$unit_name");

    var res;
    var query3;
    var query2;
    List<Map<String, dynamic>> res1 = await db.rawQuery(
        'SELECT  * FROM returnBagTable WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}" AND unit_name="${unit_name}"');
    print("SELECT from ---$res1");
    if (res1.length == 1) {
      double qty1 = res1[0]["qty"];
      double updatedQty = qty1 + qty;
      double amount = double.parse(res1[0]["totalamount"]);
      print("res1.length----${res1.length}");

      double amount1 = double.parse(totalamount);
      double updatedAmount = amount + amount1;
      print("upadted qty--$qty---$updatedAmount");
      var res = await db.rawUpdate(
          'UPDATE returnBagTable SET qty=$qty , totalamount="${updatedAmount}" WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}"');
      print("response-------$res");
    } else {
      query2 =
          'INSERT INTO returnBagTable (itemName, cartdate, carttime , os, customerid, cartrowno, code, qty, rate, totalamount, pid, unit_name, package, baseRate, cstatus) VALUES ("${itemName}","${cartdate}","${carttime}", "${os}", "${customerid}", $cartrowno, "${code}", $qty, "${rate}", "${totalamount}",  $pid, "$unit_name", "$packagenm", $baseRate, $cstatus)';
      var res = await db.rawInsert(query2);
    }

    print("insert query result $res");
    print("insert-----$query2");
    return res;
  }

////////////////////////// insert into sales bag table /////////////////
  insertsalesBagTable(
    String itemName,
    String cartdate,
    String carttime,
    String os,
    String customerid,
    int cartrowno,
    String code,
    double qty,
    String rate,
    double unit_rate,
    double totalamount,
    String method,
    String hsn,
    double tax_per,
    double tax,
    double cgst_per,
    double cgst_amt,
    double sgst_per,
    double sgst_amt,
    double igst_per,
    double igst_amt,
    double discount_per,
    double discount_amt,
    double ces_per,
    double ces_amt,
    int cstatus,
    double net_amt,
    int pid,
    String? unit_name,
    double packagenm,
    double baseRate,
  ) async {
    print("qty--$qty");
    print("unit_name...........$unit_name");
    final db = await database;
    var res;
    var query3;
    var query2;
    print(
        "baseRate calculated....$rate.....$baseRate...$unit_name.....$net_amt......$packagenm----$tax---$discount_per----$discount_amt");

    List<Map<String, dynamic>> res1 = await db.rawQuery(
        'SELECT  * FROM salesBagTable WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}" AND unit_name="${unit_name}"');
    print("res1cvc ---$res1");

    if (res1.length == 1) {
      var que =
          'UPDATE salesBagTable SET qty=$qty , totalamount="${totalamount}" , net_amt=$net_amt ,tax_amt=$tax ,discount_per=$discount_per, discount_amt=$discount_amt,cgst_amt=$cgst_amt,sgst_amt=$sgst_amt,igst_amt=$igst_amt,unit_rate=$unit_rate  WHERE customerid="${customerid}" AND os = "${os}" AND code="${code}" AND unit_name="${unit_name}"';

      print("que----$que");
      var res = await db.rawUpdate(que);
      print("response-------$res");
    } else {
      query2 =
          'INSERT INTO salesBagTable (itemName, cartdate, carttime , os, customerid, cartrowno, code, qty, rate,unit_rate, totalamount, method, hsn,tax_per, tax_amt, cgst_per, cgst_amt, sgst_per, sgst_amt, igst_per, igst_amt, discount_per, discount_amt, ces_per,ces_amt, cstatus, net_amt, pid, unit_name, package, baseRate) VALUES ("${itemName}","${cartdate}","${carttime}", "${os}", "${customerid}", $cartrowno, "${code}", $qty, "${rate}",$unit_rate, "${totalamount}","${method}", "${hsn}",${tax_per}, ${tax}, ${cgst_per}, ${cgst_amt}, ${sgst_per}, ${sgst_amt}, ${igst_per}, ${igst_amt}, ${discount_per}, ${discount_amt}, ${ces_per},${ces_amt}, $cstatus,"$net_amt" , $pid, "$unit_name", $packagenm, $baseRate)';

      var res = await db.rawInsert(query2);
    }

    print("insert query result $res");
    print("insert-query2----$query2");
    return res;
  }

  /////////////////////////////////////////////////////////////////////////
  insertsalesBagTable_X001(
    String itemName,
    String cartdate,
    String carttime,
    String os,
    String customerid,
    int cartrowno,
    String code,
    double qty,
    String rate,
    double unit_rate,
    double totalamount,
    String method,
    String hsn,
    double tax_per,
    double tax,
    double cgst_per,
    double cgst_amt,
    double sgst_per,
    double sgst_amt,
    double igst_per,
    double igst_amt,
    double discount_per,
    double discount_amt,
    double ces_per,
    double ces_amt,
    int cstatus,
    double net_amt,
    int pid,
    String? unit_name,
    double packagenm,
    double baseRate,
  ) async {
    print("qty--$qty");
    print("unit_name...........$unit_name");
    final db = await database;

    var query3;
    var query2;
    print(
        "baseRate calculated....$rate.....$baseRate...$unit_name.....$net_amt......$packagenm----$tax---$discount_per----$discount_amt");

    query2 =
        'INSERT INTO salesBagTable (itemName, cartdate, carttime , os, customerid, cartrowno, code, qty, rate,unit_rate, totalamount, method, hsn,tax_per, tax_amt, cgst_per, cgst_amt, sgst_per, sgst_amt, igst_per, igst_amt, discount_per, discount_amt, ces_per,ces_amt, cstatus, net_amt, pid, unit_name, package, baseRate) VALUES ("${itemName}","${cartdate}","${carttime}", "${os}", "${customerid}", $cartrowno, "${code}", $qty, "${rate}",$unit_rate, "${totalamount}","${method}", "${hsn}",${tax_per}, ${tax}, ${cgst_per}, ${cgst_amt}, ${sgst_per}, ${sgst_amt}, ${igst_per}, ${igst_amt}, ${discount_per}, ${discount_amt}, ${ces_per},${ces_amt}, $cstatus,"$net_amt" , $pid, "$unit_name", $packagenm, $baseRate)';

    var res = await db.rawInsert(query2);

    print("insert query result $res");
    print("insert-query2----$query2");
    return res;
  }

  /////////////////////// order master table insertion//////////////////////
  Future insertorderMasterandDetailsTable(
    String item,
    int order_id,
    double? qty,
    double rate,
    String? code,
    String orderdate,
    String ordertime,
    String os,
    String customerid,
    String userid,
    String areaid,
    int status,
    String? unit,
    int rowNum,
    String table,
    double total_price,
    double? packing,
    double? base_rate,
  ) async {
    final db = await database;
    var res2;
    var res3;

    if (table == "orderDetailTable") {
      print("unit name..............$unit");
      var query2 =
          'INSERT INTO orderDetailTable(order_id, row_num,os,code, item, qty, rate, unit, packing, baserate) VALUES(${order_id},${rowNum},"${os}","${code}","${item}", ${qty}, $rate, "${unit}", $packing, $base_rate)';
      print(query2);
      res2 = await db.rawInsert(query2);
    } else if (table == "orderMasterTable") {
      var query3 =
          'INSERT INTO orderMasterTable(order_id, orderdate, ordertime, os, customerid, userid, areaid, status, total_price) VALUES("${order_id}", "${orderdate}", "${ordertime}", "${os}", "${customerid}", "${userid}", "${areaid}", ${status},${total_price})';
      res2 = await db.rawInsert(query3);
      print(query3);
    }
  }

  //////////// Insert into sales master and sales details table/////////////
  Future insertsalesMasterandDetailsTable(
      int sales_id,
      double? qty,
      double rate,
      double unit_rate,
      String? code,
      String hsn,
      String salesdate,
      String salestime,
      String os,
      String customer_id,
      String cus_type,
      String bill_no,
      String staff_id,
      String areaid,
      int total_qty,
      String payment_mode,
      String credit_option,
      String unit,
      int rowNum,
      String table,
      String item_name,
      double gross_amount,
      double dis_amt,
      double dis_per,
      double tax_amt,
      double tax_per,
      double cgst_per,
      double cgst_amt,
      double sgst_per,
      double sgst_amt,
      double igst_per,
      double igst_amt,
      double ces_amt,
      double ces_per,
      double gross_tot,
      double dis_tot,
      double tax_tot,
      double ces_tot,
      double net_amt,
      double total_price,
      double rounding,
      int state_status,
      int status,
      double? unit_value,
      double? base_rate,
      double? packing,
      int cancelStatus,
      String cancel_staff,
      String cancel_dateTime) async {
    final db = await database;
    var res2;
    var res3;
    print("total quantity......$payment_mode...$credit_option");
    if (table == "salesDetailTable") {
      var query2 =
          'INSERT INTO salesDetailTable(os, sales_id, row_num,hsn , item_name , code, qty, unit , gross_amount, dis_amt, dis_per, tax_amt, tax_per, cgst_per, cgst_amt, sgst_per, sgst_amt, igst_per, igst_amt, ces_amt, ces_per, net_amt, rate, unit_rate, packing, baserate) VALUES("${os}", ${sales_id}, ${rowNum},"${hsn}", "${item_name}", "${code}", ${qty}, "${unit}", $gross_amount, $dis_amt, ${dis_per}, ${tax_amt.toStringAsFixed(3)}, $tax_per, ${cgst_per}, ${cgst_amt.toStringAsFixed(3)}, ${sgst_per}, ${sgst_amt.toStringAsFixed(3)}, ${igst_per}, ${igst_amt.toStringAsFixed(3)}, $ces_amt, $ces_per, $total_price, $rate, $unit_rate, $packing, $base_rate)';
      print("insert salesdetails $query2");
      res2 = await db.rawInsert(query2);
    } else if (table == "salesMasterTable") {
      var query3 =
          'INSERT INTO salesMasterTable(sales_id, salesdate, salestime, os, cus_type, bill_no, customer_id, staff_id, areaid, total_qty, payment_mode, credit_option, gross_tot, dis_tot, tax_tot, ces_tot, rounding, net_amt,  state_status, status , cancel ,cancel_staff,cancel_dateTime) VALUES("${sales_id}", "${salesdate}", "${salestime}", "${os}", "${cus_type}", "${bill_no}", "${customer_id}", "${staff_id}", "${areaid}", $total_qty, "${payment_mode}", "${credit_option}", $gross_tot, $dis_tot, $tax_tot, $ces_tot,${rounding}, ${total_price.toStringAsFixed(2)}, $state_status, ${status},${cancelStatus},"${cancel_staff}","${cancel_dateTime}")';
      res2 = await db.rawInsert(query3);
      print("insertsalesmaster$query3");
    }
  }

  ////////////////////insert to return table/////////////////////////////////
  Future insertreturnMasterandDetailsTable(
    String item,
    int return_id,
    double qty,
    double rate,
    String? code,
    String return_date,
    String return_time,
    String os,
    String customerid,
    String userid,
    String areaid,
    int status,
    String? unit,
    int rowNum,
    String table,
    double total_price,
    String reason,
    String refNo,
    double? unit_value,
    double? base_rate,
    double? packing,
  ) async {
    final db = await database;
    var res2;
    var res3;
    int qty1 = qty.toInt();
    print("qty return.......$unit.....$qty...$qty1");
    if (table == "returnDetailTable") {
      var query2 =
          'INSERT INTO returnDetailTable(return_id, row_num,os,code, item, qty, unit, rate, packing, baserate) VALUES(${return_id},${rowNum},"${os}","${code}","${item}", ${qty1}, "${unit}", ${rate}, $packing, $base_rate)';
      print(query2);
      res2 = await db.rawInsert(query2);
    } else if (table == "returnMasterTable") {
      var query3 =
          'INSERT INTO returnMasterTable(return_id, return_date, return_time, os, customerid, userid, areaid, status, total_price, reference_no, reason) VALUES("${return_id}", "${return_date}", "${return_time}", "${os}", "${customerid}", "${userid}", "${areaid}", ${status},${total_price},"${refNo}", "${reason}")';
      res2 = await db.rawInsert(query3);
      print(query3);
    }
  }

  //////////////////////////menu table//////////////////////////////////////////
  Future insertMenuTable(String menu_prefix, String menu_name) async {
    print("menu_prefix  menu_name ");
    final db = await database;
    // deleteFromTableCommonQuery('menuTable', "");
    var query1 =
        'INSERT INTO menuTable(menu_index,menu_name) VALUES("${menu_prefix}", "${menu_name}")';
    var res = await db.rawInsert(query1);
    print("menu----${query1}");
    print("menu----${res}");
    // print(res);
    return res;
  }

  /////////////////////////customer table insertion/////////////////////////////
  Future insertCustomerTable(String ac_code) async {
    final db = await database;
    // deleteFromTableCommonQuery('menuTable', "");
    var query1 = 'INSERT INTO customerTable(ac_code) VALUES("${ac_code}")';
    var res = await db.rawInsert(query1);
    // print("menu----${query1}");
    print("customerTable----${res}");
    // print(res);
    return res;
  }

  //////////////////////////wallet table/////////////////////////////////////
  Future insertwalletTable(WalletModal wallet) async {
    final db = await database;
    var query1 =
        'INSERT INTO walletTable(waid,wname) VALUES("${wallet.waid}", "${wallet.wanme}")';
    var res = await db.rawInsert(query1);
    print("wallet----${res}");
    // print(res);
    return res;
  }

  ////////////////////////settings insertion///////////////////////////////////
  Future insertsettingsTable(SettingsModel model) async {
    final db = await database;
    // deleteFromTableCommonQuery('menuTable', "");
    var query1 =
        'INSERT INTO settingsTable(set_id,set_code,set_value,set_type) VALUES(${model.setId},"${model.setCode}","${model.setValue}",${model.setType})';
    var res = await db.rawInsert(query1);
    // print("menu----${query1}");
    print("settingzz---${query1}");
    // print(res);
    return res;
  }

  ///////////////////// registration details insertion //////////////////////////
  Future insertRegistrationDetails(RegistrationData data) async {
    final db = await database;
    var query1 =
        'INSERT INTO registrationTable(cid, fp, os, cpre, ctype, cnme, ad1, ad2, ad3, pcode, land, mob, em, gst, ccode, scode, msg) VALUES("${data.cid}", "${data.fp}", "${data.os}","${data.c_d![0].cpre}", "${data.c_d![0].ctype}", "${data.c_d![0].cnme}", "${data.c_d![0].ad1}", "${data.c_d![0].ad2}", "${data.c_d![0].ad3}", "${data.c_d![0].pcode}", "${data.c_d![0].land}", "${data.c_d![0].mob}", "${data.c_d![0].em}", "${data.c_d![0].gst}", "${data.c_d![0].ccode}", "${data.c_d![0].scode}", "${data.msg}" )';
    var res = await db.rawInsert(query1);
    // print(query1);
    // print(res);
    return res;
  }

//////////////////////////////////////////////////////////////////////////////////
  updateRegistrationtable(Map map) async {
    final db = await database;
    print("reg map----from ------$map");
    var res = await db.rawUpdate(
        'UPDATE registrationTable SET ad1="${map["ad1"]}" , ad2="${map["ad2"]}" , ad3="${map["ad3"]}" ,pcode="${map["pcode"]}" , land="${map["land"]}" ,mob="${map["mob"]}" ,em="${map["em"]}" ,gst="${map["gst"]}"');
    // var res = await db.rawUpdate(
    //     'UPDATE registrationTable SET ad1="calicut" , ad2="pisss" , ad3="jhjhhf" , pcode="ttt" , land="jhddj" , mob="8998" ,em="987989" ,gst="8998945" ');
    //  var res = await db.rawInsert(query1);
    // print(query1);
    // print(res);
    return res;
  }

////////////////////select from orderBagTable//////////////////////

  Future<List<Map<String, dynamic>>> getOrderBagTable(
      String customerId, String os) async {
    print("enteredcustomerId---${customerId}----$os");
    // .of<Controller>(context, listen: false).customerList.clear();
    Database db = await instance.database;
    var res = await db.rawQuery(
        'SELECT  * FROM orderBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print(
        'SELECT  * FROM orderBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print("res---$res");
    return res;
  }

/////////////////////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getSaleBagTable(
      String customerId, String os) async {
    print("enteredcustomerId---${customerId}");
    // .of<Controller>(context, listen: false).customerList.clear();
    Database db = await instance.database;
    var res = await db.rawQuery(
        'SELECT  * FROM salesBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print(
        'SELECT  * FROM salesBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print("result sale cart...$res");
    return res;
  }

  //////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getreturnBagTable(
      String customerId, String os) async {
    print("enteredcustomerId---${customerId}");
    // .of<Controller>(context, listen: false).customerList.clear();
    Database db = await instance.database;
    var res = await db.rawQuery(
        'SELECT  * FROM returnBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print(
        'SELECT  * FROM returnBagTable WHERE customerid="${customerId}" AND os = "${os}"');
    print("result return cart...$res");
    return res;
  }

////////////////////// staff details insertion /////////////////////
  Future insertStaffDetails(StaffDetails sdata) async {
    final db = await database;
    var query2 =
        'INSERT INTO staffDetailsTable(sid, sname, uname, pwd, ad1, ad2, ad3, ph, area) VALUES("${sdata.sid}", "${sdata.sname}", "${sdata.unme}", "${sdata.pwd}", "${sdata.ad1}", "${sdata.ad2}", "${sdata.ad3}", "${sdata.ph}", "${sdata.area}")';
    var res = await db.rawInsert(query2);
    print(query2);
    // print(res);
    return res;
  }

///////////////userType/////////////////////////////////////////
  Future insertUserType(UserTypeModel udata) async {
    final db = await database;
    var query2 =
        'INSERT INTO userTable(uid, u_name, upwd, status) VALUES("${udata.uid}", "${udata.unme}", "${udata.upwd}",${udata.status})';
    var res = await db.rawInsert(query2);
    print(query2);
    // print(res);
    return res;
  }

////////////////////////staff login details table insert ////////////////
  Future insertStaffLoignDetails(
      String sid, String sname, String datetime) async {
    final db = await database;
    var query2 =
        'INSERT INTO staffLoginDetailsTable(sid, sname, datetime) VALUES("${sid}", "${sname}", "${datetime}")';
    var res = await db.rawInsert(query2);
    print("stafflog....$query2");
    // print(res);
    return res;
  }

////////////////////// staff area details insertion /////////////////////
  Future insertStaffAreaDetails(StaffArea adata) async {
    final db = await database;
    var query3 =
        'INSERT INTO areaDetailsTable(aid, aname) VALUES("${adata.aid}", "${adata.anme}")';
    var res = await db.rawInsert(query3);
    print(query3);
    print(res);
    return res;
  }

//////////////////////////product details ///////////////////////////////////////////
  Future insertProductDetails(ProductDetails pdata) async {
    final db = await database;
    var query3 =
        'INSERT INTO productDetailsTable(pid, code, ean, item, unit, categoryId, companyId, stock, hsn, tax, prate, mrp, cost, rate1, rate2, rate3, rate4, priceflag) VALUES(${pdata.pid},"${pdata.code}", "${pdata.ean}", "${pdata.item}", "${pdata.unit}", "${pdata.categoryId}", "${pdata.companyId}", "${pdata.stock}", "${pdata.hsn}", "${pdata.tax}", "${pdata.prate}", "${pdata.mrp}", "${pdata.cost}", "${pdata.rate1}", "${pdata.rate2}", "${pdata.rate3}", "${pdata.rate4}", "${pdata.priceFlag}")';
    var res = await db.rawInsert(query3);
    // print(query3);
    // print(res);
    return res;
  }

  Future close() async {
    final _db = await instance.database;
    _db.close();
  }

  /////////////////////////ustaff login authentication////////////
  selectStaff(String uname, String pwd) async {
    String result = "";
    List<String> resultList = [];
    String? sid;
    String? sname;

    print("uname---Password----${uname}--${pwd}");
    resultList.clear();
    print("before kkkk $resultList");
    Database db = await instance.database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM staffDetailsTable');
    for (var staff in list) {
      // print(
      //     "staff['uname'] & staff['pwd']------------------${staff['uname']}--${staff['pwd']}");
      if (uname.toLowerCase() == staff["uname"].toLowerCase() &&
          pwd == staff["pwd"]) {
        print("match");
        sid = staff['sid'];
        sname = staff['sname'];
        result = "success";
        resultList.add(result);
        resultList.add(sid!);
        resultList.add(sname!);
        break;
      } else {
        print("No match");
        result = "failed";
        sid = "";
        sname = "";

        // resultList.add(result);
        // resultList.add(sid);
      }
    }
    print("res===${resultList}");

    print("all data ${list}");

    return resultList;
  }

  /////////////////////////////////////////////////////////////////////////////
  selectUser(String uname, String pwd) async {
    String result = "";
    List<String> resultList = [];
    String? uid;
    print("uname---Password----${uname}--${pwd}");
    resultList.clear();
    print("before kkkk $resultList");
    Database db = await instance.database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM userTable');
    print("listttt---$list");

    for (var user in list) {
      if (user["u_name"].toLowerCase() == uname.toLowerCase() &&
          pwd == user["upwd"]) {
        uid = user['uid'].toString();
        result = "success";
        print("staffid..$sid");
        print("ok");
        resultList.add(result);
        resultList.add(uid);
        break;
      } else {
        result = "failed";
        uid = "";
      }
    }

    print("res===${resultList}");

    print("all data ${list}");

    return resultList;
  }

  /////////////////////////account heads insertion///////////////////////////////
  Future insertAccoundHeads(AccountHead accountHead) async {
    final db = await database;
    var query =
        'INSERT INTO accountHeadsTable(ac_code, hname, gtype, ac_ad1, ac_ad2, ac_ad3, area_id, phn, ba, ri, rc, ht, mo, ac_gst, ac, cag) VALUES("${accountHead.code}", "${accountHead.hname}", "${accountHead.gtype}", "${accountHead.ad1}", "${accountHead.ad2}", "${accountHead.ad3}", "${accountHead.aid}", "${accountHead.ph}", ${accountHead.ba}, "${accountHead.ri}", "${accountHead.rc}", "${accountHead.ht}", "${accountHead.mo}", "${accountHead.gst}", "${accountHead.ac}", "${accountHead.cag}")';
    var res = await db.rawInsert(query);
    print(query);
    print(res);
    return res;
  }

/////////////////////customer/////////////////////////////////////////
  Future createCustomer(
      String ac_code,
      String hname,
      String gtype,
      String ac_ad1,
      String ac_ad2,
      String ac_ad3,
      String area_id,
      String phn,
      String ri,
      double ba,
      String rc,
      String ht,
      String mo,
      String ac_gst,
      String ac,
      String cag) async {
    final db = await database;
    var query =
        'INSERT INTO accountHeadsTable(ac_code, hname, gtype, ac_ad1, ac_ad2, ac_ad3, area_id, phn, ba, ri, rc, ht, mo, ac_gst, ac, cag) VALUES("${ac_code}", "${hname.toUpperCase()}", "${gtype}", "${ac_ad1}", "${ac_ad2}", "${ac_ad3}", "${area_id}", "${ph}", ${ba}, "${ri}", "${rc}", "${ht}", "${mo}", "${gst}", "${ac}", "${cag}")';
    var res = await db.rawInsert(query);
    print(query);
    // print(res);
    return res;
  }

  ////////////////////////////product category insertion//////////////
  Future insertProductCategory(
      ProductsCategoryModel productsCategoryModel) async {
    final db = await database;
    var query =
        'INSERT INTO productsCategory(cat_id, cat_name) VALUES("${productsCategoryModel.cid}", "${productsCategoryModel.canme}")';
    var res = await db.rawInsert(query);
    print(query);
    // print(res);
    return res;
  }

  ///////////////////////maxSeriesTable insertion/////////////////////////////
  Future insertSeriesTable(String tablenm, String prefix, String? val) async {
    print("fields............$tablenm......$prefix....$val.");
    final db = await database;
    var query;
    var res;
    // print("selectReslt---$selectReslt");

    query =
        'INSERT INTO maxSeriesTable(tabname, prefix, value) VALUES("${tablenm}", "${prefix}", "${val}")';
    res = await db.rawInsert(query);

    // var query =
    //     'INSERT INTO maxSeriesTable(tabname, prefix, value) VALUES("${tablenm}", "${prefix}", "${val}")';
    // var serval = "UPDATE maxSeriesTable SET value = REPLACE(prefix,'sval','')";
    // var res = await db.rawInsert(query);
    // print("responce...............$res");
    print(query);
    print(res);
    return res;
  }

////////////////////////////////// product company ///////////////////////
  Future insertProductCompany(ProductCompanymodel productsCompanyModel) async {
    final db = await database;
    var query =
        'INSERT INTO companyTable(comid, comanme) VALUES("${productsCompanyModel.comid}", "${productsCompanyModel.comanme}")';
    var res = await db.rawInsert(query);
    print("responce...............$res");
    print(query);
    // print(res);
    return res;
  }

  /////////////////////////////////////////////////////////////////
  Future insertProductUnit(ProductUnitsModel productUnits) async {
    final db = await database;

    var query =
        'INSERT INTO productUnits(pid, package, unit_name) VALUES("${productUnits.prodid}",${productUnits.boxqty}, "${productUnits.boxnme}")';
    var res = await db.rawInsert(query);
    print("responce...............$res");
    print(query);
    // print(res);
    return res;
  }

/////////////////////////collectionTable/////////////////////////////
  Future insertCollectionTable(
      String rec_date,
      String rec_time,
      String rec_cusid,
      int rec_row_num,
      String ser,
      String mode,
      String amtString,
      String disc,
      String note,
      String sttid,
      int cancel,
      int status) async {
    double amt = 0.0;
    final db = await database;
    print("amt---- $amtString---$disc");
    if (amtString == "") {
      // print("nullll");
      amt = 0.0;
      // double.parse(amtString);
    } else {
      amt = double.parse(amtString);
    }
    var query =
        'INSERT INTO collectionTable(rec_date, rec_time, rec_cusid, rec_row_num, rec_series, rec_mode, rec_amount, rec_disc, rec_note, rec_staffid, rec_cancel, rec_status) VALUES("${rec_date}","${rec_time}","${rec_cusid}", $rec_row_num, "${ser}", "${mode}", $amt, "${disc}", "${note}", "${sttid}", ${cancel}, ${status})';
    var res = await db.rawInsert(query);
    print(query);

    List<Map<String, dynamic>> balance =
        await selectAllcommon('accountHeadsTable', "ac_code='${rec_cusid}'");
    print("jhjkdxj----$balance");
    print('bal---${balance[0]["ba"]}');
    // double bal=double.parse(balance[0]["ba"]);
    if (balance[0]["ba"] != null) {
      double update_bal = balance[0]["ba"] - amt;
      upadteCommonQuery(
          'accountHeadsTable', "ba=${update_bal}", "ac_code='${rec_cusid}'");
    }

    // print(res);
    return res;
  }

////////////////////////insert remark/////////////////////////////////
  Future insertremarkTable(
    String rem_date,
    String rem_time,
    String rem_cusid,
    String ser,
    String text,
    String sttid,
    int row_num,
    int cancel,
    int status,
  ) async {
    final db = await database;
    var query =
        'INSERT INTO remarksTable(rem_date, rem_time, rem_cusid, rem_series, rem_text, rem_staffid, rem_row_num, rem_cancel, rem_status) VALUES("${rem_date}", "${rem_time}","${rem_cusid}", "${ser}", "${text}","${sttid}",${row_num},${cancel},${status})';
    var res = await db.rawInsert(query);
    print(query);
    // print(res);
    return res;
  }

  ////////////////////////////////////////////////////////////////////
  getListOfTables() async {
    Database db = await instance.database;
    var list = await db.query('sqlite_master', columns: ['type', 'name']);
    print(list);
    list.map((e) => print(e["name"])).toList();
    return list;
    // list.forEach((row) {
    //   print(row.values);
    // });
  }

  getTableData(String tablename) async {
    Database db = await instance.database;
    print(tablename);
    var list = await db.rawQuery('SELECT * FROM $tablename');
    print(list);
    return list;
    // list.map((e) => print(e["name"])).toList();
    // return list;
    // list.forEach((row) {
    //   print(row.values);
    // });
  }

  //////////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getArea(String? sid) async {
    List<Map<String, dynamic>> list = [];
    String areaidfromStaff;
    List<Map<String, dynamic>> area = [];
    // String result = "";
    print("getArea sid---${sid}");
    Database db = await instance.database;
    if (sid == " ") {
      list = await db.rawQuery('SELECT * FROM areaDetailsTable');
    } else {
      area = await db
          .rawQuery('SELECT area FROM staffDetailsTable WHERE sid="${sid}"');

      areaidfromStaff = area[0]["area"];
      // String str = areaidfromStaff.substring(0, areaidfromStaff.length - 1);
      String str = areaidfromStaff[areaidfromStaff.length - 1];
      if (str == ",") {
        str = areaidfromStaff.substring(0, areaidfromStaff.length - 1);
      }else{
        str = areaidfromStaff;
      }
      aidsplit = str.split(",");
      print("hudhuh----$areaidfromStaff---$aidsplit");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("areaidfromStaff", areaidfromStaff);
      if (areaidfromStaff == "") {
        list = await db.rawQuery('SELECT aname,aid FROM areaDetailsTable');
      } else {
        list = await db.query(
          'areaDetailsTable',
          where: "aid IN (${aidsplit.join(',')})",
        );
        // list = await db.query(
        //   'areaDetailsTable',
        //   where: "aid IN (${[0,1,2,3,4, ].join(',')})",
        // );
        print("hfzfb-----$list");
      }
    }
    // print("res===${result}");
    print("area===${area}");
    print("area---List ${list}");
    return list;
  }

  //////////////////////////countCustomer////////////////
  countCustomer(String? areaId) async {
    var list;
    // print("aidsplit---${areaidfromStaff}");
    Database db = await instance.database;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? areaidfromStaff = prefs.getString("areaidfromStaff");
    if (areaidfromStaff == null || areaidfromStaff.isEmpty) {
      if (areaId == null) {
        list = await db.rawQuery('SELECT  * FROM accountHeadsTable ');
      } else {
        list = await db.rawQuery(
            'SELECT  * FROM accountHeadsTable where area_id="$areaId"');
      }
    } else if (areaId == null && areaidfromStaff != null) {
      list = await db.query(
        'accountHeadsTable',
        where: "area_id IN (${aidsplit.join(',')})",
      );
    } else {
      list = await db
          .rawQuery('SELECT  * FROM accountHeadsTable where area_id="$areaId"');
    }

    print("customr----${list.length}");
    return list;
  }

  //////////////////////////////////////////////////////
  Future<List<Map<String, dynamic>>> getCustomer(String aid) async {
    print("enteredaid---${aid}");
    Database db = await instance.database;
    var hname;
    // Provider.of<Controller>(context, listen: false).customerList.clear();
    if (aid == ' ' || aid.isEmpty) {
      hname = await db.rawQuery('SELECT  hname,ac_code FROM accountHeadsTable');
    } else {
      hname = await db.rawQuery(
          'SELECT  hname,ac_code FROM accountHeadsTable WHERE area_id="${aid}"');
    }

    print('SELECT  hname,ac_code FROM accountHeadsTable WHERE area_id="${aid}');
    print("getCustomer=======${hname}");
    return hname;
  }
  ///////////////////////////////////////////////////////////////

  // getItems(String product) async {
  //   print("product---${product}");
  //   Database db = await instance.database;
  //   var res = await db.rawQuery(
  //       "SELECT A.item, A.ean, A.rate1,A.code FROM productDetailsTable A WHERE A.code || A.item LIKE '%$product%'");

  //   print("SELECT * FROM productDetailsTable WHERE item LIKE '$product%'");
  //   print("items=================${res}");
  //   return res;
  // }

  //////////////////////////////////////////////////////////////
  getOrderNo() async {
    Database db = await instance.database;
    var res = await db.rawQuery("SELECT os FROM registrationTable");
    print(res);
    print("SELECT os FROM registrationTable");
    return res;
  }

///////////////////////////////////////
  setStaffid(String sname) async {
    print("Sname.......$sname");
    Database db = await instance.database;
    var res = await db
        .rawQuery("SELECT sid FROM staffDetailsTable WHERE sname = '$sname'");
    print("sid result......$res");
    return res;
  }
  /////////////////////////max of from table//////////////////////
  // getMaxOfFieldValue(String os, String customerId) async {
  //   var res;
  //   int max;
  //   print("customerid---$customerId");
  //   Database db = await instance.database;
  //   var result = await db.rawQuery(
  //       "SELECT * FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
  //   print("result---$result");
  //   if (result != null && result.isNotEmpty) {
  //     print("if");
  //     res = await db.rawQuery(
  //         "SELECT MAX(cartrowno) max_val FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
  //     max = res[0]["max_val"] + 1;
  //     print(
  //         "SELECT MAX(cartrowno) max_val FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
  //   } else {
  //     print("else");
  //     max = 1;
  //   }
  //   print(res);
  //   return max;
  //   // Database db = await instance.database;
  //   // var res=db.rawQuery("SELECT (IFNULL(MAX($field),0) +1) FROM $table WHERE os='LF'");
  //   // print(res);
  //   // return res;
  // }

  ////////////////////////////sum of the product /////////////////////////////////
  gettotalSum(String os, String customerId) async {
    // double sum=0.0;
    String sum;
    Database db = await instance.database;
    var result = await db.rawQuery(
        "SELECT * FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");

    if (result != null && result.isNotEmpty) {
      List<Map<String, dynamic>> res = await db.rawQuery(
          "SELECT SUM(totalamount) s FROM orderBagTable WHERE os='$os' AND customerid='$customerId'");
      sum = res[0]["s"].toStringAsFixed(2);
      print("sum from db----$sum");
    } else {
      sum = "0.0";
    }
    return sum;
  }

  getreturntotalSum(String os, String customerId) async {
    // double sum=0.0;
    String sum;
    Database db = await instance.database;
    var result = await db.rawQuery(
        "SELECT * FROM returnBagTable WHERE os='$os' AND customerid='$customerId'");

    if (result != null && result.isNotEmpty) {
      List<Map<String, dynamic>> res = await db.rawQuery(
          "SELECT SUM(totalamount) s FROM returnBagTable WHERE os='$os' AND customerid='$customerId'");
      sum = res[0]["s"].toStringAsFixed(2);
      print("sum from db----$sum");
    } else {
      sum = "0.0";
    }
    return sum;
  }

  /////////////////////sales product sum ////////////////////
  getsaletotalSum(String os, String customerId) async {
    // double sum=0.0;
    String net_amount;
    double tax_tot;
    String gross;
    String count;
    String cesamt;
    String cesper;
    String taxamt;
    String taxper;
    String discount;
    String disper;
    String cgst;
    String sgst;
    String igst;
    double? roundoff;
    double? brate;

    Database db = await instance.database;
    print("calculate sales updated tot in db....$os...$customerId");
    var result = await db.rawQuery(
        "SELECT * FROM salesBagTable WHERE os='$os' AND customerid='$customerId'");

    if (result != null && result.isNotEmpty) {
      List<Map<String, dynamic>> res = await db.rawQuery(
          "SELECT SUM(totalamount) gr, SUM(net_amt) s, COUNT(cartrowno) c, SUM(ces_per) ces, SUM(ces_amt) camt,  SUM(tax_amt) t, SUM(tax_per) tper, SUM(discount_amt) d , SUM(discount_per) dper, SUM(cgst_amt) cgst,SUM(sgst_amt) sgst, SUM(igst_amt) igst, SUM(baserate) brate " +
              "FROM salesBagTable WHERE os='$os' " +
              "AND customerid='$customerId'");
      print("resulted alll sum/////////////////$res");
      net_amount = res[0]["s"].toStringAsFixed(2);
      double totval = 0;

      totval = double.parse(net_amount);
      if ((totval - totval.floor()) <= 0.5) {
        roundoff = ((totval - totval.floor()) * -1);
      } else {
        roundoff = (totval.ceil() - totval);
      }

      print(
          "roundof.....$roundoff.....$totval..${totval.ceil()}...........${totval.floor()}");
      gross = res[0]["gr"].toStringAsFixed(2);
      count = res[0]["c"].toString();
      taxamt = res[0]["t"].toStringAsFixed(2);
      discount = res[0]["d"].toStringAsFixed(2);
      disper = res[0]["dper"].toStringAsFixed(2);
      cesamt = res[0]["camt"].toStringAsFixed(2);
      cesper = res[0]["ces"].toStringAsFixed(2);
      taxper = res[0]["tper"].toStringAsFixed(2);
      cgst = res[0]["cgst"].toStringAsFixed(2);
      sgst = res[0]["sgst"].toStringAsFixed(2);
      igst = res[0]["igst"].toStringAsFixed(2);
      brate = double.parse(res[0]["brate"].toStringAsFixed(2));
      // pkg = double.parse(res[0]["pkg"].toString());
      tax_tot = double.parse(cgst) + double.parse(sgst) + double.parse(igst);

      print("tax_tot...$brate..$cgst---$sgst---$igst");
      print(
          "gross..netamount..taxval..dis..ces ....$brate....$tax_tot...$gross...$net_amount....$taxamt..$discount..$cesamt..$disper...$taxper");
    } else {
      net_amount = "0.00";
      count = "0.00";
      taxamt = "0.00";
      discount = "0.00";
      cesamt = "0.00";
      disper = "0.00";
      gross = "0.0";
      cesper = "0.00";
      taxper = "0.00";
      cgst = "0.00";
      sgst = "0.00";
      igst = "0.00";
      tax_tot = 0.00;
      brate = 0.00;
    }
    return [
      net_amount,
      count,
      taxamt,
      discount,
      cesamt,
      gross,
      disper,
      cesper,
      taxper,
      tax_tot,
      roundoff!,
      brate,
    ];
  }

  saleDetailtotalSum() async {
    Database db = await instance.database;
    var query = "SELECT  SUM(net_amt) s from salesDetailTable";
    // print("calculate sales updated tot in db....$os...$customerId");
    var result = await db.rawQuery(query);
  }

  ////////////// delete//////////////////////////////////////
  deleteFromOrderbagTable(int cartrowno, String customerId) async {
    var res1;
    Database db = await instance.database;
    print("DELETE FROM 'orderBagTable' WHERE cartrowno = $cartrowno");
    var res = await db.rawDelete(
        "DELETE FROM 'orderBagTable' WHERE cartrowno = $cartrowno AND customerid='$customerId'");
    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM orderBagTable WHERE customerid='$customerId'");
      print(res1);
    }
    return res1;
  }

///////////////////////////////////////////////////////////////////////
  ////////////// delete from sales bag table/ /////////////////////////////////////
  deleteFromSalesagTable(String customerId) async {
    var res1;
    Database db = await instance.database;
    // print("DELETE FROM 'salesBagTable' WHERE cartrowno = $cartrowno");
    var res = await db.rawDelete(
        "DELETE FROM 'salesBagTable' WHERE  customerid='$customerId'");
    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM salesBagTable WHERE customerid='$customerId'");
      print(res1);
    }
    return res1;
  }

//////////////////////////////////////////////////////////////
  deleteFromreturnbagTable(int cartrowno, String customerId) async {
    var res1;
    Database db = await instance.database;
    print("DELETE FROM 'returnBagTable' WHERE cartrowno = $cartrowno");
    var res = await db.rawDelete(
        "DELETE FROM 'returnBagTable' WHERE cartrowno = $cartrowno AND customerid='$customerId'");
    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM returnBagTable WHERE customerid='$customerId'");
      print(res1);
    }
    return res1;
  }

  /////////////////////////update qty///////////////////////////////////
  updateQtyOrderBagTable(
      String qty, int cartrowno, String customerId, String rate) async {
    Database db = await instance.database;
    var res1;
    double rate1 = double.parse(rate);
    double updatedQty = double.parse(qty);
    double amount = (rate1 * updatedQty);
    print("amoiunt---$cartrowno-$customerId---$rate--$amount");
    print("updatedqty----$updatedQty");
    // gettotalSum(String os, String customerId);
    var res = await db.rawUpdate(
        'UPDATE orderBagTable SET qty=$updatedQty , totalamount="${amount}" , rate="${rate}" WHERE cartrowno=$cartrowno AND customerid="$customerId"');
    print("response-------$res");

    if (res > 0) {
      res1 = await db.rawQuery(
          "SELECT * FROM orderBagTable WHERE customerid='$customerId'");
      print(res1);
    }
    print("res1------$res1");
    return res1;
  }

////////////////////////////////////////////////////
  updateQtyreturnBagTable(
      String qty, int cartrowno, String customerId, String rate) async {
    Database db = await instance.database;
    var res1;
    double rate1 = double.parse(rate);
    int updatedQty = int.parse(qty);
    double amount = (rate1 * updatedQty);
    print("amoiunt---$cartrowno-$customerId---$rate--$amount");
    print("updatedqty----$updatedQty");
    // gettotalSum(String os, String customerId);
    var res = await db.rawUpdate(
        'UPDATE returnBagTable SET qty=$updatedQty , totalamount="${amount}" , rate="${rate}" WHERE cartrowno=$cartrowno AND customerid="$customerId"');
    print("response-------$res");

    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM returnBagTable WHERE customerid='$customerId'");
      print(res1);
    }
    print("res1------$res1");
    return res1;
  }

  ////////////////////////////////////////////////
  /////////////////////////update qty///////////////////////////////////
  updateQtySalesBagTable(
      String qty, int cartrowno, String customerId, String rate) async {
    Database db = await instance.database;
    var res1;
    double rate1 = double.parse(rate);
    double updatedQty = double.parse(qty);
    double amount = (rate1 * updatedQty);
    print("amoiunt---$cartrowno-$customerId---$rate--$amount");
    print("updatedqty----$updatedQty");
    // gettotalSum(String os, String customerId);
    var res = await db.rawUpdate(
        'UPDATE salesBagTable SET qty=$updatedQty , totalamount="${amount}" , rate="${rate}" WHERE cartrowno=$cartrowno AND customerid="$customerId"');
    print("response-------$res");

    if (res == 1) {
      res1 = await db.rawQuery(
          "SELECT * FROM salesBagTable WHERE customerid='$customerId'");
      print(res1);
    }

    return res1;
  }

  ///////////////////////////////////////////////////////////////////
  // updateRemarks(String custmerId, String remark) async {
  //   Database db = await instance.database;
  //   print("remark.....${custmerId}${remark}");

  //   var res1;
  //   var res;
  //   if (res !=null) {
  //     res = await db.rawUpdate(
  //         'UPDATE remarksTable SET rem_text="$remark" WHERE  rem_cusid="$custmerId"');

  //     print("response-------$res");

  //     res1 = await db
  //         .rawQuery("SELECT * FROM remarksTable WHERE customerid='$custmerId'");
  //     print(res1);
  //   }
  //   return res1;
  // }

  /////////////////////////////////////////////////////////////////////
  deleteFromTableCommonQuery(String table, String? condition) async {
    print("table--condition -$table---$condition");
    Database db = await instance.database;
    if (condition == null || condition.isEmpty || condition == "") {
      print("no condition");
      await db.delete('$table');
    } else {
      print("condition");

      await db.rawDelete('DELETE FROM "$table" WHERE $condition');
    }
  }

  //////////////////////////////selectCommonQuery///////////////////
  // selectCommonquery(String table, String? condition) async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;
  //   print("----condition---table -------${condition}----${table}");
  //   if (condition == null || condition.isEmpty) {
  //     result = await db.rawQuery("SELECT * FROM '$table'");
  //   } else {
  //     result = await db.rawQuery("SELECT * FROM '$table' WHERE $condition");
  //   }
  //   print("result----$result");
  //   return result;
  // }
//////////////////////////////select left join/////////////////////
  selectfromOrderbagTable(String customerId) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    var unitquery = "";

    unitquery = "SELECT p.pid prid,p.code prcode,p.item pritem, p.unit prunit, 1 pkg ,p.companyId prcid,p.hsn prhsn, " +
        "p.tax prtax,p.prate prrate,p.mrp prmrp,p.cost prcost,p.rate1 prbaserate, p.categoryId  prcategoryId from 'productDetailsTable' p union all " +
        "SELECT pd.pid,pd.code,pd.item,u.unit_name unit,u.package pkg,pd.companyId,pd.hsn, " +
        "pd.tax,pd.prate,pd.mrp,pd.cost,pd.rate1 , pd.categoryId  from 'productDetailsTable' pd " +
        "inner join 'productUnits' u  ON u.pid = pd.pid ";

    unitquery = "select k.*,b.*, (k.prbaserate * k.pkg ) prrate1 from (" +
        unitquery +
        " ) k " +
        "left join 'orderBagTable' b on k.prcode = b.code " +
        "AND b.customerid='$customerId' and " +
        "b.unit_name = k.prunit " +
        "order by b.cartrowno  DESC,k.pritem,k.prcode ;";

    result = await db.rawQuery(unitquery);
    ////////////////////////////////////////////////////////
    // result = await db.rawQuery(
    //     // "SELECT productDetailsTable.* , orderBagTable.cartrowno FROM 'productDetailsTable' LEFT JOIN 'orderBagTable' ON productDetailsTable.code = orderBagTable.code AND orderBagTable.customerid='$customerId' ORDER BY cartrowno DESC");
    //     "SELECT productDetailsTable.* , orderBagTable.cartrowno " +
    //         "FROM 'productDetailsTable' " +
    //         "LEFT JOIN 'orderBagTable' ON productDetailsTable.code = orderBagTable.code " +
    //         "AND orderBagTable.customerid='$customerId' " +
    //         "ORDER BY cartrowno DESC");

    // print("selectfromorderbagTable result----$result");
    // print("length sales unitsss---${result.length}");
    return result;
  }

///////////////////////////////////////////////////////////////////
  selectfromreturnbagTable(String customerId) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    // result = await db.rawQuery(
    //     "SELECT productDetailsTable.* , returnBagTable.cartrowno " +
    //         "FROM 'productDetailsTable' " +
    //         "LEFT JOIN 'returnBagTable' ON productDetailsTable.code = returnBagTable.code " +
    //         "AND returnBagTable.customerid='$customerId' " +
    //         "ORDER BY cartrowno DESC");
    // print("leftjoin result----$result");
    // print("length---${result.length}");
    var unitquery1 = "";
    unitquery1 = "SELECT p.pid prid,p.code prcode,p.item pritem, p.unit prunit, 1 pkg ,p.companyId prcid,p.hsn prhsn, " +
        "p.tax prtax,p.prate prrate,p.mrp prmrp,p.cost prcost,p.rate1 prbaserate, p.categoryId  prcategoryId from 'productDetailsTable' p union all " +
        "SELECT pd.pid,pd.code,pd.item,u.unit_name unit,u.package pkg,pd.companyId,pd.hsn, " +
        "pd.tax,pd.prate,pd.mrp,pd.cost,pd.rate1 , pd.categoryId  from 'productDetailsTable' pd " +
        "inner join 'productUnits' u  ON u.pid = pd.pid ";

    unitquery1 = "select k.*,b.*, (k.prbaserate * k.pkg ) prrate1 from (" +
        unitquery1 +
        " ) k " +
        "left join 'returnBagTable' b on k.prcode = b.code " +
        "AND b.customerid='$customerId' and " +
        "b.unit_name = k.prunit " +
        "order by b.cartrowno  DESC,k.pritem,k.prcode ;";
    result = await db.rawQuery(unitquery1);
    print("db query.........$result");
    return result;
  }

/////////////////////////////////////////////////////////////////////
  fromsalebagTable_X001(String customerId, String prod_code) async {
    // print("product code..$proc_code");
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    var unitquery = "";
    unitquery = "SELECT p.pid as pid,p.code code,p.item item, p.unit unit, 1 pkg ,p.companyId companyId,p.hsn hsn, " +
        "p.tax tax,p.prate prate,p.mrp mrp,p.cost cost,p.rate1 rate1, " +
        "p.categoryId  categoryId from 'productDetailsTable' p where p.code= '$prod_code' union all " +
        "SELECT pd.pid,pd.code,pd.item,u.unit_name unit,u.package pkg,pd.companyId,pd.hsn, " +
        "pd.tax,pd.prate,pd.mrp,pd.cost,pd.rate1 , pd.categoryId  from 'productDetailsTable' pd " +
        "inner  join 'productUnits' u  ON u.pid = pd.pid where pd.code= '$prod_code' order by pkg";

    // unitquery = "SELECT p.pid prid,p.code prcode,p.item pritem, p.unit prunit, 1 pkg ,p.companyId prcid,p.hsn prhsn, " +
    //     "p.tax prtax,p.prate prrate,p.mrp prmrp,p.cost prcost,p.rate1 prbaserate, "+
    //     " p.categoryId  prcategoryId,u.unit_name pr_unitName from 'productDetailsTable' p " +
    //     "left join 'productUnits' u on u.pid = p.pid where p.code= '$prod_code'";

    // "SELECT pd.pid,pd.code,pd.item,u.unit_name unit,u.package pkg,pd.companyId,pd.hsn, " +
    // "pd.tax,pd.prate,pd.mrp,pd.cost,pd.rate1 , pd.categoryId  from 'productDetailsTable' pd " +
    // "inner join 'productUnits' u  ON u.pid = p.pid ";
    // and pd.code = ${prod_code}

    // var itemselectionquery = "SELECT pid,prcode,pritem FROM ( " +
    //     unitquery +
    //     " ) where pd.prcode = ${prod_code} k group by pid,prcode,pritem order by pritem";
    // unitquery = "select k.*,b.*, (k.prbaserate * k.pkg ) prrate1 from (" +
    //     unitquery +
    //     " ) k " +
    //     "left join 'salesBagTable' b on k.prcode = b.code " +
    //     "AND b.customerid='$customerId' and " +
    //     "b.unit_name = k.prunit " +
    //     " order by b.cartrowno  DESC,k.pritem,k.prcode;";
//  b.cartrowno DESC
    print("unit queryyyy..$unitquery");
    result = await db.rawQuery(unitquery);

    print("selectfromsalebagTable result----$result");
    print("length sales unitsss---${result}");
    return result;
  }

//////////////////////////////////////////////////
  selectfromsalebagTable_X001(String customerId, String type) async {
    List<Map<String, dynamic>> result;
    List<Map<String, dynamic>> result1;
    Database db = await instance.database;
    var unitquery = "";
    var itemselectionquery;

    // unitquery = "SELECT p.pid prid,p.code prcode,p.item pritem, p.unit prunit, 1 pkg ,p.companyId prcid,p.hsn prhsn, " +
    //     "p.tax prtax,p.prate prrate,p.mrp prmrp,p.cost prcost,p.rate1 prbaserate, p.categoryId  prcategoryId from 'productDetailsTable' p union all " +
    //     "SELECT pd.pid,pd.code,pd.item,u.unit_name unit,u.package pkg,pd.companyId,pd.hsn, " +
    //     "pd.tax,pd.prate,pd.mrp,pd.cost,pd.rate1 , pd.categoryId  from 'productDetailsTable' pd " +
    //     "inner join 'productUnits' u  ON u.pid = pd.pid ";
    if (type == "sale order") {
      itemselectionquery =
          "SELECT p.pid prid,p.code prcode,p.item pritem ,p.hsn hsn ,p.rate1 prrate1,sum(o.qty) qty" +
              " from 'productDetailsTable' p left join 'orderBagTable' o on p.code =o.code and o.customerid='$customerId' group by p.pid,p.code,p.item order by p.item";
    } else if (type == "sales") {
      itemselectionquery =
          "SELECT p.pid prid,p.code prcode,p.item pritem ,p.hsn hsn ,p.rate1 prrate1,sum(s.qty) qty" +
              " from 'productDetailsTable' p left join 'salesBagTable' s on p.code  = s.code and s.customerid='$customerId' group by p.pid,p.code,p.item order by p.item";
    }

    // unitquery = "select k.*,b.*, (k.prbaserate * k.pkg ) prrate1 from (" +
    //     unitquery +
    //     " ) k " +
    //     "left join 'salesBagTable' b on k.prcode = b.code " +
    //     "AND b.customerid='$customerId' and " +
    //     "b.unit_name = k.prunit " +
    //     " order by b.cartrowno  DESC,k.pritem,k.prcode;";
//  b.cartrowno DESC

    print("unit queryyyy..$itemselectionquery");
    result = await db.rawQuery(itemselectionquery);

    print("itemselection daat--${result}");
    return result;
  }

///////////////////////////////////////////////////////////////////////////////
  selectfromsalebagTable(String customerId) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    var unitquery = "";
    // result = await db.rawQuery(
    // "SELECT productDetailsTable.* , salesBagTable.cartrowno ,salesBagTable.qty " +
    //     "FROM 'productDetailsTable' " +
    //     "LEFT JOIN 'salesBagTable' " +
    //     "ON productDetailsTable.code = salesBagTable.code " +
    //     "AND salesBagTable.customerid='$customerId' " +
    //     "ORDER BY cartrowno DESC");
    unitquery = "SELECT p.pid prid,p.code prcode,p.item pritem, p.unit prunit, 1 pkg ,p.companyId prcid,p.hsn prhsn, " +
        "p.tax prtax,p.prate prrate,p.mrp prmrp,p.cost prcost,p.rate1 prbaserate, p.categoryId  prcategoryId from 'productDetailsTable' p union all " +
        "SELECT pd.pid,pd.code,pd.item,u.unit_name unit,u.package pkg,pd.companyId,pd.hsn, " +
        "pd.tax,pd.prate,pd.mrp,pd.cost,pd.rate1 , pd.categoryId  from 'productDetailsTable' pd " +
        "inner join 'productUnits' u  ON u.pid = pd.pid ";

    unitquery = "select k.*,b.*, (k.prbaserate * k.pkg ) prrate1 from (" +
        unitquery +
        " ) k " +
        "left join 'salesBagTable' b on k.prcode = b.code " +
        "AND " +
        "b.unit_name = k.prunit " +
        " order by b.cartrowno  DESC,k.pritem,k.prcode;";
//  b.cartrowno DESC
    result = await db.rawQuery(unitquery);

    // result = await db.rawQuery("SELECT pd.pid,pd.code,pd.item,pd.unit,pd.companyId,pd.hsn, " +
    //     "pd.tax,pd.prate,pd.mrp,pd.cost,pd.rate1, " +
    //     "b.itemName,b.cartdate,b.carttime,b.os,b.customerid,b.cartrowno,b.code bagCode, " +
    //     "b.qty bagQty,b.rate bagRate,b.unit_rate bagUnitRate,b.totalamount bagTotal," +
    //     "b.method,b.tax_per,b.tax_amt,b.cgst_per,b.cgst_amt,b.sgst_per,b.sgst_amt," +
    //     "b.igst_per,b.igst_amt,b.discount_per,b.discount_amt,b.ces_per,b.ces_amt,b.cstatus," +
    //     "b.net_amt,b.pid bagPid,b.unit_name bagUnitName,b.package bagPackage,b.baserate," +
    //     "u.pid unitPid,u.package unitPackage,u.unit_name unitUnit_name  " +
    //     "FROM 'productDetailsTable' pd " +
    //     "LEFT JOIN 'salesBagTable' b " +
    //     "ON pd.code = b.code " +
    //     "AND b.customerid='$customerId' " +
    //     "LEFT JOIN 'productUnits' u ON u.pid = pd.pid " +
    //     "where pd.pid <7 " +
    //     "ORDER BY pd.item,pd.code");
    // result = await db.rawQuery("SELECT pd.pid,pd.code,pd.item,pd.unit,pd.companyId,pd.hsn, " +
    //     "pd.tax,pd.prate,pd.mrp,pd.cost,pd.rate1, " +
    //     "b.itemName,b.cartdate,b.carttime,b.os,b.customerid,b.cartrowno,b.code bagCode, " +
    //     "b.qty bagQty,b.rate bagRate,b.unit_rate bagUnitRate,b.totalamount bagTotal," +
    //     "b.method,b.tax_per,b.tax_amt,b.cgst_per,b.cgst_amt,b.sgst_per,b.sgst_amt," +
    //     "b.igst_per,b.igst_amt,b.discount_per,b.discount_amt,b.ces_per,b.ces_amt,b.cstatus," +
    //     "b.net_amt,b.pid bagPid,b.unit_name bagUnitName,b.package bagPackage,b.baserate," +
    //     "u.pid unitPid,u.package unitPackage,GROUP_CONCAT(u.unit_name,'//') unitUnit_name  " +
    //     "FROM 'productDetailsTable' pd " +
    //     "LEFT JOIN 'salesBagTable' b " +
    //     "ON pd.code = b.code " +
    //     "AND b.customerid='$customerId' " +
    //     "LEFT JOIN 'productUnits' u ON u.pid = pd.pid " +
    //     "where pd.pid >0 " +
    //     "GROUP BY pd.code "+
    //     "ORDER BY pd.pid ASC");
    /////////////////////////////////////////////////
    print("selectfromsalebagTable result----$result");
    print("length sales unitsss---${result.length}");
    return result;
  }

/////////////////////////////////////////////////////////////////////////////////
  selectfrombagandfilterList(String customerId, String comId) async {
    print("comid---$comId");
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    result = await db.rawQuery(
        "SELECT productDetailsTable.* , orderBagTable.cartrowno " +
            "FROM 'productDetailsTable' " +
            "LEFT JOIN 'orderBagTable' ON productDetailsTable.code = orderBagTable.code " +
            "AND orderBagTable.customerid='$customerId' " +
            "where  productDetailsTable.companyId='${comId}' " +
            "ORDER BY cartrowno DESC");
    print("leftjoin result- company---$result");
    print("length---${result.length}");
    return result;
  }

////////////////////////////////////////////////////////////////////////////////
  selectfromsalesbagandfilterList(String customerId, String comId) async {
    print("comid---$comId");
    List<Map<String, dynamic>> result;
    var query = "";
    query = query +
        "SELECT productDetailsTable.* , salesBagTable.cartrowno " +
        " FROM 'productDetailsTable' LEFT JOIN 'salesBagTable' " +
        " ON productDetailsTable.code = salesBagTable.code AND " +
        " salesBagTable.customerid='$customerId'" +
        " where  productDetailsTable.companyId='${comId}' " +
        " ORDER BY cartrowno DESC;";
    Database db = await instance.database;
    result = await db.rawQuery(query);
    print("leftjoin result- company---$result");
    print("length---${result.length}");
    return result;
  }

//////////////////////////////////////////////////////////////////////
  selectfromreturnbagandfilterList(String customerId, String comId) async {
    print("comid---$comId");
    List<Map<String, dynamic>> result;
    var query = "";
    query = query +
        "SELECT productDetailsTable.* , returnBagTable.cartrowno " +
        " FROM 'productDetailsTable' LEFT JOIN 'returnBagTable' " +
        " ON productDetailsTable.code = returnBagTable.code AND " +
        " returnBagTable.customerid='$customerId'" +
        " where  productDetailsTable.companyId='${comId}' " +
        " ORDER BY cartrowno DESC;";
    Database db = await instance.database;
    result = await db.rawQuery(query);
    print("leftjoin result- company---$result");
    print("length---${result.length}");
    return result;
  }

//////////////count from table/////////////////////////////////////////
  countCommonQuery(String table, String? condition) async {
    String count = "0";
    Database db = await instance.database;
    final result =
        await db.rawQuery("SELECT COUNT(*) c FROM '$table' WHERE $condition");
    count = result[0]["c"].toString();
    print("result---count---$result");
    return count;
  }

  //////////////////////////////////////////
  countqty(String table, String? condition) async {
    String count = "0";
    String qty;
    Database db = await instance.database;
    final result =
        await db.rawQuery("SELECT qty FROM '$table' WHERE $condition");
    print("quantity update indbhelp.............$result");
    if (result != null && result.isNotEmpty) {
      qty = result[0]["qty"].toString();
    } else {
      qty = "1";
    }
    print("result qty.........$qty");
    // count = result[0]["c"].toString();
    // print("result---count---$result");
    return qty;
  }

//////////////////////////////////////////////////////////////////
  getMaxCommonQuery(String table, String field, String? condition) async {
    var res;
    int max;
    var result;
    Database db = await instance.database;
    print("condition---${condition}");
    if (condition == " ") {
      result = await db.rawQuery("SELECT * FROM '$table'");
    } else {
      result = await db.rawQuery("SELECT * FROM '$table' WHERE $condition");
    }
    // print("result max---$result");
    if (result != null && result.isNotEmpty) {
      print("if");

      if (condition == " ") {
        res = await db.rawQuery("SELECT MAX($field) max_val FROM '$table'");
      } else {
        res = await db.rawQuery(
            "SELECT MAX($field) max_val FROM '$table' WHERE $condition");
      }

      print('res[0]["max_val"] ----${res[0]["max_val"]}');
      // int convertedMax = int.parse(res[0]["max_val"]);
      max = res[0]["max_val"] + 1;
      print("max value.........$max");
      print("SELECT MAX($field) max_val FROM '$table' WHERE $condition");
    } else {
      print("else");
      max = 1;
    }
    print("max common-----$res");

    print(res);
    return max;
  }

  /////////////////////search////////////////////////////////
  searchItem(String table, String key, String field1, String? field2,
      String? field3, String condition) async {
    Database db = await instance.database;
    print("table key field---${table},${key},${field1}---$condition");

    var query =
        "SELECT * FROM '$table'  where ($field1  || $field2 || $field3  LIKE  '%$key%') $condition";
    var result = await db.rawQuery(query);

    print("querty0---$query");
    // List<Map<String, dynamic>> result = await db.query(
    //   '$table',
    //   where: '$field1 LIKE ? OR $field2 LIKE ? OR $field3 LIKE ? ',
    //   whereArgs: [
    //     '$key%',
    //     '$key%',
    //     '$key%',
    //   ],
    // );

    print("search result----$result");
    return result;
  }

///////////////////search account heads/////////////////////
  accountHeadsSearch(String key) async {
    print("key--hai---$key");
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'accountHeadsTable',
      where: 'hname LIKE ?',
      whereArgs: [
        '$key%',
      ],
    );
    print("search result-----$result");
    return result;
  }
////////////////////////left join///////////////////////////

  Future<dynamic> todayOrder(String date, String condition) async {
    List<Map<String, dynamic>> result;
    print("conditon----$condition");
    Database db = await instance.database;
    // var query = 'select accountHeadsTable.hname as cus_name,' +
    //     ' orderMasterTable.order_id, orderMasterTable.os ' +
    //     ' || orderMasterTable.order_id as Order_Num,orderMasterTable.customerid ' +
    //     ' Cus_id,orderMasterTable.orderdate Date, count(orderDetailTable.row_num) count, ' +
    //     ' orderMasterTable.total_price ,orderDetailTable.item, orderDetailTable.qty, orderDetailTable.rate ' +
    //     ' from orderMasterTable inner join orderDetailTable ' +
    //     ' on orderMasterTable.order_id=orderDetailTable.order_id left join accountHeadsTable ' +
    //     ' on accountHeadsTable.ac_code= orderMasterTable.customerid ' +
    //     ' where orderMasterTable.orderdate="${date}"  $condition ' +
    //     ' group by orderMasterTable.order_id';

    var query = 'select accountHeadsTable.hname as cus_name,' +
        ' orderMasterTable.order_id, orderMasterTable.os ' +
        ' || orderMasterTable.order_id as Order_Num,orderMasterTable.customerid ' +
        ' Cus_id,orderMasterTable.orderdate Date, count(orderDetailTable.row_num) count, ' +
        ' orderMasterTable.total_price ,orderDetailTable.item, orderDetailTable.qty, orderDetailTable.rate ' +
        ' from orderMasterTable inner join orderDetailTable ' +
        ' on orderMasterTable.order_id=orderDetailTable.order_id INNER join accountHeadsTable ' +
        ' on accountHeadsTable.ac_code= orderMasterTable.customerid ' +
        ' where orderMasterTable.orderdate="${date}"  $condition ' +
        ' group by orderMasterTable.order_id';

    print("query---$query");
    result = await db.rawQuery(query);
    print("inner result------$result");

    if (result.length > 0) {
      return result;
    } else {
      return null;
    }
  }

  ////////////////////////////////////////////////////////////////
  Future<dynamic> todayCollection(String date, String condition) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    print("jhsjh----$condition");
    result = await db.rawQuery(
        'select accountHeadsTable.hname as cus_name,collectionTable.rec_cusid,collectionTable.rec_cusid,collectionTable.rec_date,collectionTable.rec_amount,collectionTable.rec_note from collectionTable inner join accountHeadsTable on accountHeadsTable.ac_code = collectionTable.rec_cusid where collectionTable.rec_date="${date}" $condition and collectionTable.rec_cancel=0  order by collectionTable.id DESC');
    // if (result.length > 0) {
    print("inner collc result------$result");
    return result;
    // } else {
    //   return null;
    // }
  }

  //////////////////////////////////////////////////////////////////
  Future<dynamic> todaySales(String date, String condition, String type) async {
    List<Map<String, dynamic>> result;

    print("comndjsjhfsdh----$condition");
    Database db = await instance.database;
    var query;
    if (type == "upload history") {
      query =
          'select accountHeadsTable.hname as cus_name,accountHeadsTable.ba as ba, accountHeadsTable.ac_ad1 as address, accountHeadsTable.ac_gst as gstin, salesMasterTable.sales_id sales_id,salesMasterTable.rounding roundoff, salesMasterTable.os  || salesMasterTable.sales_id as sale_Num,salesMasterTable.customer_id Cus_id,salesMasterTable.salesdate   Date, count(salesDetailTable.row_num) count,salesMasterTable.gross_tot grossTot,salesMasterTable.payment_mode payment_mode,salesMasterTable.credit_option creditoption, salesMasterTable.net_amt, salesMasterTable.tax_tot as taxtot, salesMasterTable.dis_tot as distot ,salesMasterTable.cancel as cancel  from salesMasterTable inner join salesDetailTable on salesMasterTable.sales_id=salesDetailTable.sales_id inner join accountHeadsTable on accountHeadsTable.ac_code= salesMasterTable.customer_id where salesMasterTable.salesdate="${date}" and salesMasterTable.status != 0  $condition group by salesMasterTable.sales_id';
    } else if (type == "history pending") {
      query =
          'select accountHeadsTable.hname as cus_name,accountHeadsTable.ba as ba, accountHeadsTable.ac_ad1 as address, accountHeadsTable.ac_gst as gstin, salesMasterTable.sales_id sales_id,salesMasterTable.rounding roundoff, salesMasterTable.os  || salesMasterTable.sales_id as sale_Num,salesMasterTable.customer_id Cus_id,salesMasterTable.salesdate   Date, count(salesDetailTable.row_num) count,salesMasterTable.gross_tot grossTot,salesMasterTable.payment_mode payment_mode,salesMasterTable.credit_option creditoption, salesMasterTable.net_amt, salesMasterTable.tax_tot as taxtot, salesMasterTable.dis_tot as distot ,salesMasterTable.cancel as cancel  from salesMasterTable inner join salesDetailTable on salesMasterTable.sales_id=salesDetailTable.sales_id inner join accountHeadsTable on accountHeadsTable.ac_code= salesMasterTable.customer_id where salesMasterTable.salesdate="${date}" and salesMasterTable.status == 0  $condition group by salesMasterTable.sales_id';
    } else if (type == "sale report") {
      query =
          'select accountHeadsTable.hname as cus_name,accountHeadsTable.ba as ba, accountHeadsTable.ac_ad1 as address, accountHeadsTable.ac_gst as gstin, salesMasterTable.sales_id sales_id,salesMasterTable.rounding roundoff, salesMasterTable.os  || salesMasterTable.sales_id as sale_Num,salesMasterTable.customer_id Cus_id,salesMasterTable.salesdate   Date, count(salesDetailTable.row_num) count,salesMasterTable.gross_tot grossTot,salesMasterTable.payment_mode payment_mode,salesMasterTable.credit_option creditoption, salesMasterTable.net_amt, salesMasterTable.tax_tot as taxtot, salesMasterTable.dis_tot as distot,salesMasterTable.cancel as cancel  from salesMasterTable inner join salesDetailTable on salesMasterTable.sales_id=salesDetailTable.sales_id inner join accountHeadsTable on accountHeadsTable.ac_code= salesMasterTable.customer_id where salesMasterTable.salesdate="${date}"  and salesMasterTable.cancel == 0 $condition group by salesMasterTable.sales_id';
    } else {
      query =
          'select accountHeadsTable.hname as cus_name,accountHeadsTable.ba as ba, accountHeadsTable.ac_ad1 as address, accountHeadsTable.ac_gst as gstin, salesMasterTable.sales_id sales_id,salesMasterTable.rounding roundoff, salesMasterTable.os  || salesMasterTable.sales_id as sale_Num,salesMasterTable.customer_id Cus_id,salesMasterTable.salesdate   Date, count(salesDetailTable.row_num) count,salesMasterTable.gross_tot grossTot,salesMasterTable.payment_mode payment_mode,salesMasterTable.credit_option creditoption, salesMasterTable.net_amt, salesMasterTable.tax_tot as taxtot, salesMasterTable.dis_tot as distot,salesMasterTable.cancel as cancel  from salesMasterTable inner join salesDetailTable on salesMasterTable.sales_id=salesDetailTable.sales_id inner join accountHeadsTable on accountHeadsTable.ac_code= salesMasterTable.customer_id where salesMasterTable.salesdate="${date}"  $condition group by salesMasterTable.sales_id';
    }

    print("query---$query");

    result = await db.rawQuery(query);
    if (result.length > 0) {
      print("todddddddddddddddd----$result");
      return result;
    } else {
      return null;
    }
  }

  ////////////////////////////////////////////////////////////////
  Future<dynamic> printcurrentData(int saleid) async {
    List<Map<String, dynamic>> result;

    print("comndjsjhfsdh----$saleid");
    String query2 = "";
    // String query1 = "";

    Database db = await instance.database;
    query2 = query2 +
        " select accountHeadsTable.hname as cus_name,accountHeadsTable.ba as ba, " +
        " accountHeadsTable.ac_ad1 as address, accountHeadsTable.ac_gst as gstin, " +
        " salesMasterTable.sales_id sales_id,salesMasterTable.rounding roundoff, " +
        " salesMasterTable.os  || salesMasterTable.sales_id as sale_Num, " +
        " salesMasterTable.customer_id Cus_id,salesMasterTable.salesdate Date, "
            " count(salesDetailTable.row_num) count,salesMasterTable.gross_tot grossTot, " +
        " salesMasterTable.payment_mode payment_mode,salesMasterTable.credit_option creditoption, " +
        " salesMasterTable.net_amt, salesMasterTable.tax_tot as taxtot, salesMasterTable.dis_tot as distot " +
        " from salesMasterTable inner join salesDetailTable on  " +
        " salesMasterTable.sales_id=salesDetailTable.sales_id " +
        " inner join " +
        " accountHeadsTable on accountHeadsTable.ac_code= salesMasterTable.customer_id " +
        " where salesMasterTable.sales_id=$saleid ; ";
    print("query---$query2");

    result = await db.rawQuery(query2);
    if (result.length > 0) {
      print("printcurrentdata ------$result");
      return result;
    } else {
      return null;
    }
  }

  //////////////select total amount form ordermasterTable ////////////
  // print
  printTaxableDetails(int salesId) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    var query =
        " select tax_per as tper , sum(gross_amount - dis_amt) as taxable,sum(cgst_amt) as cgst, sum(sgst_amt) as sgst, sum(tax_amt) as tax from salesDetailTable where sales_id=$salesId group by tax_per order by tax_per ";
    result = await db.rawQuery(query);
    print("taxable details------$result");
    if (result.length > 0) {
      return result;
    } else {
      return null;
    }
  }

  selectCommonQuery(String table, String? condition) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    if (condition == null) {
      result = await db.rawQuery("SELECT * FROM '$table'");
    } else {
      result = await db
          .rawQuery("SELECT code,item,qty,rate FROM '$table' WHERE $condition");
    }

    print("naaknsdJK-----$result");
    return result;
  }

  ///////////////////select maste today sale history///////////////////////
  todaySaleHistory(String table, String? condition) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    if (condition == null) {
      result = await db.rawQuery("SELECT * FROM '$table'");
    } else {
      result = await db.rawQuery(
          "SELECT code ,item_name as item,qty,rate,dis_amt,tax_amt,net_amt FROM '$table' WHERE $condition"
          // "SELECT code,item_name,qty,rate FROM '$table' WHERE $condition"

          );
    }

    print("naaknsdJK-----$result");
    return result;
  }

///////////////////////////////////////////////////////////
  selectAllcommon(String table, String? condition) async {
    print("haiiiii");
    List<Map<String, dynamic>> result = [];
    Database db = await instance.database;
    var query = "SELECT * FROM '$table' WHERE $condition";
    print("company query----$query");
    if (condition == null || condition.isEmpty) {
      result = await db.rawQuery("SELECT * FROM '$table'");
    } else {
      result = await db.rawQuery(query);
    }
    print("result menu common----$result");
    return result;
  }

  //////////////////////////////////////////////////////////
  executeGeneralQuery(String query) async {
    print("haiiiii");
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    print("general query---$query");
    result = await db.rawQuery(query);

    print("result general----$result");
    return result;
  }

//////////////////////////inner join///////////////////////
  getDataFromMasterAndDetail(int order_id) async {
    List<Map<String, dynamic>> result;
    List<Map<String, dynamic>> result2;
    Database db = await instance.database;
    result = await db.rawQuery(
        'select id,order_id,orderdate,customerid,userid,areaid from orderMasterTable');
    result2 = await db.rawQuery('select * from orderDetailTable');

    // result = await db.rawQuery(
    //     'select orderMasterTable.id as id, orderMasterTable.os  || orderMasterTable.order_id as ser,orderMasterTable.order_id ,orderMasterTable.customerid Cus_id, orderMasterTable.orderdatetime Date, orderMasterTable.userid as staff_id,orderMasterTable.areaid as area_id, orderDetailTable.code, orderDetailTable.qty, orderDetailTable.rate from orderMasterTable inner join  orderDetailTable on orderMasterTable.order_id = orderDetailTable.order_id  where  orderMasterTable.order_id =${order_id} order by  orderMasterTable.order_id,orderDetailTable.row_num ');
    if (result.length > 0) {
      print("inner join result------$result");
      return {result, result2};
    } else {
      return null;
    }
  }

  /////////////////////////////////////////////
  getDataFromMasterAndDetails(int order_id) async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;

    result = await db.rawQuery('select * from orderMasterTable');
    if (result.length > 0) {
      // print("inner join result------$result");
      return result;
    } else {
      return null;
    }
  }

///////////////////////////////////////////////////////////
  selectMasterTable() async {
    Database db = await instance.database;
    var result;
    var res = await db.rawQuery("SELECT  * FROM  orderMasterTable");
    print("hhs----$res");
    if (res.length > 0) {
      result = await db.rawQuery(
          "SELECT orderMasterTable.id as id, orderMasterTable.os  || orderMasterTable.order_id as ser,orderMasterTable.order_id as oid,orderMasterTable.customerid cuid, orderMasterTable.orderdate  || ' '  ||orderMasterTable.ordertime odate, orderMasterTable.userid as sid,orderMasterTable.areaid as aid  FROM orderMasterTable where orderMasterTable.status=0");
    }
    print("result upload----$result");
    return result;
  }

  ///////////////////////////////////////////////////////
  selectSalesMasterTable() async {
    Database db = await instance.database;
    var result;

    String query2 = "";
    // String query1 = "";
    query2 = query2 +
        " SELECT " +
        " salesMasterTable.sales_id as s_id," +
        " salesMasterTable.bill_no as billno," +
        " salesMasterTable.customer_id cuid," +
        " salesMasterTable.salesdate  || ' '  ||salesMasterTable.salestime sdate, " +
        " salesMasterTable.staff_id as staff_id," +
        " salesMasterTable.areaid as aid ," +
        " salesMasterTable.cus_type as cus_type," +
        " salesMasterTable.gross_tot as gross_tot," +
        " salesMasterTable.dis_tot as dis_tot," +
        " salesMasterTable.ces_tot as ces_tot," +
        " salesMasterTable.tax_tot as tax_tot," +
        " salesMasterTable.payment_mode as p_mode," +
        " salesMasterTable.credit_option as c_option," +
        " salesMasterTable.rounding as rounding," +
        " salesMasterTable.net_amt as net_amt," +
        " salesMasterTable.cancel as cancel_flag, " +
        " salesMasterTable.cancel_staff as cancel_staff, " +
        " salesMasterTable.cancel_dateTime as cancel_time" +
        " FROM salesMasterTable where salesMasterTable.status=0 ;";
    var res = await db.rawQuery("SELECT  * FROM  salesMasterTable");
    print("query2----$query2");
    if (res.length > 0) {
      result = await db.rawQuery(query2);
    }
    print("result sales upload----$result");
    return result;
  }

  ////////////////////////////////////////////////////////
  selectReturnMasterTable() async {
    Database db = await instance.database;

    var result = await db.rawQuery(
        "SELECT returnMasterTable.id as id, returnMasterTable.os  || returnMasterTable.return_id as ser,returnMasterTable.return_id as srid,returnMasterTable.customerid cuid,returnMasterTable.return_date  || ' '  ||returnMasterTable.return_time return_date, returnMasterTable.userid as sid,returnMasterTable.areaid as aid  FROM returnMasterTable where returnMasterTable.status=0");
    print("result ---return ---$result");
    return result;
  }

////////////////////upload remark data////////////////////////
  uploadRemark() async {
    Database db = await instance.database;
    var result = await db.rawQuery(
        "SELECT remarksTable.id as rid, remarksTable.rem_row_num as phid, remarksTable.rem_cusid as cid,remarksTable.rem_date as rdate,remarksTable.rem_text as rtext,remarksTable.rem_staffid as sid,remarksTable.rem_cancel as cflag,remarksTable.rem_status as dflag,remarksTable.rem_date || ' '  || remarksTable.rem_time as edate FROM remarksTable where rem_status=0");
    print("remark select result.........$result");
    return result;
  }

  ////////////////////upload collection data////////////////////////
  uploadCollections() async {
    print("collectionnn");
    Database db = await instance.database;
    var result = await db.rawQuery(
        // "SELECT * FROM collectionTable");
        "SELECT collectionTable.id as colid, collectionTable.rec_row_num as phid, collectionTable.rec_cusid as cid,collectionTable.rec_date as cdate,collectionTable.rec_series || collectionTable.rec_row_num as cseries,collectionTable.rec_mode as cmode,collectionTable.rec_amount as camt,collectionTable.rec_disc as cdisc,collectionTable.rec_note as cremark, collectionTable.rec_staffid as sid,collectionTable.rec_cancel as cflag,collectionTable.rec_cancel as dflag,collectionTable.rec_date || ' ' || collectionTable.rec_time as edate FROM collectionTable where rec_status=0");
    print("collectionTable select result.........$result");
    return result;
  }

////////////////////////////////////////////
  selectDetailTable(int order_id) async {
    Database db = await instance.database;

    var result = await db.rawQuery(
        "SELECT orderDetailTable.code as code,orderDetailTable.item as item, orderDetailTable.qty as qty, orderDetailTable.rate as rate, orderDetailTable.unit as unit, orderDetailTable.packing as packing from orderDetailTable  where  orderDetailTable.order_id=${order_id}");
    return result;
  }

//////////////////////////////////////////////////////////
  selectSalesDetailTable(int sales_id) async {
    print("sales id----$sales_id");
    Database db = await instance.database;
    var query2 = "";
    query2 = query2 +
        "SELECT salesDetailTable.code as code,salesDetailTable.hsn as hsn," +
        " salesDetailTable.item_name as item, salesDetailTable.qty as qty," +
        " salesDetailTable.rate as rate,salesDetailTable.unit as unit," +
        " salesDetailTable.packing as packing, " +
        " salesDetailTable.unit_rate as unit_rate,salesDetailTable.gross_amount as gross," +
        " salesDetailTable.dis_per as disc_per,salesDetailTable.dis_amt as disc_amt," +
        " salesDetailTable.cgst_per as cgst_per,salesDetailTable.cgst_amt as cgst_amt," +
        " salesDetailTable.sgst_per as sgst_per,salesDetailTable.sgst_amt as sgst_amt," +
        " salesDetailTable.igst_per as igst_per,salesDetailTable.igst_amt as igst_amt," +
        " salesDetailTable.tax_per as tax_per,salesDetailTable.tax_amt as tax_amt," +
        " salesDetailTable.ces_per as ces_per,salesDetailTable.ces_amt as ces_amt," +
        " salesDetailTable.net_amt as net_amt" +
        " from salesDetailTable  where  salesDetailTable.sales_id=${sales_id};";

    var result = await db.rawQuery(query2);
    //     "SELECT salesDetailTable.code as code,salesDetailTable.item_name as item, salesDetailTable.qty as qty, salesDetailTable.rate as rate,salesDetailTable.gross_amount as gross,salesDetailTable.dis_per as disc_per,salesDetailTable.dis_amt as disc_amt,salesDetailTable.tax_per as tax_per,salesDetailTable.tax_amt as tax_amt,salesDetailTable.ces_per as ces_per,salesDetailTable.ces_amt as ces_amt,salesDetailTable.ces_amt as ces_amt,salesDetailTable.ces_amt as ces_amt,salesDetailTable.ces_amt as ces_amt,salesDetailTable.ces_amt as ces_amt,salesDetailTable.net_amt as net_amt  from salesDetailTable  where  salesDetailTable.sales_id=${sales_id}");
    print("sales detao;s------$result");
    return result;
  }

///////////////////////////////////////////////////////////////////////
  selectReturnDetailTable(int return_id) async {
    Database db = await instance.database;

    var result = await db.rawQuery(
        "SELECT returnDetailTable.code as code,returnDetailTable.item as item, returnDetailTable.qty as qty, returnDetailTable.rate as rate, returnDetailTable.unit as unit, returnDetailTable.packing as packing from returnDetailTable  where  returnDetailTable.return_id=${return_id}");
    return result;
  }

  ///////////////////////////////////////////////////////
  upadteCommonQuery(String table, String fields, String condition) async {
    Database db = await instance.database;
    print("condition for update...$table....$fields.............$condition");
    var query = 'UPDATE $table SET $fields WHERE $condition ';
    print("qyery-----$query");
    var res = await db.rawUpdate(query);
    print("response-update------$res");
    return res;
  }

  ////////////////// today order total //////////////////////////////////

  sumCommonQuery(String field, String table, String condition) async {
    String sum;
    Database db = await instance.database;
    var result = await db
        .rawQuery("SELECT sum($field) as S FROM $table WHERE $condition");
    print("result sum----$result");
    sum = result[0]["S"].toString();

    print("sum--$sum");
    return sum;
  }

///////////////////////////////////////////////////////
  getReportDataFromOrderDetails(String userId, String date,
      BuildContext context, String likeCondition) async {
    List<Map<String, dynamic>> result;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? areaidfromStaff = prefs.getString("areaidfromStaff");
    print("aredhgsh----$areaidfromStaff");
    String condition = " ";
    if (areaidfromStaff != null || areaidfromStaff!.isNotEmpty) {
      if (areaidfromStaff == "") {
        if (likeCondition == "") {
          condition = "";
        } else {
          condition = " where $likeCondition";
        }
      } else {
        if (likeCondition == "") {
          condition = " where A.area_id in ($areaidfromStaff) ";
        } else {
          condition =
              " where A.area_id in ($areaidfromStaff) and $likeCondition";
        }
      }
    }

    // String? gen_area =
    //     Provider.of<Controller>(context, listen: false).areaidFrompopup;
    // if (gen_area != null) {
    //   gen_condition1 = " and O.areaid=$gen_area";
    //   gen_condition2= " and R.areaid=$gen_area ";
    // } else {
    //   gen_condition = " ";
    // }
    Database db = await instance.database;
    String query2 = "";
    String query1 = "";
    query2 = query2 +
        " select A.ac_code  as cusid, A.hname as name," +
        " A.ac_ad1 as ad1,A.mo as mob ," +
        " A.ba as bln, Y.ord  as order_value," +
        " Y.remark as remark_count , Y.col as collection_sum" +
        " from accountHeadsTable A " +
        " left join (select cid,sum(Ord) as ord," +
        " sum(remark) as remark ,sum(col) as col from (" +
        " select O.customerid cid, sum(O.total_price) Ord," +
        " 0 remark,0 col from orderMasterTable O" +
        " where O.userid='$userId' and O.orderdate = '$date' group by O.customerid" +
        " union all " +
        " select R.rem_cusid cid, 0 Ord, count(R.rem_cusid) remark ," +
        " 0 col from remarksTable R where R.rem_staffid='$userId' and R.rem_date  = '$date' and R.rem_cancel=0 " +
        " group by R.rem_cusid" +
        " union all" +
        " select C.rec_cusid cid, 0 Ord , 0 remark," +
        " sum(C.rec_amount) col" +
        " from collectionTable C where C.rec_staffid='$userId' and C.rec_date  = '$date' and C.rec_cancel=0 " +
        " group by C.rec_cusid) x group by cid ) Y on Y.cid=A.ac_code" +
        " $condition " +
        " order by Y.ord+ Y.remark+ Y.col desc ;";
    print("query2----$query2");
    result = await db.rawQuery(query2);

    print("result.length-${result}");
    return result;
    // if (result.length > 0) {
    //   print("result-order-----$result");
    //   return result;
    // } else {
    //   return [];
    // }
  }

//////////////////////shops not visited///////////////////////
  dashboardSummery(String userId, String date, String aid) async {
    Database db = await instance.database;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? areaidfromStaff = prefs.getString("areaidfromStaff");
    String condition = " ";
    int? area;
    print("userrr---$userId");
    if (aid != "") {
      area = int.parse(aid);
    } else {
      area = 0;
    }

    if (areaidfromStaff != "") {
      if (area == 0) {
        String str = areaidfromStaff![areaidfromStaff.length - 1];
        if (str == ",") {
          str = areaidfromStaff.substring(0, areaidfromStaff.length - 1);
          condition = " where A.area_id in ($str) ";
        } else {
          condition = " where A.area_id in ($areaidfromStaff) ";
        }
      } else {
        condition = " where A.area_id in ($area) ";
      }
    } else {
      if (area == 0) {
        condition = "";
      } else {
        condition = " where A.area_id in ($area) ";
      }
    }

    print("dashsum--areaidfromStaff--$condition--$areaidfromStaff");
    List<Map<String, dynamic>> result;
    String query = "";
    query = query +
        " Select " +
        " count(Distinct X.cid) cusCount," +
        " sum(X.ordCnt) ordCnt,sum(X.ordVal) ordVal,sum(X.rmCnt) rmCnt," +
        " sum(X.colCnt) colCnt,sum(X.colVal) colVal, sum(X.saleCnt) saleCnt ,sum(X.saleVal) saleVal," +
        " sum(X.saleCntCS) saleCntCS ,sum(X.saleValCS) saleValCS," +
        " sum(X.saleCntCR) saleCntCR ,sum(X.saleValCR) saleValCR," +
        " sum(X.retCnt) retCnt ,sum(X.retVal) retVal,Sum(X.CanCnt) canCnt, Sum(X.CanAmt) canAmt " +
        " from accountHeadsTable A  " +
        " inner join (" +
        " Select O.customerid cid , Count(O.id) ordCnt,Sum(O.total_price) ordVal,0 rmCnt,0 colCnt,0 colVal,0 saleCnt,0 saleVal,0 saleCntCS,0 saleValCS,0 saleCntCR,0 saleValCR,0 retCnt,0 retVal,0 CanCnt, 0 CanAmt " +
        " From orderMasterTable O where O.orderdate='$date' and  O.userid='$userId'" +
        " group by O.customerid" +
        " union all" +
        " Select R.rem_cusid cid , 0 ordCnt,0 ordVal,Count(R.id) rmCnt,0 colCnt,0 colVal,0 saleCnt,0 saleVal,0 saleCntCS,0 saleValCS,0 saleCntCR,0 saleValCR,0 retCnt,0 retVal,0 CanCnt, 0 CanAmt" +
        " From remarksTable R where R.rem_date='$date' and R.rem_staffid='$userId' and R.rem_cancel=0" +
        " group by R.rem_cusid" +
        " union all" +
        " Select C.rec_cusid cid , 0 ordCnt,0 ordVal,0 rmCnt,Count(C.id) colCnt,Sum(C.rec_amount) colVal,0 saleCnt,0 saleVal,0 saleCntCS,0 saleValCS,0 saleCntCR,0 saleValCR,0 retCnt,0 retVal,0 CanCnt, 0 CanAmt" +
        " From collectionTable C  where C.rec_date='$date' and C.rec_staffid='$userId' and C.rec_cancel=0" +
        " group by C.rec_cusid" +
        " union all" +
        " Select RT.customerid cid , 0 ordCnt,0 ordVal,0 rmCnt,0 colCnt,0 colVal,0 saleCnt,0 saleVal,0 saleCntCS,0 saleValCS,0 saleCntCR,0 saleValCR,Count(RT.id) retCnt,Sum(RT.total_price) retVal,0 CanCnt, 0 CanAmt" +
        " From returnMasterTable RT   where RT.return_date='$date' and RT.userid='$userId'" +
        " group by RT.customerid" +
        " union all" +
        " Select S.customer_id cid , 0 ordCnt,0 ordVal,0 rmCnt,0 colCnt,0 colVal,Count(S.id) saleCnt,Sum(S.net_amt) saleVal,0 saleCntCS,0 saleValCS,0 saleCntCR,0 saleValCR, 0 retCnt,0 retVal,0 CanCnt, 0 CanAmt" +
        " From salesMasterTable S   where S.cancel= 0 and S.salesdate='$date' and S.staff_id='$userId'" +
        " group by S.customer_id" +
        " union all" +
        " Select S.customer_id cid , 0 ordCnt,0 ordVal,0 rmCnt,0 colCnt,0 colVal,0 saleCnt,0 saleVal,0 saleCntCS,0 saleValCS,0 saleCntCR,0 saleValCR, 0 retCnt,0 retVal,Count(S.id) CanCnt, Sum(S.net_amt) CanAmt" +
        " From salesMasterTable S   where S.cancel= 1 and S.salesdate='$date' and S.staff_id='$userId'" +
        " group by S.customer_id" +
        " union all" +
        " Select S.customer_id cid , 0 ordCnt,0 ordVal,0 rmCnt,0 colCnt,0 colVal,0 saleCnt,0 saleVal,Count(S.id) saleCntCS,Sum(S.net_amt) saleValCS,0 saleCntCR,0 saleValCR,0 retCnt,0 retVal,0 CanCnt, 0 CanAmt" +
        " From salesMasterTable S   where  S.cancel= 0 and S.salesdate='$date' and S.staff_id='$userId' and S.payment_mode = '-2' " +
        " group by S.customer_id" +
        " union all" +
        " Select S.customer_id cid , 0 ordCnt,0 ordVal,0 rmCnt,0 colCnt,0 colVal,0 saleCnt,0 saleVal,0 saleCntCS,0 saleValCS,Count(S.id) saleCntCR,Sum(S.net_amt) saleValCR,0 retCnt,0 retVal,0 CanCnt, 0 CanAmt" +
        " From salesMasterTable S   where  S.cancel= 0 and S.salesdate='$date' and S.staff_id='$userId' and S.payment_mode = '-3' " +
        " group by S.customer_id" +
        " ) X ON X.cid=A.ac_code" +
        " $condition;";

    result = await db.rawQuery(query);
    // print("dashboard sum-$condition");
    print("result--dashboard----$result");
    return result;
  }

//////////////////////////////////////////////////////////////
  getShopsVisited(String userId, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? areaidfromStaff = prefs.getString("areaidfromStaff");
    String condition = " ";
    print("userId kjdfkljfkml---$areaidfromStaff");
    List<Map<String, dynamic>> result;
    if (areaidfromStaff != null) {
      condition = " and area_id in ($areaidfromStaff)";
    }

    int count;
    Database db = await instance.database;
    String query = "";
    query = query +
        "select count(distinct cid) cnt from accountHeadsTable A  inner join  (" +
        " select O.customerid cid from orderMasterTable O " +
        "where O.userid='$userId' and orderdate='$date' " +
        " group by O.customerid " +
        "union all " +
        " select R.rem_cusid cid " +
        "from remarksTable R " +
        " where R.rem_staffid='$userId' and rem_date='$date' and R.rem_cancel=0 " +
        " group by R.rem_cusid " +
        "union all " +
        "select C.rec_cusid cid   " +
        " from collectionTable C " +
        "where C.rec_staffid='$userId' and rec_date='$date' and C.rec_cancel=0 " +
        "group by C.rec_cusid " +
        " UNION ALL " +
        "select RT.customerid " +
        "from returnMasterTable RT " +
        "where RT.userid='$userId' and return_date='$date' " +
        "group by RT.customerid) x on A.ac_code = x.cid $condition;";
    print(query);
    result = await db.rawQuery(query);
    print("result.length-${result.length}");
    if (result.length > 0) {
      count = result[0]["cnt"];
      print("result shop visited-----$result");
      return count;
    } else {
      return null;
    }
  }

//////////////////////select  collection///////////////////////
  selectAllcommonwithdesc(String table, String? condition) async {
    print("haiiiii");
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    if (condition == null || condition.isEmpty) {
      result = await db.rawQuery("SELECT * FROM '$table' ORDER BY id DESC");
    } else {
      result = await db
          .rawQuery("SELECT * FROM '$table' WHERE $condition ORDER BY id DESC");
    }
    print("result menu common----$result");
    return result;
  }
  ////////////////////////DELETE TABLE ////////////////////////////////////

  // getReportRemarkOrderDetails() async {
  //   List<Map<String, dynamic>> result;

  //   Database db = await instance.database;
  //   result = await db.rawQuery(
  //       'select A.ac_code  as cusid, A.hname as name,A.ac_ad1 as ad1,A.mo as mob , A.ba as bln, Y.ord  as order_value, Y.remark as remark_count , Y.col as collection_sum from accountHeadsTable A  left join (select cid,sum(Ord) as ord, sum(remark) as remark ,sum(col) as col from (select O.customerid cid, sum(O.total_price) Ord,0 remark,0 col from orderMasterTable O group by O.customerid union all select R.rem_cusid cid, 0 Ord, count(R.rem_cusid) remark , 0 col from remarksTable R group by R.rem_cusid union all select C.rec_cusid cid, 0 Ord , 0 remark, sum(C.rec_amount) col  from collectionTable C group by C.rec_cusid) x group by cid ) Y on Y.cid=A.ac_code order by Y.ord+ Y.remark+ Y.col+ Y.remark_count desc');
  //   if (result.length > 0) {
  //     print("result-order-----$result");
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  // getReportDataFromOrderDetails() async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;

  //   result = await db.rawQuery(
  //       'select orderMasterTable.customerid as cusid, orderMasterTable.total_price  as total,accountHeadsTable.hname as name,accountHeadsTable.ac_ad1 as ad1,accountHeadsTable.mo as mob , accountHeadsTable.ba as bln from orderMasterTable inner join accountHeadsTable on orderMasterTable.customerid=accountHeadsTable.code');
  //   if (result.length > 0) {
  //     // print("result-order-----$result");
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  // getReportDataFromRemarksTable() async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;

  //   result = await db.rawQuery(
  //       'select remarksTable.rem_cusid as cusid, accountHeadsTable.hname as name,accountHeadsTable.ac_ad1 as ad1, accountHeadsTable.ba as bln from remarksTable inner join accountHeadsTable on remarksTable.rem_cusid=accountHeadsTable.code');
  //   if (result.length > 0) {
  //     // print("result---remrk---$result");
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  // getReportDataFromCollectionTable() async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;

  //   result = await db.rawQuery(
  //       'select collectionTable.rec_cusid as cusid, collectionTable.rec_mode as mode ,accountHeadsTable.hname as name,accountHeadsTable.ac_ad1 as ad1, accountHeadsTable.ba as bln from collectionTable inner join accountHeadsTable on collectionTable.rec_cusid=accountHeadsTable.code');
  //   if (result.length > 0) {
  //     // print("result---cooll---$result");
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

////////////////////////////////////////////////////
  // selectFrommasterQuery(String table, String? condition) async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;
  //   if (condition == null) {
  //     result = await db.rawQuery("SELECT * FROM '$table'");
  //   } else {
  //     result = await db.rawQuery(
  //         "SELECT id, os || order_id as ser, order_id as oid, customerid as cuid, orderdatetime as odate, userid as staff_id, areaid as aid FROM '$table' WHERE $condition");
  //   }

  //   // print("naaknsdJK-----$result");
  //   return result;
  // }

  // selectFromDetailTable(String table, String? condition) async {
  //   List<Map<String, dynamic>> result;
  //   Database db = await instance.database;
  //   if (condition == null) {
  //     result = await db.rawQuery("SELECT * FROM '$table'");
  //   } else {
  //     result = await db
  //         .rawQuery("SELECT code , qty, rate FROM '$table' WHERE $condition");
  //   }

  //   // print("naaknsdJK-----$result");
  //   return result;
  // }

  uploadCustomer() async {
    List<Map<String, dynamic>> result;
    Database db = await instance.database;
    String query = "";
    query = query +
        " select accountHeadsTable.ac_code as hcd," +
        " accountHeadsTable.hname as nme,accountHeadsTable.ac_ad1 as ad1," +
        " accountHeadsTable.ac_ad2 as ad2,accountHeadsTable.ac_ad3 as ad3," +
        " accountHeadsTable.area_id as aid,accountHeadsTable.gtype as gtype," +
        " accountHeadsTable.phn as ph,accountHeadsTable.mo as mo " +
        " from accountHeadsTable inner join customerTable " +
        " on customerTable.ac_code=accountHeadsTable.ac_code";

    print("query---$query");
    result = await db.rawQuery(query);
    if (result.length > 0) {
      print("inner result------$result");
      return result;
    } else {
      return null;
    }
  }

  /////////////////////////////////////
  calculateMaxSeries(
    String prefix,
    String table,
    String maxfield,
  ) async {
    print("max series..............$maxfield....,$table...,$prefix");
    var result;
    int order_id;
    Database db = await instance.database;
    var qry =
        "SELECT MAX(value) maxval FROM (SELECT value FROM maxSeriesTable WHERE prefix = '$prefix' UNION ALL SELECT MAX($maxfield)+1  as value FROM $table)";
    print("maxseries......$qry");
    result = await db.rawQuery(qry);
    // int maxtabid = int.parse(result[0]["value"]);
    // int ordertabid = int.parse(result[1]["value"]);
    // print("idddddddd.$maxtabid...$ordertabid");
    print("ds---${result}");

    print("dsdd---${result[0]["maxval"].runtimeType}");
    order_id = result[0]["maxval"];
    // print("result maxxxx.$result...$order_id");
    return order_id;
  }

  executeQuery(String query) async {
    Database db = await instance.database;
    var result = await db.rawQuery(query);
    return result;
  }

  printOrderDetailTable(String data) async {
    List s = data.split(" ");
    print("date-vvv-----${s[0]}");
    Database db = await instance.database;
    var qry =
        "SELECT item,qty,rate from orderDetailTable inner join orderMasterTable" +
            "  on orderMasterTable.order_id =orderDetailTable.order_id where orderMasterTable.orderdate = '${s[0]}' ";
    print("print order----$qry");
    var result = await db.rawQuery(qry);
    print("jchjc---$result");
    return result;
  }

  getDbPath() async {
    String dbpath = await getDatabasesPath();
    print("database path--------$dbpath");
    Directory? externalstoragepath = await getExternalStorageDirectory();
    print("external storagr-------$externalstoragepath");
  }

  backupDB() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    var status1 = await Permission.storage.status;
    if (!status1.isGranted) {
      await Permission.storage.request();
    }

    try {
      File ourDbFile =
          File('/data/user/0/com.example.orderapp/databases/orderapp.db');
      Directory? folderPathforDBfile =
          Directory('/storage/emulated/0/OrderappDatabses/');
      await folderPathforDBfile.create();
      await ourDbFile.copy('/storage/emulated/0/OrderappDatabses/orderapp.db');
    } catch (e) {
      print("exce-=-------${e.toString()}");
    }
  }

  restoreDB() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    var status1 = await Permission.storage.status;
    if (!status1.isGranted) {
      await Permission.storage.request();
    }

    try {
      File saveDBFile =
          File('/storage/emulated/0/OrderappDatabses/orderapp.db');

      await saveDBFile
          .copy('/data/user/0/com.example.orderapp/databases/orderapp.db');
    } catch (e) {
      print("exce-=-------${e.toString()}");
    }
  }
}
