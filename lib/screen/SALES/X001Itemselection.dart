import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customSearchTile.dart';
import 'package:salesapp/components/customSnackbar.dart';
import 'package:salesapp/components/popupPayment.dart';
import 'package:salesapp/components/showMoadal.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:salesapp/screen/SALES/saleItemDetails.dart';

import 'package:provider/provider.dart';
import 'package:salesapp/screen/SALES/sale_bag_X001.dart';

import '../../components/X001_bottomsheet.dart';

class SalesItem extends StatefulWidget {
  // List<Map<String,dynamic>>  products;
  String customerId;
  String os;
  String areaId;
  String areaName;
  String type;
  bool _isLoading = false;
  String gtype;

  SalesItem(
      {required this.customerId,
      required this.areaId,
      required this.os,
      required this.areaName,
      required this.type,
      required this.gtype});

  @override
  State<SalesItem> createState() => _SalesItemState();
}

class _SalesItemState extends State<SalesItem> {
  PaymentSelect paysheet = PaymentSelect();
  CoconutSheet cocosheet = CoconutSheet();
  // double baseRate = 1.0;
  // String rate1 = "1";
  String? selected;
  String tempcode = "";
  double? temp;
  double? newqty = 0.0;
  TextEditingController searchcontroll = TextEditingController();
  ShowModal showModal = ShowModal();
  SaleItemDetails saleDetails = SaleItemDetails();
  List<Map<String, dynamic>> products = [];
  SearchTile search = SearchTile();
  DateTime now = DateTime.now();
  // CustomSnackbar snackbar = CustomSnackbar();
  List<String> s = [];
  String? date;
  bool loading = true;
  bool loading1 = false;
  CustomSnackbar snackbar = CustomSnackbar();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    searchcontroll.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("customer id....os....${widget.customerId}--${widget.os}");
    products = Provider.of<Controller>(context, listen: false).productName;
    print("products---${products}");
    Provider.of<Controller>(context, listen: false).selectSettings(
        "set_code in ('SL_RATE_EDIT','SL_TAX_CALC','SL_UPLOAD_DIRECT') ");
    Provider.of<Controller>(context, listen: false).getOrderno();
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    s = date!.split(" ");

