import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:provider/provider.dart';

class CoconutSheet {
  List rawCalcResult = [];
  List splitted = [];
  // String? selected;
  ValueNotifier<bool> visible = ValueNotifier(false);
  showsalesMoadlBottomsheet(
      String item,
      String code,
      double rate,
      double dis_per,
      double dis_amt,
      double tax_per,
      double cess_per,
      double net_amt,
      BuildContext context,
      Size size,
      int index,
      String customerId,
      String os,
      double pkg,
      String date,
      String time) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          print("param---$pkg----$item....$code....-$index--$tax_per");
          // rawCalcResult = Provider.of<Controller>(context,listen: false).rawCalculation(rate,qty.toDouble(), 0.0, 100,tax_per, 0.0, "0", 0);

          // value.discount_prercent[index].text = dis_per.toString();
          // value.discount_amount[index].text = dis_amt.toString();
          // value.salesqty[index].text = qty.toString();
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
                            color: Colors.green,
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
                                      Flexible(
                                        child: Text(
                                          item.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
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
                                        : dropDownUnit(size, index, tax_per),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, bottom: 6),
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
                                    left: 15.0, right: 15, bottom: 6),
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Qty",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    // Text(
                                    //   qty.toString(),
                                    //   style: TextStyle(fontSize: 15),
                                    // ),
                                    Row(
                                      children: [
                                        FloatingActionButton.small(
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.red,
                                          ),
                                          backgroundColor: Colors.white,
                                          onPressed: () {
                                            double q = double.parse(value
                                                .salesqty_X001[index].text);
                                            q = q - 1;
                                            if (q >= 0) {
                                              value.salesqty_X001[index].text =
                                                  q.toString();
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
                                                      tax_per,
                                                      0.0,
                                                      value.settingsList1[1]
                                                              ['set_value']
                                                          .toString(),
                                                      0,
                                                      index,
                                                      true,
                                                      "qty");
                                            } else {
                                              // value.qty[index].text = "0";
                                            }
                                            // Provider.of<Controller>(context,
                                            //         listen: false)
                                            //     .fromDb = false;
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Container(
                                            width: size.width * 0.14,
                                            child: TextField(
                                              onTap: () {
                                                value.salesqty_X001[index]
                                                        .selection =
                                                    TextSelection(
                                                        baseOffset: 0,
                                                        extentOffset: value
                                                            .salesqty_X001[
                                                                index]
                                                            .value
                                                            .text
                                                            .length);
                                              },
                                              // autofocus: true,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromRGBO(
                                                          158, 158, 158, 1)),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      158, 158, 158, 1),
                                                )),
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                //border: InputBorder.none
                                              ),

                                              // maxLines: 1,
                                              // minLines: 1,
                                              keyboardType:
                                                  TextInputType.number,
                                              onSubmitted: (values) {
                                                print("values----$values");
                                                double valueqty = 0.0;
                                                // value.discount_amount[index].text=;
                                                if (values.isNotEmpty) {
                                                  print("emtyyyy");
                                                  valueqty =
                                                      double.parse(values);
                                                } else {
                                                  valueqty = 0.00;
                                                }
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .fromDb = false;

                                                print(
                                                    "settingsLits-------${value.settingsList1}");
                                                if (value.salesrate_X001[index]
                                                            .text !=
                                                        null &&
                                                    value.salesrate_X001[index]
                                                        .text.isNotEmpty) {
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .rawCalculation_X001(
                                                          double.parse(value
                                                              .salesrate_X001[
                                                                  index]
                                                              .text),
                                                          valueqty,
                                                          double.parse(value
                                                              .discount_prercent_X001[
                                                                  index]
                                                              .text),
                                                          double.parse(value
                                                              .discount_amount_X001[
                                                                  index]
                                                              .text),
                                                          tax_per,
                                                          0.0,
                                                          value.settingsList1[1]
                                                                  ['set_value']
                                                              .toString(),
                                                          0,
                                                          index,
                                                          true,
                                                          "qty");
                                                }
                                              },
                                              textAlign: TextAlign.center,
                                              controller:
                                                  value.salesqty_X001[index],
                                            ),
                                          ),
                                        ),
                                        FloatingActionButton.small(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.red,
                                          ),
                                          backgroundColor: Colors.white,
                                          onPressed: () {
                                            double q = double.parse(value
                                                .salesqty_X001[index].text);
                                            q = q + 1;
                                            value.salesqty_X001[index].text =
                                                q.toString();
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
                                                    tax_per,
                                                    0.0,
                                                    value.settingsList1[1]
                                                            ['set_value']
                                                        .toString(),
                                                    0,
                                                    index,
                                                    true,
                                                    "qty");
                                            // Provider.of<Controller>(context,
                                            //         listen: false)
                                            //     .fromDb = false;
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
                                          left: 15.0, right: 15, bottom: 18),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rate",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          // Spacer(),
                                          // Text(
                                          //   "\u{20B9}${rate}",
                                          //   style: TextStyle(fontSize: 15),
                                          // ),
                                          Container(
                                            width: size.width * 0.2,
                                            child: TextField(
                                              onTap: () {
                                                value.salesrate_X001[index]
                                                        .selection =
                                                    TextSelection(
                                                        baseOffset: 0,
                                                        extentOffset: value
                                                            .salesrate_X001[
                                                                index]
                                                            .value
                                                            .text
                                                            .length);
                                              },
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromRGBO(
                                                          158, 158, 158, 1)),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      158, 158, 158, 1),
                                                )),
                                                isDense: true,
                                                contentPadding: EdgeInsets.all(
                                                    0), //  <- you can it to 0.0 for no space

                                                //border: InputBorder.none
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onSubmitted: (values) {
                                                double valuerate = 0.0;
                                                print("values---$values");
                                                if (values.isNotEmpty) {
                                                  print("emtyyyy");
                                                  valuerate =
                                                      double.parse(values);
                                                } else {
                                                  valuerate = 0.00;
                                                }
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .fromDb = false;
                                                if (value.salesqty_X001[index]
                                                            .text !=
                                                        null &&
                                                    value.salesqty_X001[index]
                                                        .text.isNotEmpty) {
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .rawCalculation_X001(
                                                          double.parse(value
                                                              .salesrate_X001[
                                                                  index]
                                                              .text),
                                                          double.parse(value
                                                              .salesqty_X001[
                                                                  index]
                                                              .text),
                                                          double.parse(value
                                                              .discount_prercent_X001[
                                                                  index]
                                                              .text),
                                                          double.parse(value
                                                              .discount_amount_X001[
                                                                  index]
                                                              .text),
                                                          tax_per,
                                                          0.0,
                                                          value.settingsList1[1]
                                                                  ['set_value']
                                                              .toString(),
                                                          0,
                                                          index,
                                                          true,
                                                          "");
                                                }
                                              },
                                              controller:
                                                  value.salesrate_X001[index],
                                              textAlign: TextAlign.right,
                                              // decoration: InputDecoration(
                                              //   border: InputBorder.none,
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15, bottom: 18),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rate",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          // Spacer(),
                                          Text(
                                            "\u{20B9}${rate.toStringAsFixed(2)}",
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
                                      "Gross value",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Spacer(),
                                    Text(
                                      "\u{20B9}${value.gross.toStringAsFixed(2)}",
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
                                      "Discount %",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Spacer(),
                                    // Text(
                                    //   dis_per!.toStringAsFixed(2),
                                    //   style: TextStyle(fontSize: 15),
                                    // )
                                    Container(
                                      width: size.width * 0.2,
                                      child: TextField(
                                        onTap: () {
                                          value.discount_prercent_X001[index]
                                                  .selection =
                                              TextSelection(
                                                  baseOffset: 0,
                                                  extentOffset: value
                                                      .discount_prercent_X001[
                                                          index]
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
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    158, 158, 158, 1)),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                158, 158, 158, 1),
                                          )),
                                        ),

                                        // maxLines: 1,
                                        // minLines: 1,
                                        keyboardType: TextInputType.number,
                                        onSubmitted: (values) {
                                          print("values----$values");
                                          double valuediscper = 0.0;
                                          print("values---$values");
                                          if (values.isNotEmpty) {
                                            print("emtyyyy");
                                            valuediscper = double.parse(values);
                                          } else {
                                            valuediscper = 0.00;
                                          }
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .fromDb = false;
                                          if (value.salesrate_X001[index]
                                                      .text !=
                                                  null &&
                                              value.salesrate_X001[index].text
                                                  .isNotEmpty) {
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .rawCalculation_X001(
                                                    double.parse(value
                                                        .salesrate_X001[index]
                                                        .text),
                                                    double.parse(value
                                                        .salesqty_X001[index]
                                                        .text),
                                                    valuediscper,
                                                    double.parse(value
                                                        .discount_amount_X001[
                                                            index]
                                                        .text),
                                                    tax_per,
                                                    0.0,
                                                    value.settingsList1[1]
                                                            ['set_value']
                                                        .toString(),
                                                    0,
                                                    index,
                                                    true,
                                                    "disc_per");
                                          }
                                        },
                                        textAlign: TextAlign.right,
                                        controller:
                                            value.discount_prercent_X001[index],
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
                                      "Discount amt",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Spacer(),
                                    // Text(
                                    //   dis_amt!.toStringAsFixed(2),
                                    //   style: TextStyle(fontSize: 15),
                                    // )
                                    Container(
                                      width: size.width * 0.2,
                                      child: TextField(
                                        onTap: () {
                                          value.discount_amount_X001[index]
                                                  .selection =
                                              TextSelection(
                                                  baseOffset: 0,
                                                  extentOffset: value
                                                      .discount_amount_X001[
                                                          index]
                                                      .value
                                                      .text
                                                      .length);
                                        },
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    158, 158, 158, 1)),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                158, 158, 158, 1),
                                          )),
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(
                                              0), //  <- you can it to 0.0 for no space

                                          //border: InputBorder.none
                                        ),
                                        keyboardType: TextInputType.number,
                                        onSubmitted: (values) {
                                          double valuediscamt = 0.0;
                                          print("values---$values");
                                          if (values.isNotEmpty) {
                                            print("emtyyyy");
                                            valuediscamt = double.parse(values);
                                          } else {
                                            valuediscamt = 0.00;
                                          }
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .fromDb = false;
                                          if (value.salesrate_X001[index]
                                                      .text !=
                                                  null &&
                                              value.salesrate_X001[index].text
                                                  .isNotEmpty) {
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
                                                    valuediscamt,
                                                    tax_per,
                                                    0.0,
                                                    value.settingsList1[1]
                                                            ['set_value']
                                                        .toString(),
                                                    0,
                                                    index,
                                                    true,
                                                    "disc_amt");
                                          }
                                        },
                                        controller:
                                            value.discount_amount_X001[index],
                                        textAlign: TextAlign.right,
                                        // decoration: InputDecoration(
                                        //   border: InputBorder.none,
                                        // ),
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
                                      "Tax %",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Spacer(),
                                    Text(
                                      tax_per.toStringAsFixed(2),
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
                                      "Tax amount",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Spacer(),
                                    value.tax < 0.00
                                        ? Text(
                                            "\u{20B9}0.00",
                                          )
                                        : Text(
                                            "\u{20B9}${value.tax.toStringAsFixed(2)}",
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
                                      "Cess %",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Spacer(),
                                    Text(
                                      cess_per.toStringAsFixed(2),
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
                                      "Cess amount",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Spacer(),
                                    value.cess < 0.00
                                        ? Text(
                                            "\u{20B9}0.00",
                                          )
                                        : Text(
                                            "\u{20B9}${value.cess.toStringAsFixed(2)}",
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
                                      net_amt < 0.00
                                          ? Text("\u{20B9}0.00",
                                              style: TextStyle(
                                                  color: P_Settings.extracolor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15))
                                          : Text(
                                              // value.fromDb!
                                              //     ? "\u{20B9}${net_amt.toStringAsFixed(2)}"
                                              //     :
                                              "\u{20B9}${value.net_amt.toStringAsFixed(2)}",
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
                                              primary: P_Settings.salewaveColor,
                                            ),
                                            onPressed: () async {
                                              // int indexCalc = index + 1;

                                              int max = await OrderAppDB
                                                  .instance
                                                  .getMaxCommonQuery(
                                                      'salesBagTable',
                                                      'cartrowno',
                                                      "os='${os}' AND customerid='${customerId}'");
                                              var pid =
                                                  value.salesitemList2[index]
                                                      ['prid'];
                                              if (value.salesqty_X001[index]
                                                          .text !=
                                                      null &&
                                                  value.salesqty_X001[index]
                                                      .text.isNotEmpty) {
                                                double total = double.parse(
                                                        value
                                                            .salesrate_X001[
                                                                index]
                                                            .text) *
                                                    double.parse(value
                                                        .salesqty_X001[index]
                                                        .text);

                                                double baseRate = double.parse(
                                                        value
                                                            .salesrate_X001[
                                                                index]
                                                            .text) /
                                                    value.package!;
                                                print("rateggg----$baseRate");
                                                await OrderAppDB.instance
                                                    .insertsalesBagTable_X001(
                                                        item,
                                                        date,
                                                        time,
                                                        os,
                                                        customerId,
                                                        max,
                                                        code,
                                                        double.parse(value
                                                            .salesqty_X001[
                                                                index]
                                                            .text),
                                                        value
                                                            .salesrate_X001[
                                                                index]
                                                            .text,
                                                        value.taxable_rate,
                                                        total,
                                                        value.settingsList1[1]
                                                                ['set_value']
                                                            .toString(),
                                                        value.salesitemList2[
                                                            index]["hsn"],
                                                        tax_per,
                                                        value.tax,
                                                        value.cgst_per,
                                                        value.cgst_amt,
                                                        value.sgst_per,
                                                        value.sgst_amt,
                                                        value.igst_per,
                                                        value.igst_amt,
                                                        double.parse(value
                                                            .discount_prercent_X001[
                                                                index]
                                                            .text),
                                                        double.parse(value
                                                            .discount_amount_X001[
                                                                index]
                                                            .text),
                                                        cess_per,
                                                        value.cess,
                                                        0,
                                                        value.net_amt,
                                                        pid,
                                                        value.selectedItem,
                                                        value.package!,
                                                        baseRate);
                                              }
                                              Fluttertoast.showToast(
                                                msg:
                                                    "$item Inserted Successfully",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                textColor: Colors.white,
                                                fontSize: 14.0,
                                                backgroundColor: Colors.green,
                                              );
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .calculatesalesTotal(
                                                      os, customerId);

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Add ",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
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
  Widget dropDownUnit(Size size, int index, double tax_per) {
    double qty;
    return Consumer<Controller>(
      builder: (context, value, child) {
        // value.selectedunit_X001 = null;
        // selected=null;
        print(
            "value.prUnitSaleListData2----${value.prUnitSaleListData2}------${value.selectedItem}");
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
                  value.selectedItem = item;
                  value.setUnitSale_X001(value.selectedItem!, index);
                  if (value.salesqty_X001[index].text == null ||
                      value.salesqty_X001[index].text.isEmpty) {
                    qty = 1;
                  } else {
                    qty = double.parse(value.salesqty_X001[index].text);
                  }
                  Provider.of<Controller>(context, listen: false)
                      .rawCalculation_X001(
                          double.parse(value.salesrate_X001[index].text),
                          qty,
                          double.parse(
                              value.discount_prercent_X001[index].text),
                          double.parse(value.discount_amount_X001[index].text),
                          tax_per,
                          0.0,
                          value.settingsList1[1]['set_value'].toString(),
                          0,
                          index,
                          true,
                          "");
                }
              },
            ),
          ),
        );
      },
    );
  }
}
