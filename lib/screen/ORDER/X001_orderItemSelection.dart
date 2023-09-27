import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/X001_bottomsheet.dart';
import 'package:salesapp/components/X001_order_bottom.dart';
import 'package:salesapp/components/common_popup.dart';
import 'package:salesapp/components/customSearchTile.dart';
import 'package:salesapp/components/customSnackbar.dart';
import 'package:salesapp/components/showMoadal.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:salesapp/screen/ORDER/8_cartList.dart';
import 'package:salesapp/screen/ORDER/filterProduct.dart';

import 'package:provider/provider.dart';

import '../../components/commoncolor.dart';

class X001OrderItemSelection extends StatefulWidget {
  String customerId;
  String os;
  String areaId;
  String areaName;
  String type;
  bool _isLoading = false;

  X001OrderItemSelection({
    required this.customerId,
    required this.areaId,
    required this.os,
    required this.areaName,
    required this.type,
  });

  @override
  State<X001OrderItemSelection> createState() => _X001OrderItemSelectionState();
}

class _X001OrderItemSelectionState extends State<X001OrderItemSelection> {
  List<String> s = [];
  DateTime now = DateTime.now();
  CommonPopup orderpopup = CommonPopup();
  String? date;

  OrderBottomSheet cocosheet = OrderBottomSheet();
  double baseRate = 1.0;
  // String rate1 = "1";
  String? selected;
  String tempcode = "";
  double? temp;
  double? newqty = 0.0;
  TextEditingController searchcontroll = TextEditingController();
  ShowModal showModal = ShowModal();

  List<Map<String, dynamic>> products = [];
  SearchTile search = SearchTile();

