import 'package:flutter/material.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:provider/provider.dart';

class ShowModal {
  showMoadlBottomsheet(
      String os,
      String customerId,
      String item,
      Size size,
      BuildContext context,
      String type,
      String code,
      int selected_index,
      String filter,
      String filterValue,
      TextEditingController qty_index,
      String appType) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Consumer<Controller>(
            builder: (context, value, child) {
              return Container(
                height: size.width * 0.3,
                // color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do you want to delete ",
                              style: TextStyle(fontSize: 15)),
                          Text(
                            "${item}",
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                          Text(" from cart ?", style: TextStyle(fontSize: 15))
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              child: const Text('delete'),
                              onPressed: () async {
                                if (type == "already in cart") {
                                  print("already in cart---$filter");

                                  if (filter == "no filter") {
                                    print(
                                        "value.seleectd------${value.selected[selected_index]}");
                                    if (value.selected[selected_index] ==
                                        false) {
                                      value.selected[selected_index] = true;
                                    }
                                  } else if (filter == "with company") {
                                    if (value.filterComselected[
                                            selected_index] ==
                                        false) {
                                      value.filterComselected[selected_index] =
                                          true;
                                    }
                                  }

                                  qty_index.clear();
                                  if (appType == "sale order") {
                                    print("customerId...........$customerId");
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "orderBagTable",
                                            "code='${code}' AND customerid='${customerId}'");
                                    if (filter == "no filter") {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getProductList(customerId);
                                    } else if (filter == "with company") {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .filterwithCompany(customerId,
                                              filterValue, "sale order");
                                    }
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                            "orderBagTable", os, customerId);
                                  }
                                  if (appType == "return") {
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "returnbagTable",
                                            "code='${code}' AND customerid='${customerId}'");
                                    if (filter == "no filter") {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getreturnList(customerId, "");
                                    } else if (filter == "with company") {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .filterwithCompany(customerId,
                                              filterValue, "return");
                                    }
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                            "returnBagTable", os, customerId);
                                  }
                                  if (appType == "sales") {
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "salesBagTable",
                                            "code='${code}' AND customerid='${customerId}'");

                                    if (filter == "no filter") {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .getSaleProductList(customerId);
                                    } else if (filter == "with company") {
                                      Provider.of<Controller>(context,
                                              listen: false)
                                          .filterwithCompany(
                                              customerId, filterValue, "sales");
                                    }
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                            "salesBagTable", os, customerId);
                                  }

                                  Navigator.of(context).pop();
                                }

                                if (type == "just added") {
                                  print("just added----$filter");
                                  if (filter == "no filter") {
                                    if (value.selected[selected_index]) {
                                      value.selected[selected_index] =
                                          !value.selected[selected_index];
                                    }
                                  } else if (filter == "with company") {
                                    print(
                                        "valuefilterCom--${value.filterComselected[selected_index]}");
                                    if (value
                                        .filterComselected[selected_index]) {
                                      value.filterComselected[selected_index] =
                                          !value.filterComselected[
                                              selected_index];
                                    }
                                  }

                                  qty_index.clear();

                                  if (appType == "sale order") {
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "orderBagTable",
                                            "code='${code}' AND customerid='${customerId}'");

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                      "orderBagTable",
                                      os,
                                      customerId,
                                    );
                                  }
                                  if (appType == "return") {
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "returnBagTable",
                                            "code='${code}' AND customerid='${customerId}'");

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                      "returnBagTable",
                                      os,
                                      customerId,
                                    );
                                  }
                                  if (appType == "sales") {
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "salesBagTable",
                                            "code='${code}' AND customerid='${customerId}'");

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                      "salesBagTable",
                                      os,
                                      customerId,
                                    );
                                  }
                                  Navigator.of(context).pop();
                                }
                                if (type == "newlist just added") {
                                  if (value.selected[selected_index]) {
                                    value.selected[selected_index] =
                                        !value.selected[selected_index];
                                  }

                                  value.qty[selected_index].clear();
                                  if (appType == "sale order") {
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "orderBagTable",
                                            "code='${code}' AND customerid='${customerId}'");

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                      "orderBagTable",
                                      os,
                                      customerId,
                                    );
                                  }
                                  if (appType == "return") {
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "returnBagTable",
                                            "code='${value.newList[selected_index]["code"]}' AND customerid='${customerId}'");

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                      "salesBagTable",
                                      os,
                                      customerId,
                                    );
                                  }
                                  if (appType == "sales") {
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "salesBagTable",
                                            "code='${value.newList[selected_index]["code"]}' AND customerid='${customerId}'");

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                      "salesBagTable",
                                      os,
                                      customerId,
                                    );
                                  }
                                  Navigator.of(context).pop();
                                }

                                if (type == "newlist already in cart") {
                                  if (value.selected[selected_index]) {
                                    value.selected[selected_index] =
                                        !value.selected[selected_index];
                                  }

                                  value.qty[selected_index].clear();
                                  if (appType == "sale order") {
                                    print("sasdsd--------------${value.newList[selected_index]["prcode"]}");
                                    // await OrderAppDB.instance
                                    //     .deleteFromTableCommonQuery(
                                    //         "orderBagTable",
                                    //         "code='${value.newList[selected_index]["prcode"]}' AND customerid='${customerId}'");

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                      "orderBagTable",
                                      os,
                                      customerId,
                                    );
                                  }
                                  if (appType == "return") {
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "returnBagTable",
                                            "code='${value.newList[selected_index]["code"]}' AND customerid='${customerId}'");

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                      "returnBagTable",
                                      os,
                                      customerId,
                                    );
                                  }
                                  if (appType == "sales") {
                                    await OrderAppDB.instance
                                        .deleteFromTableCommonQuery(
                                            "salesBagTable",
                                            "code='${value.newList[selected_index]["code"]}' AND customerid='${customerId}'");

                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .countFromTable(
                                      "salesBagTable",
                                      os,
                                      customerId,
                                    );
                                  }
                                  // Provider.of<Controller>(context,
                                  //       listen: false)
                                  //   .searchProcess();
                                  Navigator.of(context).pop();
                                }
                              }),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          ElevatedButton(
                            child: const Text('cancel'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
