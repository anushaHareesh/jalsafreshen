import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customSnackbar.dart';
import 'package:salesapp/components/showMoadal.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:provider/provider.dart';

class ReturnFilteredProduct extends StatefulWidget {
  String? type;
  String? os;
  List<String>? s;
  String? customerId;
  String? value;

  ReturnFilteredProduct({
    required this.type,
    this.customerId,
    this.os,
    this.s,
    this.value,
  });

  @override
  State<ReturnFilteredProduct> createState() => _ReturnFilteredProductState();
}

class _ReturnFilteredProductState extends State<ReturnFilteredProduct> {
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
        .filterwithCompany(widget.customerId!, widget.value!, "return");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<Controller>(
        builder: (context, value, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.returnfilteredProductList.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 0.4, right: 0.4),
                child: Dismissible(
                  key: ObjectKey(index),
                  child: ListTile(
                    title: Text(
                      '${value.returnfilteredProductList[index]["code"]}' +
                          '-' +
                          '${value.returnfilteredProductList[index]["item"]}',
                      style: TextStyle(
                          color: value.returnfilteredProductList[index]
                                      ["cartrowno"] ==
                                  null
                              ? value.filterComselected[index]
                                  ? Colors.red
                                  : Colors.grey[700]
                              : Colors.red,
                          fontSize: 16),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '\u{20B9}${value.returnfilteredProductList[index]["rate1"]}',
                          style: TextStyle(
                            color: P_Settings.ratecolor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.055,
                        ),
                        Text(
                          '(tax: \u{20B9}${value.returnfilteredProductList[index]["tax"]})',
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
                                'returnBagTable',
                                'cartrowno',
                                "os='${widget.os!}' AND customerid='${widget.customerId}'");
                            print("max----$max");
                            rate1 =
                                value.returnfilteredProductList[index]["rate1"];
                            var total = double.parse(rate1) *
                                double.parse(value.qty[index].text);
                            print("total rate $total");

                            var res = await OrderAppDB.instance
                                .insertreturnBagTable(
                                    value.returnfilteredProductList[index]
                                        ["pritem"],
                                    widget.s![0],
                                    widget.s![1],
                                    widget.os!,
                                    widget.customerId!,
                                    max,
                                    value.returnfilteredProductList[index]
                                        ["prcode"],
                                    double.parse(value.qty[index].text),
                                    rate1,
                                    total.toString(),
                                    0,
                                    "",
                                    0.0,
                                    double.parse(rate1),
                                    0);

                            snackbar.showSnackbar(
                                context,
                                "${value.returnfilteredProductList[index]["code"] + value.returnfilteredProductList[index]['item']} - Added to cart",
                                "return");
                            Provider.of<Controller>(context, listen: false)
                                .countFromTable(
                              "returnBagTable",
                              widget.os!,
                              widget.customerId!,
                            );

                            // if (widget.type == "return") {
                            //   rate1 = value.filteredProductList[index]["rate1"];
                            //   var total = int.parse(rate1) *
                            //       int.parse(value.qty[index].text);
                            //   Provider.of<Controller>(context, listen: false)
                            //       .addToreturnList({
                            //     "item": value.filteredProductList[index]
                            //         ["item"],
                            //     "date": widget.s![0],
                            //     "time": widget.s![1],
                            //     "os": value.ordernum[0]["os"],
                            //     "customer_id": widget.customerId,
                            //     "code": value.filteredProductList[index]
                            //         ["code"],
                            //     "qty": int.parse(value.qty[index].text),
                            //     "rate": rate1,
                            //     "total": total.toString(),
                            //     "status": 0
                            //   });
                            // }
                            /////////////////////////////////////////////////////////////
                            (widget.customerId!.isNotEmpty ||
                                        widget.customerId != null) &&
                                    (value
                                            .returnfilteredProductList[index]
                                                ["code"]
                                            .isNotEmpty ||
                                        value.returnfilteredProductList[index]
                                                ["code"] !=
                                            null)
                                ? Provider.of<Controller>(context,
                                        listen: false)
                                    .calculatereturnTotal(
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
                            onPressed: value.returnfilteredProductList[index]
                                        ["cartrowno"] ==
                                    null
                                ? value.filterComselected[index]
                                    ? () async {
                                        String item =
                                            value.returnfilteredProductList[
                                                    index]["code"] +
                                                value.returnfilteredProductList[
                                                    index]["item"];
                                        showModal.showMoadlBottomsheet(
                                            widget.os!,
                                            widget.customerId!,
                                            item,
                                            size,
                                            context,
                                            "just added",
                                            value.returnfilteredProductList[
                                                index]["code"],
                                            index,
                                            "with company",
                                            Provider.of<Controller>(context,
                                                    listen: false)
                                                .returnfilteredeValue!,
                                            value.qty[index],
                                            "return");
                                      }
                                    : null
                                : () async {
                                    // String oos = "O" + "${widget.os}";

                                    String item =
                                        value.returnfilteredProductList[index]
                                                ["code"] +
                                            value.returnfilteredProductList[
                                                index]["item"];
                                    showModal.showMoadlBottomsheet(
                                        widget.os!,
                                        widget.customerId!,
                                        item,
                                        size,
                                        context,
                                        "already in cart",
                                        value.returnfilteredProductList[index]
                                            ["code"],
                                        index,
                                        "with company",
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .returnfilteredeValue!,
                                        value.qty[index],
                                        "return");
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