  // CustomSnackbar snackbar = CustomSnackbar();

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
    Provider.of<Controller>(context, listen: false).selectSettings(
        "set_code in ('SL_RATE_EDIT','SL_TAX_CALC','SL_UPLOAD_DIRECT') ");
    Provider.of<Controller>(context, listen: false).getOrderno();
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    s = date!.split(" ");
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
                              .getBagDetails(widget.customerId, widget.os);

                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (_, __, ___) => CartList(
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
                            fontSize: 17,
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
                      onPressed: () {
                        print("hai");
                        if (value.bagList.length > 0) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                orderpopup.buildPopupDialog(
                              "sale order",
                              context,
                              "Confirm your order?",
                              widget.areaId,
                              widget.areaName,
                              widget.customerId,
                              s[0],
                              s[1],
                              "",
                              "",
                              "",
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Save',
                        style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          fontSize: 17,
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
                          if (value.bagList.length > 0) {
                            _discardAlert(context, widget.customerId);
                          }
                        },
                        child: Text(
                          "Discard",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            fontSize: 17,
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
          icon: Icon(Icons.arrow_back),
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
        backgroundColor: P_Settings.wavecolor,
        actions: <Widget>[],
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
                    onChanged: (value) {
                      Provider.of<Controller>(context, listen: false)
                          .setisVisible(true);
                      // Provider.of<Controller>(context, listen: false).isSearch=true;

                      // Provider.of<Controller>(context, listen: false)
                      //     .searchkey = value;

                      // Provider.of<Controller>(context, listen: false)
                      //     .searchProcess(widget.customerId, widget.os);
                      value = searchcontroll.text;
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
                                IconButton(
                                    icon: Icon(
                                      Icons.done,
                                      size: 20,
                                    ),
                                    onPressed: () async {
                                      // Provider.of<Controller>(context,
                                      //         listen: false)
                                      //     .getSaleProductList(
                                      //         widget.customerId);

                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getBagDetails(
                                              widget.customerId, widget.os);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .searchkey = searchcontroll.text;

                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .setIssearch(true);
                                      // print("hjdf----$list");

                                      Provider.of<Controller>(context,
                                                  listen: false)
                                              .filterCompany
                                          ? Provider.of<Controller>(context,
                                                  listen: false)
                                              .searchProcess_X001(
                                                  widget.customerId,
                                                  widget.os,
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .filteredeValue!,
                                                  "sale order",
                                                  value.orderitemList2,
                                                  "sale order",context)
                                          : Provider.of<Controller>(context,
                                                  listen: false)
                                              .searchProcess_X001(
                                                  widget.customerId,
                                                  widget.os,
                                                  "",
                                                  "sale order",
                                                  value.orderitemList2,
                                                  "sale order",context);
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .fromOrderbagTable_X001(
                                              widget.customerId, "sale order");
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .setIssearch(false);

                                      value.setisVisible(false);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .newList
                                          .clear();

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
              value.isLoading
                  ? Container(
                      child: CircularProgressIndicator(
                      color: P_Settings.wavecolor,
                    ))
                  : value.orderitemList2.length == 0
                      ? _isLoading
                          ? CircularProgressIndicator()
                          : Container(
                              height: size.height * 0.6,
                              child: Text(
                                "No Products !!!",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                      : Expanded(
                          child: value.isSearch
                              ? value.isListLoading
                                  ? Center(
                                      child: SpinKitCircle(
                                        color: P_Settings.orderFormcolor,
                                        size: 40,
                                      ),
                                    )
                                  : value.newList.length == 0
                                      ? Container(
                                          child: Text("No data Found!!!!"),
                                        )
                                      : ListView.builder(
                                          itemExtent: 60,
                                          shrinkWrap: true,
                                          itemCount: value.newList.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.4,
                                                  right: 0.4,
                                                  bottom: 0.2),
                                              child: Card(
                                                child: Ink(
                                                  // color: value.newList[index][
                                                  //                 "cartrowno"] ==
                                                  //             null ||
                                                  //         value.qty[index]
                                                  //                 .text ==
                                                  //             null ||
                                                  //         value.qty[index].text
                                                  //             .isEmpty
                                                  //     ? value.selected[index]
                                                  //         ? Color.fromARGB(255,
                                                  //             226, 225, 225)
                                                  //         : Colors.white
                                                  //     : Color.fromARGB(
                                                  //         255, 226, 225, 225),
                                                  child: ListTile(
                                                    onTap: () async {
                                                      print("clickedddd---");
                                                      Provider.of<Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .product_code =
                                                          value.newList[index]
                                                              ["prcode"];

                                                      // Provider.of<Controller>(
                                                      //         context,
                                                      //         listen: false)
                                                      //     .fetchProductUnits(
                                                      //         value.salesitemList2[
                                                      //                 index]
                                                      //             ["prid"]);
                                                      await Provider.of<
                                                                  Controller>(
                                                              context,
                                                              listen: false)
                                                          .fromOrderListData_X001(
                                                              widget.customerId,
                                                              value
                                                                  .product_code!,
                                                              index);
                                                      value.selectedunit_X001 =
                                                          null;
                                                      print(
                                                          "item name...${value.orderitemListdata2[0]['item']}");
                                                      if (value.isLoading) {
                                                        CircularProgressIndicator();
                                                      } else {
                                                        print(
                                                            "kjdjfkj-${value.orderitemListdata2[0]['code']}----${value.orderitemListdata2[0]['item']}---${value.orderitemListdata2[0]['rate1']}---}");
                                                        // value.selectedItem =
                                                        //     null;
                                                        value.selectedunit_X001 =
                                                            null;
                                                        value.gross = 0.00;
                                                        value.net_amt = 0.00;

                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .setUnitOrder_X001(
                                                                value
                                                                    .frstDropDown!,
                                                                index);
                                                        value.selectedItem =
                                                            value.frstDropDown;

                                                        value.qty[index].text =
                                                            "1.0";
                                                        // Provider.of<Controller>(
                                                        //         context,
                                                        //         listen: false)
                                                        //     .calculateOrderNetAmount(
                                                        //   index,
                                                        //   double.parse(value
                                                        //       .orderrate_X001[
                                                        //           index]
                                                        //       .text),
                                                        //   double.parse(value
                                                        //       .qty[index].text),
                                                        // );
                                                        cocosheet
                                                            .showorderMoadlBottomsheet(
                                                          value.orderitemListdata2[
                                                              0]['item'],
                                                          value.orderitemListdata2[
                                                              0]['code'],
                                                          double.parse(value
                                                                  .orderitemListdata2[
                                                              0]['rate1']),
                                                          0.00,
                                                          context,
                                                          size,
                                                          index,
                                                          widget.customerId,
                                                          widget.os,
                                                          s[0],
                                                          s[1],
                                                        );
                                                      }
                                                    },
                                                    dense: true,
                                                    title: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                          flex: 5,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${value.newList[index]["pritem"]}' +
                                                                    '- ' +
                                                                    '${value.newList[index]["prcode"]}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold),
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
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.012),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                              : value.filterCompany
                                  ? FilteredProduct(
                                      type: widget.type,
                                      customerId: widget.customerId,
                                      os: widget.os,
                                      s: s,
                                      value: Provider.of<Controller>(context,
                                              listen: false)
                                          .filteredeValue,
                                    )
                                  : value.isLoading
                                      ? CircularProgressIndicator()
                                      : ListView.builder(
                                          itemExtent: 60,
                                          shrinkWrap: true,
                                          itemCount:
                                              value.orderitemList2.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.4,
                                                  right: 0.4,
                                                  bottom: 0.2),
                                              child: Card(
                                                child: Ink(
                                                  // color: value.salesitemList2[
                                                  //                 index]
                                                  //             ["cartrowno"] ==
                                                  //         null
                                                  //     ? value.selected[index]
                                                  //         ? Color.fromARGB(255,
                                                  //             226, 225, 225)
                                                  //         : Colors.white
                                                  //     : Color.fromARGB(
                                                  //         255, 226, 225, 225),
                                                  child: ListTile(
                                                    onTap: () async {
                                                      Provider.of<Controller>(
                                                                  context,
                                                                  listen: false)
                                                              .product_code =
                                                          value.orderitemList2[
                                                              index]["prcode"];

                                                      // Provider.of<Controller>(
                                                      //         context,
                                                      //         listen: false)
                                                      //     .fetchProductUnits(
                                                      //         value.salesitemList2[
                                                      //                 index]
                                                      //             ["prid"]);
                                                      await Provider.of<
                                                                  Controller>(
                                                              context,
                                                              listen: false)
                                                          .fromOrderListData_X001(
                                                              widget.customerId,
                                                              value
                                                                  .product_code!,
                                                              index);
                                                      value.selectedunit_X001 =
                                                          null;
                                                      print(
                                                          "item name...${value.orderitemListdata2[0]['item']}");
                                                      if (value.isLoading) {
                                                        CircularProgressIndicator();
                                                      } else {
                                                        print(
                                                            "kjdjfkj-${value.orderitemListdata2[0]['code']}----${value.orderitemListdata2[0]['item']}---${value.orderitemListdata2[0]['rate1']}---}");
                                                        // value.selectedItem =
                                                        //     null;
                                                        value.gross = 0.00;
                                                        value.net_amt = 0.00;

                                                        // value.qty[index]
                                                        //     .clear();
                                                        // value.orderrate_X001[
                                                        //         index]
                                                        //     .clear();
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .setUnitOrder_X001(
                                                                value
                                                                    .frstDropDown!,
                                                                index);
                                                        value.selectedItem =
                                                            value.frstDropDown;

                                                        value.qty[index].text =
                                                            "1.0 ";
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .calculateOrderNetAmount(
                                                          index,
                                                          double.parse(value
                                                              .orderrate_X001[
                                                                  index]
                                                              .text),
                                                          double.parse(value
                                                              .qty[index].text),
                                                        );
                                                        cocosheet
                                                            .showorderMoadlBottomsheet(
                                                          value.orderitemListdata2[
                                                              0]['item'],
                                                          value.orderitemListdata2[
                                                              0]['code'],
                                                          double.parse(value
                                                                  .orderitemListdata2[
                                                              0]['rate1']),
                                                          0.00,
                                                          context,
                                                          size,
                                                          index,
                                                          widget.customerId,
                                                          widget.os,
                                                          s[0],
                                                          s[1],
                                                        );
                                                      }
                                                    },
                                                    dense: true,
                                                    title: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                          flex: 5,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${value.orderitemList2[index]["pritem"]}' +
                                                                    '- ' +
                                                                    '${value.orderitemList2[index]["prcode"]}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    // color: value.salesitemList2[index]
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
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                              // value.orderitemList2[
                                                              //                 index]
                                                              //             [
                                                              //             "qty"] ==
                                                              //         null
                                                              //     ? Container()
                                                              //     : Text(
                                                              //         "${value.orderitemList2[index]["qty"]}",
                                                              //         style: TextStyle(
                                                              //             fontSize:
                                                              //                 18,
                                                              //             fontWeight: FontWeight
                                                              //                 .bold,
                                                              //             color:
                                                              //                 P_Settings.wavecolor),
                                                              //       )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.012),
                                                      ],
                                                    ),
                                                  ),
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
                  "orderBagTable", "customerid='${customerId}'");
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
