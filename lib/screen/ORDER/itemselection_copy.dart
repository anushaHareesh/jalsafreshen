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
import 'package:badges/badges.dart';
import 'package:salesapp/screen/ORDER/8_cartList.dart';
import 'package:salesapp/screen/ORDER/filterProduct.dart';
import 'package:provider/provider.dart';

class ItemSelection extends StatefulWidget {
  // List<Map<String,dynamic>>  products;
  String customerId;
  String os;
  String areaId;
  String areaName;
  String type;
  bool _isLoading = false;

  ItemSelection(
      {required this.customerId,
      required this.areaId,
      required this.os,
      required this.areaName,
      required this.type});

  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  double rate1 = 0.0;
  // double baseRate = 1.0;

  TextEditingController searchcontroll = TextEditingController();
  ShowModal showModal = ShowModal();
  List<Map<String, dynamic>> products = [];
  SearchTile search = SearchTile();
  DateTime now = DateTime.now();
  List<String> s = [];
  String? date;
  bool loading = true;
  double? temp;
  bool loading1 = false;
  CustomSnackbar snackbar = CustomSnackbar();
  bool _isLoading = false;
  double? newqty = 0.0;
  @override
  void dispose() {
    super.dispose();
    searchcontroll.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.os===${widget.os}");
    print("areaId---${widget.customerId}");
    products = Provider.of<Controller>(context, listen: false).productName;
    print("products---${products}");

    Provider.of<Controller>(context, listen: false).getOrderno();
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    s = date!.split(" ");
    // Provider.of<Controller>(context, listen: false)
    //     .getProductList(widget.customerId);
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
        backgroundColor: P_Settings.wavecolor,
        actions: [
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
                  // String oos = "O" + "${widget.os}";

                  if (widget.customerId == null || widget.customerId.isEmpty) {
                  } else {
                    FocusManager.instance.primaryFocus?.unfocus();

                    Provider.of<Controller>(context, listen: false)
                        .selectSettings(
                            "set_code in('SO_RATE_EDIT','SO_UPLOAD_DIRECT')");
                    Provider.of<Controller>(context, listen: false)
                        .getBagDetails(widget.customerId, widget.os);

                    // await OrderAppDB.instance.selectAllcommon(
                    //     'settingsTable', "set_code='SO_RATE_EDIT'");

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
          //   position: BadgePosition(start: 33, bottom: 25),
          //   child: IconButton(
          //     onPressed: () async {
          //       // String oos = "O" + "${widget.os}";

          //       if (widget.customerId == null || widget.customerId.isEmpty) {
          //       } else {
          //         FocusManager.instance.primaryFocus?.unfocus();

          //         Provider.of<Controller>(context, listen: false)
          //             .selectSettings(
          //                 "set_code in('SO_RATE_EDIT','SO_UPLOAD_DIRECT')");
          //         Provider.of<Controller>(context, listen: false)
          //             .getBagDetails(widget.customerId, widget.os);

          //         // await OrderAppDB.instance.selectAllcommon(
          //         //     'settingsTable', "set_code='SO_RATE_EDIT'");

          //         Navigator.of(context).push(
          //           PageRouteBuilder(
          //             opaque: false, // set to false
          //             pageBuilder: (_, __, ___) => CartList(
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
          const SizedBox(
            width: 3.0,
          ),
          Consumer<Controller>(
            builder: (context, _value, child) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  Provider.of<Controller>(context, listen: false)
                      .filteredeValue = value;

                  if (value == "0") {
                    setState(() {
                      Provider.of<Controller>(context, listen: false)
                          .filterCompany = false;
                    });

                    Provider.of<Controller>(context, listen: false)
                        .filteredProductList
                        .clear();
                    Provider.of<Controller>(context, listen: false)
                        .getProductList(widget.customerId);
                  } else {
                    print("value---$value");
                    Provider.of<Controller>(context, listen: false)
                        .filterCompany = true;
                    Provider.of<Controller>(context, listen: false)
                        .filterwithCompany(
                            widget.customerId, value, "sale order");
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
          // Provider.of<Controller>(context, listen: false)
          //     .getProductList(widget.customerId);
          print("value.returnirtemExists------${value.returnirtemExists}");
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
                  child: TextField(
                    controller: searchcontroll,
                    onChanged: (value) {
                      Provider.of<Controller>(context, listen: false)
                          .setisVisible(true);
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
                                      // String oos="O"+"${widget.os}";
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .searchkey = searchcontroll.text;
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .setIssearch(true);
                                      Provider.of<Controller>(context,
                                                  listen: false)
                                              .filterCompany
                                          ? Provider.of<Controller>(context,
                                                  listen: false)
                                              .searchProcess(
                                                  widget.customerId,
                                                  widget.os,
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .filteredeValue!,
                                                  "sale order",
                                                  value.productName,context)
                                          : Provider.of<Controller>(context,
                                                  listen: false)
                                              .searchProcess(
                                                  widget.customerId,
                                                  widget.os,
                                                  "",
                                                  "sale order",
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
                                          .getProductList(widget.customerId);

                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .setIssearch(false);

                                      value.setisVisible(false);
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .newList
                                          .clear();
                                      searchcontroll.clear();
                                      print(
                                          "rtsyt----${Provider.of<Controller>(context, listen: false).returnirtemExists}");
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
                          color: widget.type == "sale order"
                              ? P_Settings.wavecolor
                              : P_Settings.returnbuttnColor))
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
                                        color: widget.type == "sale order"
                                            ? P_Settings.wavecolor
                                            : P_Settings.returnbuttnColor,
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
                                                          child: Text(
                                                            '${value.newList[index]["prcode"]}' +
                                                                '-' +
                                                                '${value.newList[index]["pritem"]}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: value.newList[index]
                                                                            [
                                                                            "cartrowno"] ==
                                                                        null
                                                                    ? value.selected[
                                                                            index]
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .black
                                                                    : Colors
                                                                        .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.012),
                                                        Row(
                                                          children: [
                                                            value.newList[index]
                                                                        [
                                                                        "prunit"] ==
                                                                    null
                                                                ? Container()
                                                                : Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      value.qty[index].text == "0" ||
                                                                              value.qty[index].text ==
                                                                                  null
                                                                          ? Container()
                                                                          : BlinkText(
                                                                              '${value.qty[index].text}',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color.fromARGB(255, 25, 66, 26),
                                                                                fontStyle: FontStyle.italic,
                                                                              ),
                                                                              endColor: Colors.white,
                                                                              duration: Duration(milliseconds: 2000)),
                                                                      SizedBox(
                                                                        width: size.width *
                                                                            0.03,
                                                                      ),
                                                                      Container(
                                                                          child:
                                                                              Text(
                                                                        value.newList[index]["prunit"] ==
                                                                                null
                                                                            ? " "
                                                                            : value.newList[index]["prunit"].toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                P_Settings.unitcolor,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15),
                                                                      )),
                                                                      SizedBox(
                                                                        width: size.width *
                                                                            0.02,
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          ' / ${value.newList[index]["pkg"]}',
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Wrap(
                                                      spacing: 0,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                '  \u{20B9}${value.newList[index]["prrate1"]}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          25,
                                                                          55,
                                                                          185),
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            IconButton(
                                                              icon: Icon(
                                                                Icons.add,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                double qty;

                                                                if (value
                                                                        .qty[
                                                                            index]
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
                                                                      newqty! +
                                                                          1;
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
                                                                print(
                                                                    "tttt----${value.qty[index].text}");
                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .selectSettings(
                                                                        "set_code in('SO_RATE_EDIT','SO_UPLOAD_DIRECT')");
                                                                String oos = "O" +
                                                                    "${value.ordernum[0]["os"]}";

                                                                setState(() {
                                                                  if (value.selected[
                                                                          index] ==
                                                                      false) {
                                                                    value.selected[
                                                                        index] = !value
                                                                            .selected[
                                                                        index];
                                                                    // selected = index;
                                                                  }

                                                                  if (value.qty[index].text ==
                                                                          null ||
                                                                      value
                                                                          .qty[
                                                                              index]
                                                                          .text
                                                                          .isEmpty) {
                                                                    value
                                                                        .qty[
                                                                            index]
                                                                        .text = "1";
                                                                  }
                                                                });
                                                                if (widget
                                                                        .type ==
                                                                    "sale order") {
                                                                  int max = await OrderAppDB
                                                                      .instance
                                                                      .getMaxCommonQuery(
                                                                          'orderBagTable',
                                                                          'cartrowno',
                                                                          "os='${oos}' AND customerid='${widget.customerId}'");

                                                                  print(
                                                                      "max----$max");
                                                                  // print("value.qty[index].text---${value.qty[index].text}");

                                                                  rate1 = value
                                                                              .newList[
                                                                          index]
                                                                      [
                                                                      "prrate1"];
                                                                  var total = rate1 *
                                                                      double.parse(value
                                                                          .qty[
                                                                              index]
                                                                          .text);
                                                                  print(
                                                                      "total rate $total");

                                                                  var res = await OrderAppDB.instance.insertorderBagTable(
                                                                      value.newList[index]
                                                                          [
                                                                          "pritem"],
                                                                      s[0],
                                                                      s[1],
                                                                      oos,
                                                                      widget
                                                                          .customerId,
                                                                      max,
                                                                      value.newList[index]
                                                                          [
                                                                          "prcode"],
                                                                      double.parse(value
                                                                          .qty[
                                                                              index]
                                                                          .text),
                                                                      rate1
                                                                          .toString(),
                                                                      total
                                                                          .toString(),
                                                                      1,
                                                                      value.newList[index]
                                                                          [
                                                                          "prunit"],
                                                                      value
                                                                          .newList[
                                                                              index]
                                                                              ["pkg"]
                                                                          .toDouble(),
                                                                      rate1,
                                                                      0);
                                                                  snackbar.showSnackbar(
                                                                      context,
                                                                      "${value.newList[index]["prcode"] + "-" + (value.newList[index]['pritem'])} - Added to cart",
                                                                      "sale order");
                                                                  Provider.of<Controller>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .countFromTable(
                                                                    "orderBagTable",
                                                                    oos,
                                                                    widget
                                                                        .customerId,
                                                                  );
                                                                }

                                                                /////////////////////////
                                                                (widget.customerId.isNotEmpty ||
                                                                            widget.customerId !=
                                                                                null) &&
                                                                        (value.newList[index]["prcode"].isNotEmpty ||
                                                                            value.newList[index]["prcode"] !=
                                                                                null)
                                                                    ? Provider.of<Controller>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .calculateorderTotal(
                                                                            oos,
                                                                            widget
                                                                                .customerId)
                                                                    : Text(
                                                                        "No data");

                                                                // Provider.of<Controller>(context,
                                                                //         listen: false)
                                                                //     .getProductList(
                                                                //         widget.customerId);
                                                              },
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            IconButton(
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  size: 18,
                                                                  // color: Colors.redAccent,
                                                                ),
                                                                onPressed: value.newList[index]
                                                                            [
                                                                            "cartrowno"] ==
                                                                        null
                                                                    ? value.selected[
                                                                            index]
                                                                        ? () async {
                                                                            String
                                                                                oos =
                                                                                "O" + "${value.ordernum[0]["os"]}";

                                                                            String
                                                                                item =
                                                                                value.newList[index]["prcode"] + value.newList[index]["pritem"];

                                                                            showModal.showMoadlBottomsheet(
                                                                                oos,
                                                                                widget.customerId,
                                                                                item,
                                                                                size,
                                                                                context,
                                                                                "newlist just added",
                                                                                value.newList[index]["prcode"],
                                                                                index,
                                                                                "no filter",
                                                                                "",
                                                                                value.qty[index],
                                                                                "sale order");
                                                                          }
                                                                        : null
                                                                    : () async {
                                                                        String
                                                                            oos =
                                                                            "O" +
                                                                                "${value.ordernum[0]["os"]}";

                                                                        String
                                                                            item =
                                                                            value.newList[index]["prcode"] +
                                                                                value.newList[index]["pritem"];

                                                                        showModal.showMoadlBottomsheet(
                                                                            oos,
                                                                            widget.customerId,
                                                                            item,
                                                                            size,
                                                                            context,
                                                                            "newlist already in cart",
                                                                            value.newList[index]["prcode"],
                                                                            index,
                                                                            "no filter",
                                                                            "",
                                                                            value.qty[index],
                                                                            "sale order");
                                                                      })
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                              : value.filterCompany
                                  ? FilteredProduct(
                                      type: widget.type,
                                      customerId: widget.customerId,
                                      os: widget.os,
                                      s: s,
                                      value: Provider.of<Controller>(context,
                                              listen: false)
                                          .filteredeValue)
                                  : value.isLoading
                                      ? CircularProgressIndicator()
                                      : ListView.builder(
                                          itemExtent: 60,
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
                                                          child: Text(
                                                            '${value.productName[index]["prcode"]}' +
                                                                '-' +
                                                                '${value.productName[index]["pritem"]}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: value.productName[index]
                                                                            [
                                                                            "cartrowno"] ==
                                                                        null
                                                                    ? value.selected[
                                                                            index]
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .black
                                                                    : Colors
                                                                        .black,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.012),
                                                        Row(
                                                          children: [
                                                            value.productName[
                                                                            index]
                                                                        [
                                                                        "prunit"] ==
                                                                    null
                                                                ? Container()
                                                                : Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      value.qty[index].text == "0" ||
                                                                              value.qty[index].text ==
                                                                                  null
                                                                          ? Container()
                                                                          : BlinkText(
                                                                              '${value.qty[index].text}',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color.fromARGB(255, 25, 66, 26),
                                                                                fontStyle: FontStyle.italic,
                                                                              ),
                                                                              endColor: Colors.white,
                                                                              duration: Duration(milliseconds: 2000)),
                                                                      SizedBox(
                                                                        width: size.width *
                                                                            0.03,
                                                                      ),
                                                                      Container(
                                                                          child:
                                                                              Text(
                                                                        value.productName[index]["prunit"] ==
                                                                                null
                                                                            ? " "
                                                                            : value.productName[index]["prunit"].toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                P_Settings.unitcolor,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 15),
                                                                      )),
                                                                      SizedBox(
                                                                        width: size.width *
                                                                            0.02,
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          ' / ${value.productName[index]["pkg"]}',
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Wrap(
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                '  \u{20B9}${value.productName[index]["prrate1"]}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          25,
                                                                          55,
                                                                          185),
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            IconButton(
                                                              icon: Icon(
                                                                Icons.add,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                double qty;

                                                                print(
                                                                    "value.qty--${value..qty[index].text}");
                                                                if (value
                                                                        .qty[
                                                                            index]
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
                                                                      newqty! +
                                                                          1;
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
                                                                print(
                                                                    "temp    tttt--$temp--${value.qty[index].text}");
                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .selectSettings(
                                                                        "set_code in('SO_RATE_EDIT','SO_UPLOAD_DIRECT')");
                                                                String oos = "O" +
                                                                    "${value.ordernum[0]["os"]}";

                                                                setState(() {
                                                                  if (value.selected[
                                                                          index] ==
                                                                      false) {
                                                                    value.selected[
                                                                        index] = !value
                                                                            .selected[
                                                                        index];
                                                                    // selected = index;
                                                                  }

                                                                  // if (value.qty[index]
                                                                  //             .text ==
                                                                  //         null ||
                                                                  //     value
                                                                  //         .qty[index]
                                                                  //         .text
                                                                  //         .isEmpty) {
                                                                  //   value.qty[index]
                                                                  //       .text = "1";
                                                                  // }
                                                                });
                                                                if (widget
                                                                        .type ==
                                                                    "sale order") {
                                                                  int max = await OrderAppDB
                                                                      .instance
                                                                      .getMaxCommonQuery(
                                                                          'orderBagTable',
                                                                          'cartrowno',
                                                                          "os='${oos}' AND customerid='${widget.customerId}'");

                                                                  print(
                                                                      "max----$max");
                                                                  print(
                                                                      "value.qty[index].text---${value.productName[index]["prrate1"].runtimeType}--------${value.productName[index]["pkg"].runtimeType}");

                                                                  rate1 = value
                                                                      .productName[
                                                                          index]
                                                                          [
                                                                          "prrate1"]
                                                                      .toDouble();
                                                                  var total = rate1 *
                                                                      double.parse(value
                                                                          .qty[
                                                                              index]
                                                                          .text);
                                                                  print(
                                                                      "total rate $total");

                                                                  var res = await OrderAppDB.instance.insertorderBagTable(
                                                                      value.productName[index]
                                                                          [
                                                                          "pritem"],
                                                                      s[0],
                                                                      s[1],
                                                                      oos,
                                                                      widget
                                                                          .customerId,
                                                                      max,
                                                                      value.productName[index]
                                                                          [
                                                                          "prcode"],
                                                                      double.parse(value
                                                                          .qty[
                                                                              index]
                                                                          .text),
                                                                      rate1
                                                                          .toString(),
                                                                      total
                                                                          .toString(),
                                                                      1,
                                                                      value.productName[index]
                                                                          [
                                                                          "prunit"],
                                                                      value
                                                                          .productName[
                                                                              index]
                                                                              ["pkg"]
                                                                          .toDouble(),
                                                                      rate1,
                                                                      0);
                                                                  snackbar.showSnackbar(
                                                                      context,
                                                                      "${value.productName[index]["prcode"] + "-" + (value.productName[index]['pritem'])} - Added to cart",
                                                                      "sale order");
                                                                  Provider.of<Controller>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .countFromTable(
                                                                    "orderBagTable",
                                                                    oos,
                                                                    widget
                                                                        .customerId,
                                                                  );
                                                                }

                                                                /////////////////////////
                                                                (widget.customerId.isNotEmpty ||
                                                                            widget.customerId !=
                                                                                null) &&
                                                                        (products[index]["prcode"].isNotEmpty ||
                                                                            products[index]["prcode"] !=
                                                                                null)
                                                                    ? Provider.of<Controller>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .calculateorderTotal(
                                                                            oos,
                                                                            widget
                                                                                .customerId)
                                                                    : Text(
                                                                        "No data");

                                                                // Provider.of<Controller>(context,
                                                                //         listen: false)
                                                                //     .getProductList(
                                                                //         widget.customerId);
                                                              },
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            IconButton(
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  size: 18,
                                                                  // color: Colors.redAccent,
                                                                ),
                                                                onPressed: value.productName[index]
                                                                            [
                                                                            "cartrowno"] ==
                                                                        null
                                                                    ? value.selected[
                                                                            index]
                                                                        ? () async {
                                                                            String
                                                                                oos =
                                                                                "O" + "${value.ordernum[0]["os"]}";

                                                                            String
                                                                                item =
                                                                                value.productName[index]["prcode"] + value.productName[index]["pritem"];

                                                                            showModal.showMoadlBottomsheet(
                                                                                oos,
                                                                                widget.customerId,
                                                                                item,
                                                                                size,
                                                                                context,
                                                                                "just added",
                                                                                value.productName[index]["prcode"],
                                                                                index,
                                                                                "no filter",
                                                                                "",
                                                                                value.qty[index],
                                                                                "sale order");
                                                                          }
                                                                        : null
                                                                    : () async {
                                                                        String
                                                                            oos =
                                                                            "O" +
                                                                                "${value.ordernum[0]["os"]}";

                                                                        String
                                                                            item =
                                                                            value.productName[index]["prcode"] +
                                                                                value.productName[index]["pritem"];

                                                                        showModal.showMoadlBottomsheet(
                                                                            oos,
                                                                            widget.customerId,
                                                                            item,
                                                                            size,
                                                                            context,
                                                                            "already in cart",
                                                                            value.productName[index]["prcode"],
                                                                            index,
                                                                            "no filter",
                                                                            "",
                                                                            value.qty[index],
                                                                            "sale order");
                                                                      })
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                        ),
            ],
          );
        },
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////
}
