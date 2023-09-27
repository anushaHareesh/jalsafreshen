import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:provider/provider.dart';

class OrderBottomSheet {
  List rawCalcResult = [];
  List splitted = [];
  // String? selected;
  ValueNotifier<bool> visible = ValueNotifier(false);
  showorderMoadlBottomsheet(
    String item,
    String code,
    double rate,
    double net_amt,
    BuildContext context,
    Size size,
    int index,
    String customerId,
    String os,
    String date,
    String time,
  ) async {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          print("param-----$item....$code....-$index--");

          return Consumer<Controller>(
            builder: (context, value, child) {
              return SingleChildScrollView(
                child: Container(
                  // height: size.height * 0.96,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: value.isLoading
                        ? SpinKitFadingCircle(
                            color: P_Settings.wavecolor,
                          )
                        : Column(
                            // mainAxisSize:MainAxisSize.min ,
                            // spacing: 5,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: P_Settings.extracolor,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: P_Settings.wavecolor,
                                        ),
                                      ),
                                      Text("-"),
                                      Text(
                                        code,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Divider(
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Unit",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Text("Pkg : ${value.package}"),
                                    // Spacer(),

                                    value.prNullvalue
                                        ? Container()
                                        : dropDownUnit(size, index)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Package",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Spacer(),
                                    Text(
                                      "${value.package}",
                                      // value.fromDb!
                                      //     ? "\u{20B9}gross.toStringAsFixed(2)"
                                      //     : "\u{20B9}${value.gross.toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Qty",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Spacer(),
                                    // Text(
                                    //   qty.toString(),
                                    //   style: TextStyle(fontSize: 15),
                                    // ),
                                    Row(
                                      children: [
                                        FloatingActionButton.small(
                                          child: Icon(
                                            Icons.add,
                                            color: P_Settings.wavecolor,
                                          ),
                                          backgroundColor: Colors.white,
                                          onPressed: () {
                                            double q = double.parse(
                                                value.qty[index].text);
                                            q = q + 1;
                                            value.qty[index].text =
                                                q.toString();
                                            value.calculateOrderNetAmount(
                                                index,
                                                double.parse(value
                                                    .orderrate_X001[index]
                                                    .text),
                                                double.parse(
                                                    value.qty[index].text));
                                          },
                                        ),
                                        Container(
                                          width: size.width * 0.14,
                                          child: TextField(
                                            onTap: () {
                                              value.qty[index].selection =
                                                  TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset: value
                                                          .qty[index]
                                                          .value
                                                          .text
                                                          .length);
                                            },
                                            // autofocus: true,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.all(0),
                                              //border: InputBorder.none
                                            ),

                                            // maxLines: 1,
                                            // minLines: 1,
                                            keyboardType: TextInputType.number,
                                            onSubmitted: (values) {
                                              print("values----$values");
                                              double valueqty = 0.0;
                                              // value.discount_amount[index].text=;
                                              if (values.isNotEmpty) {
                                                print("emtyyyy");
                                                valueqty = double.parse(values);
                                                value.calculateOrderNetAmount(
                                                    index,
                                                    double.parse(value
                                                        .orderrate_X001[index]
                                                        .text),
                                                    double.parse(
                                                        value.qty[index].text));
                                              } else {
                                                valueqty = 0.00;
                                              }
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .fromDb = false;

                                              print(
                                                  "settingsLits-------${value.settingsList1}");
                                              if (value.orderrate_X001[index]
                                                          .text !=
                                                      null &&
                                                  value.orderrate_X001[index]
                                                      .text.isNotEmpty) {}
                                            },
                                            textAlign: TextAlign.center,
                                            controller: value.qty[index],
                                          ),
                                        ),
                                        FloatingActionButton.small(
                                          child: Icon(
                                            Icons.remove,
                                            color: P_Settings.wavecolor,
                                          ),
                                          backgroundColor: Colors.white,
                                          onPressed: () {
                                            double q = double.parse(
                                                value.qty[index].text);
                                            q = q - 1;
                                            if (q >= 0) {
                                              value.qty[index].text =
                                                  q.toString();
                                              value.calculateOrderNetAmount(
                                                  index,
                                                  double.parse(value
                                                      .orderrate_X001[index]
                                                      .text),
                                                  double.parse(
                                                      value.qty[index].text));
                                            } else {
                                              // value.qty[index].text = "0";
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Provider.of<Controller>(context, listen: false)
                                          .settingsList1[0]["set_value"] ==
                                      "YES"
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15, bottom: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rate :",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Container(
                                            width: size.width * 0.2,
                                            child: TextField(
                                              onTap: () {
                                                value.orderrate_X001[index]
                                                        .selection =
                                                    TextSelection(
                                                        baseOffset: 0,
                                                        extentOffset: value
                                                            .orderrate_X001[
                                                                index]
                                                            .value
                                                            .text
                                                            .length);
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              onSubmitted: (values) {
                                                value.calculateOrderNetAmount(
                                                    index,
                                                    double.parse(value
                                                        .orderrate_X001[index]
                                                        .text),
                                                    double.parse(
                                                        value.qty[index].text));
                                              },
                                              textAlign: TextAlign.right,
                                              controller:
                                                  value.orderrate_X001[index],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rate :",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "\u{20B9}${rate}",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Gross value",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Spacer(),
                                    Text(
                                      "\u{20B9}${value.orderNetAmount.toStringAsFixed(2)}",
                                      // value.fromDb!
                                      //     ? "\u{20B9}gross.toStringAsFixed(2)"
                                      //     : "\u{20B9}${value.gross.toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Net Amount",
                                        style: TextStyle(
                                            color: P_Settings.extracolor,
                                            fontSize: 15),
                                      ),
                                      Spacer(),
                                      value.orderNetAmount < 0.00
                                          ? Text("\u{20B9}0.00",
                                              style: TextStyle(
                                                  color: P_Settings.extracolor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15))
                                          : Text(
                                              // value.fromDb!
                                              //     ? "\u{20B9}${net_amt.toStringAsFixed(2)}"
                                              //     :
                                              "\u{20B9}${value.orderNetAmount.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  color: P_Settings.extracolor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: size.width * 0.4,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: P_Settings.wavecolor,
                                            ),
                                            onPressed: () async {
                                              int indexCalc = index + 1;

                                              int max = await OrderAppDB
                                                  .instance
                                                  .getMaxCommonQuery(
                                                      'orderBagTable',
                                                      'cartrowno',
                                                      "os='${os}' AND customerid='${customerId}'");
                                              var pid =
                                                  value.orderitemList2[index]
                                                      ['prid'];
                                              if (value.qty[index].text !=
                                                      null &&
                                                  value.qty[index].text
                                                      .isNotEmpty) {
                                                double total = double.parse(
                                                        value
                                                            .orderrate_X001[
                                                                index]
                                                            .text) *
                                                    double.parse(
                                                        value.qty[index].text);

                                                double baseRate = double.parse(
                                                        value
                                                            .orderrate_X001[
                                                                index]
                                                            .text) /
                                                    value.package!;
                                                print("rateggg----$baseRate");

                                                await OrderAppDB.instance
                                                    .insertorderBagTable_X001(
                                                        item,
                                                        date,
                                                        time,
                                                        os,
                                                        customerId,
                                                        max,
                                                        code,
                                                        double.parse(value
                                                            .qty[index].text),
                                                        value
                                                            .orderrate_X001[
                                                                index]
                                                            .text,
                                                        total.toString(),
                                                        pid,
                                                        value.selectedItem,
                                                        value.package!,
                                                        baseRate,
                                                        0);
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "$item Inserted Successfully",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  textColor: Colors.white,
                                                  fontSize: 14.0,
                                                  backgroundColor: Colors.green,
                                                );
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .countFromTable(
                                                  "orderBagTable",
                                                  os,
                                                  customerId,
                                                );
                                              } else {
                                                // await OrderAppDB.instance
                                                //     .upadteCommonQuery(
                                                //         "orderBagTable",
                                                //         "rate=${value.orderrate_X001[index].text},totalamount=${value.orderNetAmount},qty=${value.qty[index].text}",
                                                //         "code='$code' and customerid='$customerId' and unit_name='${value.selectedItem}'");
                                                print("calculate new total");
                                                await Provider.of<Controller>(
                                                        context,
                                                        listen: false)
                                                    .calculatesalesTotal(
                                                        os, customerId);
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .getBagDetails(
                                                        customerId, os);
                                              }

                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .calculateorderTotal(
                                                      os, customerId);

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Add ",
                                              style: TextStyle(fontSize: 15),
                                            )))
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          );
        });
  }

  //////////////////
  dropDownUnit(
    Size size,
    int index,
  ) {
    double qty;
    return Consumer<Controller>(
      builder: (context, value, child) {
        // value.selectedunit_X001 = null;
        // selected=null;
        print(
            "value.prUnitSaleListData2----${value.prUnitSaleListData2}----$index--${value.selectedItem}");
        return Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
            width: size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: P_Settings.blue1,
                  style: BorderStyle.solid,
                  width: 0.4),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: value.selectedItem,
              // isDense: true,
              hint: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(value.frstDropDown.toString()),
                // child: Text(value.selectedunit_X001 == null
                //     ? "Select Unit"
                //     : value.selectedunit_X001.toString()),
              ),
              autofocus: true,
              underline: SizedBox(),
              elevation: 0,

              items: value.prUnitSaleListData2
                  .map((item) => DropdownMenuItem<String>(
                      value: item.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      )))
                  .toList(),
              onChanged: (item) {
                print("clicked");
                if (item != null) {
                  Provider.of<Controller>(context, listen: false).fromDb =
                      false;
                  value.selectedItem = item;

                  value.setUnitOrder_X001(value.selectedItem!, index);
                  print("ratjhd------${value.calculatedRate}");
                  if (value.qty[index].text == null ||
                      value.qty[index].text.isEmpty) {
                    qty = 1;
                  } else {
                    qty = double.parse(value.qty[index].text);
                    // Provider.of<Controller>(context, listen: false)
                    //     .calculateOrderNetAmount(
                    //   index,
                    //   value.calculatedRate!,
                    //   double.parse(value.qty[index].text),
                    // );
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }
}