    // Provider.of<Controller>(context, listen: false)
    //     .getSaleProductList(widget.customerId);
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        // shape: shape,
        // color: P_Settings.ratecolor,
        child: Consumer<Controller>(
          builder: (context, value, child) {
            return Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    // width: size.width * 0.3,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: P_Settings.ratecolor, // background
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Provider.of<Controller>(context, listen: false)
                              .selectSettings(
                                  "set_code in ('SL_RATE_EDIT','SL_TAX_CALC','SL_UPLOAD_DIRECT') ");

                          Provider.of<Controller>(context, listen: false)
                              .getSaleBagDetails(widget.customerId, widget.os,
                                  "", context, widget.areaId, widget.areaName);

                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) => SaleCartX001(
                                areaId: widget.areaId,
                                custmerId: widget.customerId,
                                os: widget.os,
                                areaname: widget.areaName,
                                type: widget.type,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "View Data",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.tableheadingColor,
                          ),
                        )),
                  ),
                  Expanded(
                    // width: size.width * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // background
                      ),
                      onPressed: () async {
                        print("hai");
                        await Provider.of<Controller>(context, listen: false)
                            .getSaleBagDetails(
                                widget.customerId,
                                widget.os,
                                "from save",
                                context,
                                widget.areaId,
                                widget.areaName);

                        // if (value.salebagLength > 0) {
                        //   print("value.salnjjjj-----}");
                        //   paysheet.showpaymentSheet(
                        //       context,
                        //       widget.areaId,
                        //       widget.areaName,
                        //       widget.customerId,
                        //       s[0],
                        //       s[1],
                        //       " ",
                        //       " ",
                        //       value.orderTotal2[11]);
                        // }
                      },
                      child: Text(
                        'Save',
                        style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: P_Settings.tableheadingColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    // width: size.width * 0.3,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                        ),
                        onPressed: () async {
                          if (value.salebagList.length > 0) {
                            _discardAlert(context, widget.customerId);
                          }
                        },
                        child: Text(
                          "Discard",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: P_Settings.tableheadingColor,
                          ),
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Provider.of<Controller>(context, listen: false).filterCompany =
                false;
            Provider.of<Controller>(context, listen: false)
                .filteredProductList
                .clear();
            Provider.of<Controller>(context, listen: false).searchkey = "";
            Provider.of<Controller>(context, listen: false).newList = products;
            Provider.of<Controller>(context, listen: false).fetchwallet();
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: P_Settings.salewaveColor,
        actions: <Widget>[
          // Consumer<Controller>(
          //   builder: (context, _value, child) {
          //     return PopupMenuButton<String>(
          //       onSelected: (value) {
          //         print("selected val............$selected");
          //         //  Provider.of<Controller>(context, listen: false)
          //         //     .filteredeValue = value;

          //         // if (value == "0") {
          //         //   setState(() {
          //         //     Provider.of<Controller>(context, listen: false)
          //         //         .filterCompany = false;
          //         //   });

          //         //   Provider.of<Controller>(context, listen: false)
          //         //       .filteredProductList
          //         //       .clear();
          //         //   Provider.of<Controller>(context, listen: false)
          //         //       .getProductList(widget.customerId);
          //         // } else {
          //         //   print("value---$value");
          //         //   Provider.of<Controller>(context, listen: false)
          //         //         .filterCompany = true;
          //         //   Provider.of<Controller>(context, listen: false)
          //         //       .filterwithCompany(widget.customerId, value,"sale order");
          //         // }///////////////

          //         Provider.of<Controller>(context, listen: false)
          //             .salefilteredeValue = value;
          //         if (value == "0") {
          //           setState(() {
          //             Provider.of<Controller>(context, listen: false)
          //                 .salefilterCompany = false;
          //           });

          //           Provider.of<Controller>(context, listen: false)
          //               .salefilteredProductList
          //               .clear();
          //           Provider.of<Controller>(context, listen: false)
          //               .getSaleProductList(widget.customerId);
          //         } else {
          //           print("value---$value");
          //           Provider.of<Controller>(context, listen: false)
          //               .salefilterCompany = true;
          //           Provider.of<Controller>(context, listen: false)
          //               .filterwithCompany(widget.customerId, value, "sales");
          //         }
          //       },
          //       itemBuilder: (context) => _value.productcompanyList
          //           .map((item) => PopupMenuItem<String>(
          //                 value: item["comid"],
          //                 child: Text(
          //                   item["comanme"],
          //                 ),
          //               ))
          //           .toList(),
          //     );
          //   },
          // ),
        ],
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: size.width * 0.95,
                  height: size.height * 0.09,
                  child: TextFormField(
                    controller: searchcontroll,
                    onChanged: (val) {
                      if (val.isNotEmpty && val != null) {
                        Provider.of<Controller>(context, listen: false)
                            .setisVisible(true);

                        val = searchcontroll.text;
                        // Provider.of<Controller>(context, listen: false)
                        //     .getSaleBagDetails(widget.customerId, widget.os);
                        value.searchkey = searchcontroll.text;

                        Provider.of<Controller>(context, listen: false)
                            .setIssearch(true);
                        // print("hjdf----$list");

                        Provider.of<Controller>(context, listen: false)
                                .salefilterCompany
                            ? Provider.of<Controller>(context, listen: false)
                                .searchProcess_X001(
                                    widget.customerId,
                                    widget.os,
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .salefilteredeValue!,
                                    "sales",
                                    value.salesitemList2,
                                    "sales",
                                    context)
                            : Provider.of<Controller>(context, listen: false)
                                .searchProcess_X001(
                                    widget.customerId,
                                    widget.os,
                                    "",
                                    "sales",
                                    value.salesitemList2,
                                    "sales",
                                    context);
                      }
                    },
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
                      hintText: "Search with  Product code/Name/category",
                      hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                      suffixIcon: value.isVisible
                          ? Wrap(
                              children: [
                                // IconButton(
                                //     icon: Icon(
                                //       Icons.done,
                                //       size: 20,
                                //     ),
                                //     onPressed: () async {
                                //       // Provider.of<Controller>(context,
                                //       //         listen: false)
                                //       //     .getSaleProductList(
                                //       //         widget.customerId);

                                //       Provider.of<Controller>(context,
                                //               listen: false)
                                //           .getSaleBagDetails(
                                //               widget.customerId, widget.os);
                                //       Provider.of<Controller>(context,
                                //               listen: false)
                                //           .searchkey = searchcontroll.text;

                                //       Provider.of<Controller>(context,
                                //               listen: false)
                                //           .setIssearch(true);
                                //       // print("hjdf----$list");

                                //       Provider.of<Controller>(context,
                                //                   listen: false)
                                //               .salefilterCompany
                                //           ? Provider.of<Controller>(context,
                                //                   listen: false)
                                //               .searchProcess_X001(
                                //                   widget.customerId,
                                //                   widget.os,
                                //                   Provider.of<Controller>(
                                //                           context,
                                //                           listen: false)
                                //                       .salefilteredeValue!,
                                //                   "sales",
                                //                   value.salesitemList2,
                                //                   "sales")
                                //           : Provider.of<Controller>(context,
                                //                   listen: false)
                                //               .searchProcess_X001(
                                //                   widget.customerId,
                                //                   widget.os,
                                //                   "",
                                //                   "sales",
                                //                   value.salesitemList2,
                                //                   "sales");
                                //     }),
                                IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .fromSalesbagTable_X001(
                                              widget.customerId, "sales");
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .setIssearch(false);

                                      value.setisVisible(false);
                                      // Provider.of<Controller>(context,
                                      //         listen: false)
                                      //     .newList
                                      //     .clear();

                                      searchcontroll.clear();
                                    }),
                              ],
                            )
                          : Icon(
                              Icons.search,
                              size: 20,
                            ),
                    ),
                  ),
                ),
              ),
              // value.isListLoading
              //     ? Center(
              //         child: SpinKitCircle(
              //           color: P_Settings.salewaveColor,
              //           size: 40,
              //         ),
              //       )
              //     :

              Expanded(
                child: value.isSearch
                    ? value.isListLoading
                        ? SpinKitCircle(
                            color: Colors.green,
                          )
                        : value.newList.length > 0
                            ? ListView.builder(
                                // itemExtent: 60,
                                shrinkWrap: true,
                                itemCount: value.newList.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0.4, right: 0.4, bottom: 0.2),
                                    child: Card(
                                      child: ListTile(
                                        onTap: () async {
                                          print("clickedddd---");
                                          Provider.of<Controller>(context,
                                                      listen: false)
                                                  .product_code =
                                              value.newList[index]["prcode"];

                                          // Provider.of<Controller>(
                                          //         context,
                                          //         listen: false)
                                          //     .fetchProductUnits(
                                          //         value.salesitemList2[
                                          //                 index]
                                          //             ["prid"]);
                                          await Provider.of<Controller>(context,
                                                  listen: false)
                                              .fromSalesListData_X001(
                                                  widget.customerId,
                                                  value.product_code!,
                                                  index);
                                          value.selectedunit_X001 = null;
                                          print(
                                              "item name...${value.salesitemListdata2[0]['item']}");
                                          if (value.isLoading) {
                                            CircularProgressIndicator();
                                          } else {
                                            value.discount_prercent_X001[index]
                                                .text = "0.0";
                                            value.discount_amount_X001[index]
                                                .text = "0.0";
                                            print(
                                                "kjdjfkj-${value.salesitemListdata2[0]['code']}----${value.salesitemListdata2[0]['item']}---${value.salesitemListdata2[0]['rate1']}----${value.salesitemListdata2[0]['tax']}");
                                            // value.selectedItem =
                                            //     null;
                                            value.selectedunit_X001 = null;
                                            value.gross = 0.00;
                                            value.net_amt = 0.00;
                                            value.tax = 0.00;
                                            value.salesqty_X001[index].clear();
                                            value.salesrate_X001[index].clear();
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .setUnitSale_X001(
                                                    value.frstDropDown!, index);
                                            value.selectedItem =
                                                value.frstDropDown;

                                            value.salesqty_X001[index].text =
                                                "1.0";
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .rawCalculation_X001(
                                                    double.parse(value
                                                        .salesrate_X001[index]
                                                        .text),
                                                    double.parse(value
                                                        .salesqty_X001[index]
                                                        .text),
                                                    double.parse(value
                                                        .discount_prercent_X001[
                                                            index]
                                                        .text),
                                                    double.parse(value
                                                        .discount_amount_X001[
                                                            index]
                                                        .text),
                                                    double.parse(value
                                                            .salesitemListdata2[
                                                        0]['tax']),
                                                    0.0,
                                                    value.settingsList1[1]
                                                            ['set_value']
                                                        .toString(),
                                                    0,
                                                    index,
                                                    true,
                                                    "");

                                            cocosheet.showsalesMoadlBottomsheet(
                                              value.salesitemListdata2[0]
                                                  ['item'],
                                              value.salesitemListdata2[0]
                                                  ['code'],
                                              double.parse(
                                                  value.salesitemListdata2[0]
                                                      ['rate1']),
                                              0.00,
                                              0.00,
                                              double.parse(
                                                  value.salesitemListdata2[0]
                                                      ['tax']),
                                              0.00,
                                              0.00,
                                              context,
                                              size,
                                              index,
                                              widget.customerId,
                                              widget.os,
                                              0.0,
                                              s[0],
                                              s[1],
                                            );
                                          }
                                        },
                                        dense: true,
                                        title: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment
                                              //         .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    '${value.newList[index]["pritem"]}' +
                                                        '- ' +
                                                        '( ${value.newList[index]["prcode"]} )',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        // color: value.newList[index]
                                                        //             [
                                                        //             "cartrowno"] ==
                                                        //         null
                                                        //     ? value.selected[
                                                        //             index]
                                                        //         ? Colors
                                                        //             .black
                                                        //         : Colors
                                                        //             .black
                                                        //     : Colors
                                                        //         .black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                // value.newList[index]
                                                //             [
                                                //             "qty"] ==
                                                //         null
                                                //     ? Container()
                                                //     : Text(
                                                //         "${value.newList[index]["qty"]}",
                                                //         style: TextStyle(
                                                //             fontSize:
                                                //                 18,
                                                //             fontWeight: FontWeight
                                                //                 .bold,
                                                //             color:
                                                //                 P_Settings.wavecolor),
                                                //       ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: size.height * 0.012),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Column(
                                children: [
                                  Center(
                                    child: Text("No Data Found!!!"),
                                  ),
                                ],
                              )
                    : ListView.builder(
                        // itemExtent: 60,
                        shrinkWrap: true,
                        itemCount: value.salesitemList2.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 0.4, right: 0.4, bottom: 0.2),
                            child: Card(
                              child: ListTile(
                                onTap: () async {
                                  Provider.of<Controller>(context,
                                              listen: false)
                                          .product_code =
                                      value.salesitemList2[index]["prcode"];
                                  await Provider.of<Controller>(context,
                                          listen: false)
                                      .fromSalesListData_X001(widget.customerId,
                                          value.product_code!, index);
                                  value.selectedunit_X001 = null;
                                  print(
                                      "item name...${value.salesitemListdata2[0]['item']}");
                                  if (value.isLoading) {
                                    CircularProgressIndicator();
                                  } else {
                                    value.discount_prercent_X001[index].text =
                                        "0.0";
                                    value.discount_amount_X001[index].text =
                                        "0.0";
                                    print(
                                        "kjdjfkj-${value.salesitemListdata2[0]['code']}----${value.salesitemListdata2[0]['item']}---${value.salesitemListdata2[0]['rate1']}----${value.salesitemListdata2[0]['tax']}");
                                    // value.selectedItem =
                                    //     null;
                                    value.gross = 0.00;
                                    value.net_amt = 0.00;
                                    value.tax = 0.00;
                                    value.salesqty_X001[index].clear();
                                    value.salesrate_X001[index].clear();

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .setUnitSale_X001(
                                            value.frstDropDown!, index);
                                    value.selectedItem = value.frstDropDown;

                                    value.salesqty_X001[index].text = "1.0";
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .rawCalculation_X001(
                                            double.parse(value
                                                .salesrate_X001[index].text),
                                            double.parse(value
                                                .salesqty_X001[index].text),
                                            double.parse(value
                                                .discount_prercent_X001[index]
                                                .text),
                                            double.parse(value
                                                .discount_amount_X001[index]
                                                .text),
                                            double.parse(value
                                                .salesitemListdata2[0]['tax']),
                                            0.0,
                                            value.settingsList1[1]['set_value']
                                                .toString(),
                                            0,
                                            index,
                                            true,
                                            "");

                                    cocosheet.showsalesMoadlBottomsheet(
                                      value.salesitemListdata2[0]['item'],
                                      value.salesitemListdata2[0]['code'],
                                      double.parse(
                                          value.salesitemListdata2[0]['rate1']),
                                      0.00,
                                      0.00,
                                      double.parse(
                                          value.salesitemListdata2[0]['tax']),
                                      0.00,
                                      0.00,
                                      context,
                                      size,
                                      index,
                                      widget.customerId,
                                      widget.os,
                                      0.0,
                                      s[0],
                                      s[1],
                                    );
                                  }
                                },
                                // dense: true,
                                title: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment:
                                  //     CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            // "sfhuzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzsfi jijijijijijijijijiji jijij ijijijijijijijijijijisf",
                                            '${value.salesitemList2[index]["pritem"]}' +
                                                '- ' +
                                                '( ${value.salesitemList2[index]["prcode"]} )',
                                            // overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // value.salesitemList2[index]
                                        //             [
                                        //             "qty"] ==
                                        //         null
                                        //     ? Container()
                                        //     : Text(
                                        //         "${value.salesitemList2[index]["qty"]}",
                                        //         style: TextStyle(
                                        //             fontSize:
                                        //                 18,
                                        //             fontWeight: FontWeight
                                        //                 .bold,
                                        //             color:
                                        //                 P_Settings.wavecolor),
                                        //       ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       "Rate : ${value.salesitemList2[index]["prrate1"]} ",
                                    //       style: TextStyle(
                                    //           fontStyle: FontStyle.italic,
                                    //           color: Colors.grey[600],
                                    //           fontSize: 13),
                                    //     ),
                                    //     Row(
                                    //       children: [
                                    //         InkWell(
                                    //           onTap: () async {
                                    //             Provider.of<Controller>(context,
                                    //                         listen: false)
                                    //                     .product_code =
                                    //                 value.salesitemList2[index]
                                    //                     ["prcode"];
                                    //             await Provider.of<Controller>(
                                    //                     context,
                                    //                     listen: false)
                                    //                 .fromSalesListData_X001(
                                    //                     widget.customerId,
                                    //                     value.product_code!,
                                    //                     index);
                                    //             value.selectedunit_X001 = null;
                                    //             Provider.of<Controller>(context,
                                    //                     listen: false)
                                    //                 .setUnitSale_X001(
                                    //                     value.frstDropDown!,
                                    //                     index);
                                    //             value.selectedItem =
                                    //                 value.frstDropDown;

                                    //             // value.salesqty_X001[index]
                                    //             //     .text = "1.0";
                                    //             double q = double.parse(value
                                    //                 .salesqty_X001[index].text);
                                    //             q = q - 1;
                                    //             if (q >= 0) {
                                    //               value.salesqty_X001[index]
                                    //                   .text = q.toString();
                                    //               Provider.of<Controller>(
                                    //                       context,
                                    //                       listen: false)
                                    //                   .rawCalculation_X001(
                                    //                       double.parse(value
                                    //                           .salesrate_X001[
                                    //                               index]
                                    //                           .text),
                                    //                       double.parse(value
                                    //                           .salesqty_X001[
                                    //                               index]
                                    //                           .text),
                                    //                       double.parse(value
                                    //                           .discount_prercent_X001[
                                    //                               index]
                                    //                           .text),
                                    //                       double.parse(value
                                    //                           .discount_amount_X001[
                                    //                               index]
                                    //                           .text),
                                    //                       double.parse(
                                    //                           value.salesitemListdata2[0]
                                    //                               ['tax']),
                                    //                       0.0,
                                    //                       value.settingsList1[1]
                                    //                               ['set_value']
                                    //                           .toString(),
                                    //                       0,
                                    //                       index,
                                    //                       true,
                                    //                       "qty");
                                    //             }
                                    //           },
                                    //           child: Container(
                                    //             decoration: BoxDecoration(
                                    //                 border: Border.all(
                                    //               color: Colors.red,
                                    //               width: 1,
                                    //             )),
                                    //             child: Padding(
                                    //               padding:
                                    //                   const EdgeInsets.all(4.0),
                                    //               child: Icon(
                                    //                 Icons.remove,
                                    //                 size: 16,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         Padding(
                                    //           padding: const EdgeInsets.only(
                                    //               left: 8.0, right: 8),
                                    //           child: Text(value
                                    //               .salesqty_X001[index].text),
                                    //         ),
                                    //         InkWell(
                                    //           onTap: () async {
                                    //             Provider.of<Controller>(context,
                                    //                         listen: false)
                                    //                     .product_code =
                                    //                 value.salesitemList2[index]
                                    //                     ["prcode"];
                                    //             await Provider.of<Controller>(
                                    //                     context,
                                    //                     listen: false)
                                    //                 .fromSalesListData_X001(
                                    //                     widget.customerId,
                                    //                     value.product_code!,
                                    //                     index);
                                    //             value.selectedunit_X001 = null;
                                    //             Provider.of<Controller>(context,
                                    //                     listen: false)
                                    //                 .setUnitSale_X001(
                                    //                     value.frstDropDown!,
                                    //                     index);
                                    //             value.selectedItem =
                                    //                 value.frstDropDown;

                                    //             double q = double.parse(value
                                    //                 .salesqty_X001[index].text);
                                    //             q = q + 1;
                                    //             value.salesqty_X001[index]
                                    //                 .text = q.toString();
                                    //             Provider.of<Controller>(context,
                                    //                     listen: false)
                                    //                 .rawCalculation_X001(
                                    //                     double.parse(value
                                    //                         .salesrate_X001[
                                    //                             index]
                                    //                         .text),
                                    //                     double.parse(value
                                    //                         .salesqty_X001[
                                    //                             index]
                                    //                         .text),
                                    //                     double.parse(value
                                    //                         .discount_prercent_X001[
                                    //                             index]
                                    //                         .text),
                                    //                     double.parse(value
                                    //                         .discount_amount_X001[
                                    //                             index]
                                    //                         .text),
                                    //                     double.parse(
                                    //                         value.salesitemListdata2[
                                    //                             0]['tax']),
                                    //                     0.0,
                                    //                     value.settingsList1[1]
                                    //                             ['set_value']
                                    //                         .toString(),
                                    //                     0,
                                    //                     index,
                                    //                     true,
                                    //                     "qty");
                                    //           },
                                    //           child: Container(
                                    //             decoration: BoxDecoration(
                                    //                 border: Border.all(
                                    //               color: Colors.red,
                                    //               width: 1,
                                    //             )),
                                    //             child: Padding(
                                    //               padding:
                                    //                   const EdgeInsets.all(4.0),
                                    //               child: Icon(
                                    //                 Icons.add,
                                    //                 size: 16,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         )
                                    //       ],
                                    //     )
                                    //   ],
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                    //   children: [
                                    //     TextButton(
                                    //         onPressed: () async {
                                    //           int indexCalc = index + 1;

                                    //           int max = await OrderAppDB
                                    //               .instance
                                    //               .getMaxCommonQuery(
                                    //                   'salesBagTable',
                                    //                   'cartrowno',
                                    //                   "os='${widget.os}' AND customerid='${widget.customerId}'");
                                    //           var pid =
                                    //               value.salesitemList2[index]
                                    //                   ['prid'];
                                    //           if (value.salesqty_X001[index]
                                    //                       .text !=
                                    //                   null &&
                                    //               value.salesqty_X001[index]
                                    //                   .text.isNotEmpty) {
                                    //             double total = double.parse(
                                    //                     value
                                    //                         .salesrate_X001[
                                    //                             index]
                                    //                         .text) *
                                    //                 double.parse(value
                                    //                     .salesqty_X001[index]
                                    //                     .text);

                                    //             double baseRate = double.parse(
                                    //                     value
                                    //                         .salesrate_X001[
                                    //                             index]
                                    //                         .text) /
                                    //                 value.package!;
                                    //             print("rateggg----$baseRate");
                                    //             await OrderAppDB.instance.insertsalesBagTable_X001(
                                    //                 value.salesitemList2[index]
                                    //                     ["pritem"],
                                    //                 s[0],
                                    //                 s[1],
                                    //                 widget.os,
                                    //                 widget.customerId,
                                    //                 max,
                                    //                 value.salesitemList2[index]
                                    //                     ["prcode"],
                                    //                 double.parse(value
                                    //                     .salesqty_X001[index]
                                    //                     .text),
                                    //                 value.salesrate_X001[index]
                                    //                     .text,
                                    //                 value.taxable_rate,
                                    //                 total,
                                    //                 value.settingsList1[1]
                                    //                         ['set_value']
                                    //                     .toString(),
                                    //                 value.salesitemList2[index]
                                    //                     ["hsn"],
                                    //                 double.parse(
                                    //                     value.salesitemListdata2[0]
                                    //                         ["tax"]),
                                    //                 value.tax.toDouble(),
                                    //                 value.cgst_per,
                                    //                 value.cgst_amt,
                                    //                 value.sgst_per,
                                    //                 value.sgst_amt,
                                    //                 value.igst_per,
                                    //                 value.igst_amt,
                                    //                 double.parse(value
                                    //                     .discount_prercent_X001[
                                    //                         index]
                                    //                     .text),
                                    //                 double.parse(
                                    //                     value.discount_amount_X001[index].text),
                                    //                 0,
                                    //                 value.cess,
                                    //                 0,
                                    //                 value.net_amt,
                                    //                 pid,
                                    //                 value.selectedItem,
                                    //                 value.package!,
                                    //                 baseRate);
                                    //           }
                                    //         },
                                    //         child: Text("ADD"))
                                    //   ],
                                    // )
                                    // SizedBox(height: size.height * 0.012),
                                  ],
                                ),

                                // ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
}

_discardAlert(BuildContext context, String customerId) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,

        // title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to Discard ? '),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Ok'),
            onPressed: () async {
              await OrderAppDB.instance.deleteFromTableCommonQuery(
                  "salesBagTable", "customerid='${customerId}'");
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
