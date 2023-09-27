import 'package:badges/badges.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customSearchTile.dart';
import 'package:salesapp/components/customSnackbar.dart';
import 'package:salesapp/components/showMoadal.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:salesapp/screen/RETURN/returnFilteredProductList.dart';
import 'package:salesapp/screen/RETURN/return_cart.dart';

import 'package:provider/provider.dart';

class ReturnItem extends StatefulWidget {
  // List<Map<String,dynamic>>  products;
  String customerId;
  String os;
  String areaId;
  String areaName;
  String type;
  bool _isLoading = false;

  ReturnItem({
    required this.customerId,
    required this.areaId,
    required this.os,
    required this.areaName,
    required this.type,
  });

  @override
  State<ReturnItem> createState() => _ReturnItemState();
}

class _ReturnItemState extends State<ReturnItem> {
  String rate1 = "1";
  TextEditingController searchcontroll = TextEditingController();
  ShowModal showModal = ShowModal();
  double? newqty = 0.0;
  List<Map<String, dynamic>> products = [];
  SearchTile search = SearchTile();
  DateTime now = DateTime.now();
  double? temp;
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

    Provider.of<Controller>(context, listen: false).getOrderno();
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    s = date!.split(" ");
    // Provider.of<Controller>(context, listen: false)
    //     .getreturnList(widget.customerId);
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<Controller>(context, listen: false)
                .returnfilterCompany = false;
            Provider.of<Controller>(context, listen: false)
                .returnfilteredProductList
                .clear();
            Provider.of<Controller>(context, listen: false).searchkey = "";
            Provider.of<Controller>(context, listen: false).newList = products;
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: P_Settings.returnbuttnColor,
        actions: <Widget>[
          Stack(
            children: [
              Positioned(
                right: 3,
                child: Container(
                  // height: 20,
                  // width: 20,
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Center(
                    child: Consumer<Controller>(
                      builder: (context, value, child) {
                        if (value.count == null) {
                          return SpinKitChasingDots(
                              color: P_Settings.wavecolor, size: 9);
                        } else {
                          return Text(
                            "${value.count}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          );
                        }
                      },
                    ),
                    // child: Text(
                    //   value.deliveryListCount != null
                    //       ? value.deliveryListCount!
                    //       : "..",
                    //   style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (widget.customerId == null || widget.customerId.isEmpty) {
                  } else {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Provider.of<Controller>(context, listen: false)
                        .selectSettings("set_code in ('RT_UPLOAD_DIRECT')");

                    Provider.of<Controller>(context, listen: false)
                        .getreturnBagDetails(widget.customerId, widget.os);

                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false, // set to false
                        pageBuilder: (_, __, ___) => ReturnCart(
                          areaId: widget.areaId,
                          custmerId: widget.customerId,
                          os: widget.os,
                          areaname: widget.areaName,
                          type: widget.type,
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ],
          ),
          // Badge(
          //   animationType: BadgeAnimationType.scale,
          //   toAnimate: true,
          //   badgeColor: Colors.white,
          //   badgeContent: Consumer<Controller>(
          //     builder: (context, value, child) {
          //       if (value.count == null) {
          //         return SpinKitChasingDots(
          //             color: P_Settings.wavecolor, size: 9);
          //       } else {
          //         return Text(
          //           "${value.count}",
          //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          //         );
          //       }
          //     },
          //   ),
          //   position: const BadgePosition(start: 33, bottom: 25),
          //   child: IconButton(
          //     onPressed: () async {
          //       if (widget.customerId == null || widget.customerId.isEmpty) {
          //       } else {
          //         FocusManager.instance.primaryFocus?.unfocus();
          //         Provider.of<Controller>(context, listen: false)
          //             .selectSettings("set_code in ('RT_UPLOAD_DIRECT')");

          //         Provider.of<Controller>(context, listen: false)
          //             .getreturnBagDetails(widget.customerId, widget.os);

          //         Navigator.of(context).push(
          //           PageRouteBuilder(
          //             opaque: false, // set to false
          //             pageBuilder: (_, __, ___) => ReturnCart(
          //               areaId: widget.areaId,
          //               custmerId: widget.customerId,
          //               os: widget.os,
          //               areaname: widget.areaName,
          //               type: widget.type,
          //             ),
          //           ),
          //         );
          //       }
          //     },
          //     icon: const Icon(Icons.shopping_cart),
          //   ),
          // ),

          Consumer<Controller>(
            builder: (context, _value, child) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  //  Provider.of<Controller>(context, listen: false)
                  //     .filteredeValue = value;

                  // if (value == "0") {
                  //   setState(() {
                  //     Provider.of<Controller>(context, listen: false)
                  //         .filterCompany = false;
                  //   });

                  //   Provider.of<Controller>(context, listen: false)
                  //       .filteredProductList
                  //       .clear();
                  //   Provider.of<Controller>(context, listen: false)
                  //       .getProductList(widget.customerId);
                  // } else {
                  //   print("value---$value");
                  //   Provider.of<Controller>(context, listen: false)
                  //         .filterCompany = true;
                  //   Provider.of<Controller>(context, listen: false)
                  //       .filterwithCompany(widget.customerId, value,"sale order");
                  // }///////////////

                  Provider.of<Controller>(context, listen: false)
                      .returnfilteredeValue = value;
                  if (value == "0") {
                    setState(() {
                      Provider.of<Controller>(context, listen: false)
                          .returnfilterCompany = false;
                    });

                    Provider.of<Controller>(context, listen: false)
                        .returnfilteredProductList
                        .clear();
                    Provider.of<Controller>(context, listen: false)
                        .getreturnList(widget.customerId, "");
                  } else {
                    print("value---$value");
                    Provider.of<Controller>(context, listen: false)
                        .returnfilterCompany = true;
                    Provider.of<Controller>(context, listen: false)
                        .filterwithCompany(widget.customerId, value, "return");
                  }
                },
                itemBuilder: (context) => _value.productcompanyList
                    .map((item) => PopupMenuItem<String>(
                          value: item["comid"],
                          child: Text(
                            item["comanme"],
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     print("type return.........${widget.type}");
              //     Provider.of<Controller>(context, listen: false)
              //         .getreturnBagDetails(widget.customerId, widget.os);
              //     // Provider.of<Controller>(context, listen: false)
              //     //     .selectSettings();
              //     Navigator.of(context).push(
              //       PageRouteBuilder(
              //         opaque: false, // set to false
              //         pageBuilder: (_, __, ___) => ReturnCart(
              //           areaId: widget.areaId,
              //           custmerId: widget.customerId,
              //           os: widget.os,
              //           areaname: widget.areaName,
              //           type: widget.type,
              //         ),
              //       ),
              //     );
              //   },
              //   child: Container(
              //       alignment: Alignment.center,
              //       height: size.height * 0.045,
              //       width: size.width * 0.2,
              //       child: value.isLoading
              //           ? Center(
              //               child: SpinKitThreeBounce(
              //               color: P_Settings.returnbuttnColor,
              //               size: 15,
              //             ))
              //           : Text(
              //               "${value.count}",
              //               style: TextStyle(
              //                   fontSize: 19, fontWeight: FontWeight.bold),
              //             ),
              //       decoration: BoxDecoration(
              //         color: P_Settings.returncountColor,
              //         borderRadius: BorderRadius.only(
              //           bottomLeft: Radius.circular(50),
              //           bottomRight: Radius.circular(50),
              //         ),
              //       )),
              // ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: size.width * 0.95,
                  height: size.height * 0.09,
                  child: TextField(
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
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getreturnBagDetails(
                                              widget.customerId, widget.os);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .searchkey = searchcontroll.text;
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .setIssearch(true);
                                      Provider.of<Controller>(context,
                                                  listen: false)
                                              .returnfilterCompany
                                          ? Provider.of<Controller>(context,
                                                  listen: false)
                                              .searchProcess(
                                                  widget.customerId,
                                                  widget.os,
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .salefilteredeValue!,
                                                  "return",
                                                  value.productName,context)
                                          : Provider.of<Controller>(context,
                                                  listen: false)
                                              .searchProcess(
                                                  widget.customerId,
                                                  widget.os,
                                                  "",
                                                  "return",
                                                  value.productName,context);
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getreturnList(widget.customerId, "");
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
                      color: P_Settings.returnbuttnColor,
                    ))
                  : value.prodctItems.length == 0
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
                                        color: P_Settings.salewaveColor,
                                        size: 40,
                                      ),
                                    )
                                  : value.newList.length == 0
                                      ? Container(
                                          child: Text("No data Found!!!!"),
                                        )
                                      : ListView.builder(
                                          itemExtent: 70,
                                          shrinkWrap: true,
                                          itemCount: value.newList.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.4, right: 0.4),
                                              child: Card(
                                                child: Ink(
                                                  color: value.newList[index][
                                                                  "cartrowno"] ==
                                                              null ||
                                                          value.qty[index]
                                                                  .text ==
                                                              null ||
                                                          value.qty[index].text
                                                              .isEmpty
                                                      ? value.selected[index]
                                                          ? Color.fromARGB(255,
                                                              226, 225, 225)
                                                          : Colors.white
                                                      : Color.fromARGB(
                                                          255, 226, 225, 225),
                                                  child: ListTile(
                                                    dense: true,
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${value.newList[index]["prcode"]}' +
                                                              '-' +
                                                              '${value.newList[index]["pritem"]}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              value.newList[index]
                                                                          [
                                                                          "prunit"] ==
                                                                      null
                                                                  ? " "
                                                                  : value
                                                                      .newList[
                                                                          index]
                                                                          [
                                                                          "prunit"]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: P_Settings
                                                                      .unitcolor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            )),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.03,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                ' / ${value.newList[index]["pkg"]}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.05,
                                                            ),
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      0.06,
                                                              child: value.qty[index].text ==
                                                                          "0" ||
                                                                      value.qty[index].text ==
                                                                          null
                                                                  ? Container()
                                                                  : BlinkText(
                                                                      '${value.qty[index].text}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            25,
                                                                            66,
                                                                            26),
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                      ),
                                                                      endColor:
                                                                          Colors
                                                                              .white,
                                                                      duration:
                                                                          Duration(
                                                                              milliseconds: 2000)),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    // subtitle:
                                                    trailing: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          '\u{20B9}${value.newList[index]["prrate"]}',
                                                          style: TextStyle(
                                                              color: P_Settings
                                                                  .ratecolor,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.add,
                                                          ),
                                                          onPressed: () async {
                                                            double qty;

                                                            print(
                                                                "value.qty--${value..qty[index].text}");
                                                            if (value
                                                                    .qty[index]
                                                                    .text
                                                                    .isNotEmpty ||
                                                                value.qty[index]
                                                                        .text !=
                                                                    null) {
                                                              newqty = value
                                                                      .qty[
                                                                          index]
                                                                      .text
                                                                      .isEmpty
                                                                  ? 0
                                                                  : double.parse(value
                                                                      .qty[
                                                                          index]
                                                                      .text);
                                                              temp =
                                                                  newqty! + 1;
                                                              print(
                                                                  "temp--.........$newqty--${temp}");
                                                            } else {
                                                              newqty = 0.0;
                                                              temp = 0;
                                                              print(
                                                                  "temp--.........--${temp}");
                                                            }

                                                            value.qty[index]
                                                                    .text =
                                                                temp.toString();
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .selectSettings(
                                                                    "set_code in ('RT_UPLOAD_DIRECT')");
                                                            print("clicked--");

                                                            setState(() {
                                                              if (value.selected[
                                                                      index] ==
                                                                  false) {
                                                                value.selected[
                                                                        index] =
                                                                    !value.selected[
                                                                        index];
                                                                // selected = index;
                                                              }
                                                              print(
                                                                  "sdjszn-----${value.selected[index]}");
                                                              if (value
                                                                          .qty[
                                                                              index]
                                                                          .text ==
                                                                      null ||
                                                                  value
                                                                      .qty[
                                                                          index]
                                                                      .text
                                                                      .isEmpty) {
                                                                value.qty[index]
                                                                    .text = "1";
                                                              }
                                                            });

                                                            int max = await OrderAppDB
                                                                .instance
                                                                .getMaxCommonQuery(
                                                                    'returnBagTable',
                                                                    'cartrowno',
                                                                    "os='${widget.os}' AND customerid='${widget.customerId}'");

                                                            print(
                                                                "max----$max");
                                                            // print("value.qty[index].text---${value.qty[index].text}");

                                                            rate1 =
                                                                value.newList[
                                                                        index]
                                                                    ["prrate"];
                                                            var total = double
                                                                    .parse(
                                                                        rate1) *
                                                                double.parse(value
                                                                    .qty[index]
                                                                    .text);
                                                            print(
                                                                "total rate $total");

                                                            var res = await OrderAppDB.instance.insertreturnBagTable(
                                                                products[index]
                                                                    ["pritem"],
                                                                s[0],
                                                                s[1],
                                                                widget.os,
                                                                widget
                                                                    .customerId,
                                                                max,
                                                                products[index]
                                                                    ["prcode"],
                                                                double.parse(value
                                                                    .qty[index]
                                                                    .text),
                                                                rate1,
                                                                total
                                                                    .toString(),
                                                                0,
                                                                value.newList[
                                                                        index]
                                                                    ["prunit"],
                                                                value.newList[
                                                                        index]
                                                                        ["pkg"]
                                                                    .toDouble(),
                                                                double.parse(
                                                                    rate1),
                                                                0);

                                                            snackbar.showSnackbar(
                                                                context,
                                                                "${products[index]["prcode"] + products[index]['pritem']} - Added to cart",
                                                                "return");
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .countFromTable(
                                                              "returnBagTable",
                                                              widget.os,
                                                              widget.customerId,
                                                            );

                                                            /////////////////////////
                                                            print(
                                                                "customer idddddddd.......${products[index]["prcode"]}");
                                                            (widget.customerId.isNotEmpty ||
                                                                        widget.customerId !=
                                                                            null) &&
                                                                    (products[index]["prcode"]
                                                                            .isNotEmpty ||
                                                                        products[index]["prcode"] !=
                                                                            null)
                                                                ? Provider.of<
                                                                            Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .calculatereturnTotal(
                                                                        widget
                                                                            .os,
                                                                        widget
                                                                            .customerId)
                                                                : Text(
                                                                    "No data");
                                                          },
                                                          color: Colors.black,
                                                        ),
                                                        IconButton(
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              size: 18,
                                                              // color: Colors.redAccent,
                                                            ),
                                                            onPressed: value.newList[
                                                                            index]
                                                                        [
                                                                        "cartrowno"] ==
                                                                    null
                                                                ? value.selected[
                                                                        index]
                                                                    ? () async {
                                                                        String
                                                                            item =
                                                                            products[index]["prcode"] +
                                                                                products[index]["pritem"];
                                                                        showModal.showMoadlBottomsheet(
                                                                            widget.os,
                                                                            widget.customerId,
                                                                            item,
                                                                            size,
                                                                            context,
                                                                            "just added",
                                                                            products[index]["prcode"],
                                                                            index,
                                                                            "no filter",
                                                                            "",
                                                                            value.qty[index],
                                                                            "return");
                                                                      }
                                                                    : null
                                                                : () async {
                                                                    String item = products[index]
                                                                            [
                                                                            "prcode"] +
                                                                        products[index]
                                                                            [
                                                                            "pritem"];
                                                                    showModal.showMoadlBottomsheet(
                                                                        widget
                                                                            .os,
                                                                        widget
                                                                            .customerId,
                                                                        item,
                                                                        size,
                                                                        context,
                                                                        "already in cart",
                                                                        products[index]
                                                                            [
                                                                            "prcode"],
                                                                        index,
                                                                        "no filter",
                                                                        "",
                                                                        value.qty[
                                                                            index],
                                                                        "return");
                                                                  })
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                              : value.returnfilterCompany
                                  ? ReturnFilteredProduct(
                                      type: widget.type,
                                      customerId: widget.customerId,
                                      os: widget.os,
                                      s: s,
                                      value: Provider.of<Controller>(context,
                                              listen: false)
                                          .returnfilteredeValue,
                                    )
                                  : value.isLoading
                                      ? CircularProgressIndicator()
                                      : ListView.builder(
                                          itemExtent: 70,
                                          shrinkWrap: true,
                                          itemCount: value.productName.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.4, right: 0.4),
                                              child: Card(
                                                child: Ink(
                                                  color: value.productName[
                                                                      index][
                                                                  "cartrowno"] ==
                                                              null ||
                                                          value.qty[index]
                                                                  .text ==
                                                              null ||
                                                          value.qty[index].text
                                                              .isEmpty
                                                      ? value.selected[index]
                                                          ? Color.fromARGB(255,
                                                              226, 225, 225)
                                                          : Colors.white
                                                      : Color.fromARGB(
                                                          255, 226, 225, 225),
                                                  child: ListTile(
                                                    dense: true,
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${value.productName[index]["prcode"]}' +
                                                              '-' +
                                                              '${value.productName[index]["pritem"]}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                                child: Text(
                                                              value.productName[
                                                                              index]
                                                                          [
                                                                          "prunit"] ==
                                                                      null
                                                                  ? " "
                                                                  : value
                                                                      .productName[
                                                                          index]
                                                                          [
                                                                          "prunit"]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: P_Settings
                                                                      .unitcolor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            )),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.03,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                ' / ${value.productName[index]["pkg"]}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.05,
                                                            ),
                                                            Container(
                                                              width:
                                                                  size.width *
                                                                      0.06,
                                                              child: value.qty[index].text ==
                                                                          "0" ||
                                                                      value.qty[index].text ==
                                                                          null
                                                                  ? Container()
                                                                  : BlinkText(
                                                                      '${value.qty[index].text}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            25,
                                                                            66,
                                                                            26),
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                      ),
                                                                      endColor:
                                                                          Colors
                                                                              .white,
                                                                      duration:
                                                                          Duration(
                                                                              milliseconds: 2000)),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    // subtitle:
                                                    trailing: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          '\u{20B9}${value.productName[index]["prrate"]}',
                                                          style: TextStyle(
                                                              color: P_Settings
                                                                  .ratecolor,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.add,
                                                          ),
                                                          onPressed: () async {
                                                            double qty;

                                                            print(
                                                                "value.qty--${value..qty[index].text}");
                                                            if (value
                                                                    .qty[index]
                                                                    .text
                                                                    .isNotEmpty ||
                                                                value.qty[index]
                                                                        .text !=
                                                                    null) {
                                                              newqty = value
                                                                      .qty[
                                                                          index]
                                                                      .text
                                                                      .isEmpty
                                                                  ? 0
                                                                  : double.parse(value
                                                                      .qty[
                                                                          index]
                                                                      .text);
                                                              temp =
                                                                  newqty! + 1;
                                                              print(
                                                                  "temp--.........$newqty--${temp}");
                                                            } else {
                                                              newqty = 0.0;
                                                              temp = 0;
                                                              print(
                                                                  "temp--.........--${temp}");
                                                            }

                                                            value.qty[index]
                                                                    .text =
                                                                temp.toString();
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .selectSettings(
                                                                    "set_code in ('RT_UPLOAD_DIRECT')");
                                                            print("clicked--");

                                                            setState(() {
                                                              if (value.selected[
                                                                      index] ==
                                                                  false) {
                                                                value.selected[
                                                                        index] =
                                                                    !value.selected[
                                                                        index];
                                                                // selected = index;
                                                              }
                                                              print(
                                                                  "sdjszn-----${value.selected[index]}");
                                                              if (value
                                                                          .qty[
                                                                              index]
                                                                          .text ==
                                                                      null ||
                                                                  value
                                                                      .qty[
                                                                          index]
                                                                      .text
                                                                      .isEmpty) {
                                                                value.qty[index]
                                                                    .text = "1";
                                                              }
                                                            });

                                                            int max = await OrderAppDB
                                                                .instance
                                                                .getMaxCommonQuery(
                                                                    'returnBagTable',
                                                                    'cartrowno',
                                                                    "os='${widget.os}' AND customerid='${widget.customerId}'");

                                                            print(
                                                                "max----$max");
                                                            // print("value.qty[index].text---${value.qty[index].text}");

                                                            rate1 = value
                                                                    .productName[
                                                                index]["prrate"];
                                                            var total = double
                                                                    .parse(
                                                                        rate1) *
                                                                double.parse(value
                                                                    .qty[index]
                                                                    .text);
                                                            print(
                                                                "total rate $total");

                                                            var res = await OrderAppDB.instance.insertreturnBagTable(
                                                                products[index]
                                                                    ["pritem"],
                                                                s[0],
                                                                s[1],
                                                                widget.os,
                                                                widget
                                                                    .customerId,
                                                                max,
                                                                products[index]
                                                                    ["prcode"],
                                                                double.parse(value
                                                                    .qty[index]
                                                                    .text),
                                                                rate1,
                                                                total
                                                                    .toString(),
                                                                0,
                                                                value.productName[
                                                                        index]
                                                                    ["prunit"],
                                                                value
                                                                    .productName[
                                                                        index]
                                                                        ["pkg"]
                                                                    .toDouble(),
                                                                double.parse(
                                                                    rate1),
                                                                0);

                                                            snackbar.showSnackbar(
                                                                context,
                                                                "${products[index]["prcode"] + products[index]['pritem']} - Added to cart",
                                                                "return");
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .countFromTable(
                                                              "returnBagTable",
                                                              widget.os,
                                                              widget.customerId,
                                                            );

                                                            /////////////////////////
                                                            (widget.customerId.isNotEmpty ||
                                                                        widget.customerId !=
                                                                            null) &&
                                                                    (products[index]["prcode"]
                                                                            .isNotEmpty ||
                                                                        products[index]["prcode"] !=
                                                                            null)
                                                                ? Provider.of<
                                                                            Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .calculatereturnTotal(
                                                                        widget
                                                                            .os,
                                                                        widget
                                                                            .customerId)
                                                                : Text(
                                                                    "No data");
                                                          },
                                                          color: Colors.black,
                                                        ),
                                                        IconButton(
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              size: 18,
                                                              // color: Colors.redAccent,
                                                            ),
                                                            onPressed: value.productName[
                                                                            index]
                                                                        [
                                                                        "cartrowno"] ==
                                                                    null
                                                                ? value.selected[
                                                                        index]
                                                                    ? () async {
                                                                        String
                                                                            item =
                                                                            products[index]["prcode"] +
                                                                                products[index]["pritem"];
                                                                        showModal.showMoadlBottomsheet(
                                                                            widget.os,
                                                                            widget.customerId,
                                                                            item,
                                                                            size,
                                                                            context,
                                                                            "just added",
                                                                            products[index]["prcode"],
                                                                            index,
                                                                            "no filter",
                                                                            "",
                                                                            value.qty[index],
                                                                            "return");
                                                                      }
                                                                    : null
                                                                : () async {
                                                                    String item = products[index]
                                                                            [
                                                                            "prcode"] +
                                                                        products[index]
                                                                            [
                                                                            "pritem"];
                                                                    showModal.showMoadlBottomsheet(
                                                                        widget
                                                                            .os,
                                                                        widget
                                                                            .customerId,
                                                                        item,
                                                                        size,
                                                                        context,
                                                                        "already in cart",
                                                                        products[index]
                                                                            [
                                                                            "prcode"],
                                                                        index,
                                                                        "no filter",
                                                                        "",
                                                                        value.qty[
                                                                            index],
                                                                        "return");
                                                                  })
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

  //////////////////////////////////////////////////////////////////////////////////
}
