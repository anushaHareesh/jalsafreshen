import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customSnackbar.dart';
import 'package:salesapp/components/showMoadal.dart';
import 'package:salesapp/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/controller.dart';

class FilteredProduct extends StatefulWidget {
  String? type;
  String? os;
  List<String>? s;
  String? customerId;
  String? value;

  FilteredProduct({
    required this.type,
    this.customerId,
    this.os,
    this.s,
    this.value,
  });

  @override
  State<FilteredProduct> createState() => _FilteredProductState();
}

class _FilteredProductState extends State<FilteredProduct> {
  String rate1 = "1";
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  CustomSnackbar snackbar = CustomSnackbar();
  ShowModal showModal = ShowModal();

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cid = prefs.getString("cid");
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false)
        .filterwithCompany(widget.customerId!, widget.value!, "sale order");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.filteredProductList.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 0.4, right: 0.4),
                child: Dismissible(
                  key: ObjectKey(index),
                  child: ListTile(
                    title: Text(
                      '${value.filteredProductList[index]["code"]}' +
                          '-' +
                          '${value.filteredProductList[index]["item"]}',
                      style: TextStyle(
                          color: widget.type == "sale order"
                              ? value.filteredProductList[index]["cartrowno"] ==
                                      null
                                  ? value.filterComselected[index]
                                      ? Colors.green
                                      : Colors.grey[700]
                                  : Colors.green
                              : value.filterComselected[index]
                                  ? Colors.grey[700]
                                  : Colors.grey[700],
                          fontSize: 16),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '\u{20B9}${value.filteredProductList[index]["rate1"]}',
                          style: TextStyle(
                            color: P_Settings.ratecolor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.055,
                        ),
                        Text(
                          '(tax: \u{20B9}${value.filteredProductList[index]["tax"]})',
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
                            String oos = "${widget.os}";

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
                            if (widget.type == "sale order") {
                              int max = await OrderAppDB.instance.getMaxCommonQuery(
                                  'orderBagTable',
                                  'cartrowno',
                                  "os='${oos}' AND customerid='${widget.customerId}'");
                              print("max----$max");
                              rate1 = value.filteredProductList[index]["rate1"];
                              var total = double.parse(rate1) *
                                  double.parse(value.qty[index].text);
                              print("total rate $total");

                              var res =
                                  await OrderAppDB.instance.insertorderBagTable(
                                value.filteredProductList[index]["item"],
                                widget.s![0],
                                widget.s![1],
                                oos,
                                widget.customerId!,
                                max,
                                value.filteredProductList[index]["code"],
                                double.parse(value.qty[index].text),
                                rate1,
                                total.toString(),
                                1,
                                "",
                                0.0,
                                0.0,
                                0,
                              );

                              snackbar.showSnackbar(
                                  context,
                                  "${value.filteredProductList[index]["code"] + value.filteredProductList[index]['item']} - Added to cart",
                                  "sale order");
                              Provider.of<Controller>(context, listen: false)
                                  .countFromTable(
                                "orderBagTable",
                                oos,
                                widget.customerId!,
                              );
                            }

                            /////////////////////////////////////////////////////////////
                            (widget.customerId!.isNotEmpty ||
                                        widget.customerId != null) &&
                                    (value.filteredProductList[index]["code"]
                                            .isNotEmpty ||
                                        value.filteredProductList[index]
                                                ["code"] !=
                                            null)
                                ? Provider.of<Controller>(context,
                                        listen: false)
                                    .calculateorderTotal(
                                        oos, widget.customerId!)
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
                            onPressed: widget.type == "sale order"
                                ? value.filteredProductList[index]
                                            ["cartrowno"] ==
                                        null
                                    ? value.filterComselected[index]
                                        ? () async {
                                            String oos = "${widget.os}";

                                            String item =
                                                value.filteredProductList[index]
                                                        ["code"] +
                                                    value.filteredProductList[
                                                        index]["item"];
                                            showModal.showMoadlBottomsheet(
                                                oos,
                                                widget.customerId!,
                                                item,
                                                size,
                                                context,
                                                "just added",
                                                value.filteredProductList[index]
                                                    ["code"],
                                                index,
                                                "with company",
                                                Provider.of<Controller>(context,
                                                        listen: false)
                                                    .filteredeValue!,
                                                value.qty[index],
                                                "sale order");
                                          }
                                        : null
                                    : () async {
                                        String oos = "${widget.os}";

                                        String item =
                                            value.filteredProductList[index]
                                                    ["code"] +
                                                value.filteredProductList[index]
                                                    ["item"];
                                        showModal.showMoadlBottomsheet(
                                            oos,
                                            widget.customerId!,
                                            item,
                                            size,
                                            context,
                                            "already in cart",
                                            value.filteredProductList[index]
                                                ["code"],
                                            index,
                                            "with company",
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .filteredeValue!,
                                            value.qty[index],
                                            "sale order");
                                      }
                                : value.filterComselected[index]
                                    ? () async {
                                        String oos = "${widget.os}";

                                        String item =
                                            value.filteredProductList[index]
                                                    ["code"] +
                                                value.filteredProductList[index]
                                                    ["item"];
                                        showModal.showMoadlBottomsheet(
                                            oos,
                                            widget.customerId!,
                                            item,
                                            size,
                                            context,
                                            "return",
                                            value.filteredProductList[index]
                                                ["code"],
                                            index,
                                            "with company",
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .filteredeValue!,
                                            value.qty[index],
                                            "sale order");
                                      }
                                    : null)
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
