import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customSnackbar.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:provider/provider.dart';

import '../../components/showMoadal.dart';

class SaleFilteredProduct extends StatefulWidget {
  String? type;
  String? os;
  List<String>? s;
  String? customerId;
  String? value;
  String? gtype;

  SaleFilteredProduct(
      {required this.type,
      this.customerId,
      this.os,
      this.s,
      this.value,
      this.gtype});

  @override
  State<SaleFilteredProduct> createState() => _SaleFilteredProductState();
}

class _SaleFilteredProductState extends State<SaleFilteredProduct> {
  String rate1 = "1";

  CustomSnackbar snackbar = CustomSnackbar();
  ShowModal showModal = ShowModal();

  // void _onRefresh() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? cid = prefs.getString("cid");
  //   _refreshController.refreshCompleted();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false)
        .filterwithCompany(widget.customerId!, widget.value!, "sales");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return ListView.builder(
            itemExtent: 55.0,
            shrinkWrap: true,
            itemCount: value.salefilteredProductList.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 0.4, right: 0.4),
                child: Dismissible(
                  key: ObjectKey(index),
                  child: ListTile(
                    title: Text(
                      '${value.salefilteredProductList[index]["code"]}' +
                          '-' +
                          '${value.salefilteredProductList[index]["item"]}',
                      style: TextStyle(
                          color: value.salefilteredProductList[index]
                                      ["cartrowno"] ==
                                  null
                              ? value.filterComselected[index]
                                  ? Colors.green
                                  : Colors.grey[700]
                              : Colors.green,
                          fontSize: 16),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '\u{20B9}${value.salefilteredProductList[index]["rate1"]}',
                          style: TextStyle(
                            color: P_Settings.ratecolor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.055,
                        ),
                        Text(
                          '(tax: \u{20B9}${value.salefilteredProductList[index]["tax"]})',
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: size.width * 0.06,
                            child: TextFormField(
                              controller: value.qty[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "1"),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                          ),
                          onPressed: () async {
                            // String os="S"+"${value.ordernum[0]["os"]}";
                            setState(() {
                              if (value.filterComselected[index] == false) {
                                value.filterComselected[index] =
                                    !value.filterComselected[index];
                              }

                              if (value.qty[index].text == null ||
                                  value.qty[index].text.isEmpty) {
                                value.qty[index].text = "1";
                              }
                            });

                            int max = await OrderAppDB.instance.getMaxCommonQuery(
                                'salesBagTable',
                                'cartrowno',
                                "os='${widget.os}' AND customerid='${widget.customerId}'");
                            print("max----$max");
                            rate1 =
                                value.salefilteredProductList[index]["rate1"];
                            var total = double.parse(rate1) *
                                double.parse(value.qty[index].text);
                            double qtyNew = 0.0;
                            double discounamttNew = 0.0;
                            double discounpertNew = 0.0;
                            double cesspertNew = 0.0;

                            List qtyNewList = await OrderAppDB.instance
                                .selectAllcommon('salesBagTable',
                                    "os='${widget.os}' AND customerid='${widget.customerId}' AND code='${value.salefilteredProductList[index]["code"]}'");
                            if (qtyNewList.length > 0) {
                              qtyNew = qtyNewList[0]["qty"];
                              discounamttNew = qtyNewList[0]["discount_amt"];
                              discounpertNew = qtyNewList[0]["discount_per"];
                              cesspertNew = qtyNewList[0]["ces_per"];
                            }

                            double qtyww =
                                qtyNew + double.parse(value.qty[index].text);
                            print("qtynew----$qtyww");
                            print("total rate $total");
                            String result =
                                Provider.of<Controller>(context, listen: false)
                                    .rawCalculation(
                                        double.parse(
                                            value.salefilteredProductList[index]
                                                ["rate1"]),
                                        qtyww,
                                        discounpertNew,
                                        discounamttNew,
                                        double.parse(
                                            value.salefilteredProductList[index]
                                                ["tax"]),
                                        0.0,
                                        value.settingsList1[1]['set_value']
                                            .toString(),
                                        int.parse(widget.gtype!),
                                        index,
                                        false,
                                        "");
                            if (result == "success") {
                              var res = await OrderAppDB.instance
                                  .insertsalesBagTable(
                                      value.salefilteredProductList[index]
                                          ["item"],
                                      widget.s![0],
                                      widget.s![1],
                                      widget.os!,
                                      widget.customerId!,
                                      max,
                                      value.salefilteredProductList[index]
                                          ["code"],
                                      double.parse(value.qty[index].text),
                                      rate1,
                                      value.taxable_rate,
                                      total,
                                      "0",
                                      value.salefilteredProductList[index]
                                          ["hsn"],
                                      double.parse(
                                          value.salefilteredProductList[index]
                                              ["tax"]),
                                      value.tax,
                                      value.cgst_per,
                                      value.cgst_amt,
                                      value.sgst_per,
                                      value.sgst_amt,
                                      value.igst_per,
                                      value.igst_amt,
                                      discounpertNew,
                                      discounamttNew,
                                      0.0,
                                      value.cess,
                                      0,
                                      value.net_amt,
                                      0,
                                      "",
                                      0.0,
                                      0.0);

                              int qtysale = int.parse(value.qty[index].text);
                              // Provider.of<Controller>(context, listen: false)
                              //     .quantitiChange(qtysale, index);

                              snackbar.showSnackbar(
                                  context,
                                  "${value.salefilteredProductList[index]["code"] + value.salefilteredProductList[index]['item']} - Added to cart",
                                  "sales");
                              Provider.of<Controller>(context, listen: false)
                                  .countFromTable(
                                "salesBagTable",
                                widget.os!,
                                widget.customerId!,
                              );
                            }

                            /////////////////////////////////////////////////////////////
                            (widget.customerId!.isNotEmpty ||
                                        widget.customerId != null) &&
                                    (value
                                            .salefilteredProductList[index]
                                                ["code"]
                                            .isNotEmpty ||
                                        value.salefilteredProductList[index]
                                                ["code"] !=
                                            null)
                                ? Provider.of<Controller>(context,
                                        listen: false)
                                    .calculateorderTotal(
                                        widget.os!, widget.customerId!)
                                : Text("No data");
                          },
                          color: Colors.black,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 18,
                              // color: Colors.redAccent,
                            ),
                            onPressed: value.salefilteredProductList[index]
                                        ["cartrowno"] ==
                                    null
                                ? value.filterComselected[index]
                                    ? () async {
                                        String item =
                                            value.salefilteredProductList[index]
                                                    ["code"] +
                                                value.salefilteredProductList[
                                                    index]["item"];
                                        showModal.showMoadlBottomsheet(
                                            widget.os!,
                                            widget.customerId!,
                                            item,
                                            size,
                                            context,
                                            "just added",
                                            value.salefilteredProductList[index]
                                                ["code"],
                                            index,
                                            "with company",
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .salefilteredeValue!,
                                            value.qty[index],
                                            "sales");
                                      }
                                    : null
                                : () async {
                                    String item =
                                        value.salefilteredProductList[index]
                                                ["code"] +
                                            value.salefilteredProductList[index]
                                                ["item"];
                                    showModal.showMoadlBottomsheet(
                                        widget.os!,
                                        widget.customerId!,
                                        item,
                                        size,
                                        context,
                                        "already in cart",
                                        value.salefilteredProductList[index]
                                            ["code"],
                                        index,
                                        "with company",
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .salefilteredeValue!,
                                        value.qty[index],
                                        "sales");
                                  })
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
