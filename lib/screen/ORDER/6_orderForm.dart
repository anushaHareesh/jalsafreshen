import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/components/customPopup.dart';
import 'package:salesapp/components/customSnackbar.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:salesapp/screen/ORDER/6.1_remarks.dart';
import 'package:salesapp/screen/ORDER/6_collection.dart';
import 'package:salesapp/screen/ORDER/X001_orderItemSelection.dart';
import 'package:salesapp/screen/RETURN/returnItemList.dart';
import 'package:salesapp/screen/SALES/X001Itemselection.dart';
// import 'package:orderapp/screen/SALES/sale_itemlist.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderForm extends StatefulWidget {
  String areaname;
  String? type;
  OrderForm(this.areaname, this.type, {Key? key}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> with TickerProviderStateMixin {
  // TextEditingController fieldTextEditingController = TextEditingController();
  TextEditingValue textvalue = const TextEditingValue();
  ValueNotifier<bool> valnot = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  bool isLoading = false;
  bool balVisible = false;
  String? areaName;
  String? cstmId;

  String? customerName;
  String? _selectedItemarea;
  bool customerValidation = false;
  String? area;
  CustomPopup popup = CustomPopup();
  String? _selectedItemcus;
  String? _selectedItem;
  CustomSnackbar snackbar = CustomSnackbar();
  List<Map<String, dynamic>>? newList = [];
  ValueNotifier<int> dtatableRow = ValueNotifier(0);
  // ValueNotifier<bool> visibleValidation = ValueNotifier(false);

  TextEditingController eanQtyCon = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController eanTextCon = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();

  // final formGlobalKey = GlobalKey<FormState>();
  List? splitted;
  TextEditingController fieldText = TextEditingController();
  // TextEditingController areatext = TextEditingController();
  TextEditingController customertext = TextEditingController();

  List? splitted1;
  List<DataRow> dataRows = [];
  String? selected;
  String? productCode;
  String? selectedCus;
  String? common;
  String? custmerId;
  String? sid;
  String? os;
  String? cid;
  bool areavisible = false;
  bool visible = false;
  String itemName = '';
  String rate1 = "1";
  // double rate1 = 0.0;
  bool isAdded = false;
  bool alertvisible = false;
  int selectedIndex = 0;
  final int _randomNumber1 = 0;
  bool dropvisible = true;
  String randnum = "";
  int num = 0;
  // String? _selectedItemarea;
  String? _selectedAreaId;
  DateTime now = DateTime.now();
  String? date;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("hellooo");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Controller>(context, listen: false).getOrderno();
    Provider.of<Controller>(context, listen: false).customer_visibility;
    date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    print(
        "seelected area-----${Provider.of<Controller>(context, listen: false).areaidFrompopup}");
    print(
        "_selectedAreaId----${Provider.of<Controller>(context, listen: false).areaId}");

    if (Provider.of<Controller>(context, listen: false).areaId != null) {
      print("from init stte-----");
      Provider.of<Controller>(context, listen: false)
          .getCustomer(Provider.of<Controller>(context, listen: false).areaId);
    }

    // if (Provider.of<Controller>(context, listen: false).selectedAreaId !=
    //     null) {
    //   Provider.of<Controller>(context, listen: false).getCustomer(
    //       "${Provider.of<Controller>(context, listen: false).selectedAreaId}");
    // }
    // if (Provider.of<Controller>(context, listen: false).areaidFrompopup !=
    //     null) {
    //   Provider.of<Controller>(context, listen: false).getCustomer(
    //       "${Provider.of<Controller>(context, listen: false).areaidFrompopup}");
    // }
    // Provider.of<Controller>(context, listen: false).custmerSelection = "";
    print("wudiget.areaNmae----${widget.areaname}");

    sharedPref();
  }

  sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    sid = prefs.getString('sid');
    os = prefs.getString("os");
    cid = prefs.getString("cid");
    print("company Id ......$cid");

    print("sid--os-$sid--$os");
    // Provider.of<Controller>(context, listen: false).getArea(sid!);
  }

  @override
  Widget build(BuildContext context) {
    double topInsets = MediaQuery.of(context).viewInsets.top;

    print("widget.areaname---${widget.areaname}");

    // final bottom = MediaQuery.of(context).viewInsets.bottom;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: P_Settings.wavecolor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child: Consumer<Controller>(builder: (context, values, child) {
                print("valuse----${values.areaSelecton}");
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // SizedBox(height: size.height * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: size.height * 0.2,
                            decoration: BoxDecoration(
                              color: P_Settings.wavecolor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text(
                                      widget.type == "return"
                                          ? "RETURN"
                                          : widget.type == "collection"
                                              ? "COLLECTION"
                                              : widget.type == "sales"
                                                  ? "SALE FORM"
                                                  : "SALES ORDER",
                                      style: GoogleFonts.alike(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          fontSize: 20,
                                          color: Colors.white)
                                      // ),
                                      ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text(
                                    "( $os )",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: size.height * 0.9,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: size.height * 0.01),
                                const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Area/Route",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 15),
                                  child: Container(
                                    // height: size.height * 0.06,
                                    child: Autocomplete<Map<String, dynamic>>(
                                      initialValue: TextEditingValue(
                                          text: values.areaSelecton == null ||
                                                  values.areaSelecton!.isEmpty
                                              ? widget.areaname
                                              : values.areaSelecton.toString()),
                                      optionsBuilder: (TextEditingValue value) {
                                        if (widget.areaname != "") {
                                          FocusScope.of(context).unfocus();

                                          return [];
                                        }
                                        if (value.text.isEmpty) {
                                          return [];
                                        } else {
                                          print(
                                              "values.areDetails----${values.areDetails}");
                                          return values.areDetails.where(
                                              (suggestion) =>
                                                  suggestion["aname"]
                                                      .toLowerCase()
                                                      .contains(value.text
                                                          .toLowerCase()));
                                        }
                                      },
                                      displayStringForOption:
                                          (Map<String, dynamic> option) =>
                                              option["aname"],
                                      onSelected: (value) {
                                        setState(() {
                                          _selectedItemarea = value["aname"];
                                          areaName = value["aname"];
                                          print("areaName...$areaName");
                                          _selectedAreaId = value["aid"];
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .selectedAreaId = _selectedAreaId;
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .areaAutoComplete = [
                                            _selectedAreaId!,
                                            _selectedItemarea!,
                                          ];

                                          print(
                                              "hjkkllsjm----$_selectedAreaId");
                                          print(
                                              "${Provider.of<Controller>(context, listen: false).areaAutoComplete}");
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .areaSelecton = _selectedItemarea;
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .areaId = _selectedAreaId;
                                          customertext.text = '';

                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .getCustomer(_selectedAreaId);
                                        });
                                      },
                                      fieldViewBuilder: (BuildContext context,
                                          fieldText,
                                          FocusNode fieldFocusNode,
                                          VoidCallback onFieldSubmitted) {
                                        return SizedBox(
                                          height: size.height * 0.1,
                                          child: TextFormField(
                                            
                                            // scrollPadding: EdgeInsets.only(
                                            //     top: 500,),
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                              
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 199, 198, 198),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                borderSide: BorderSide(
                                                  color: const Color.fromARGB(
                                                      255, 199, 198, 198),
                                                  width: 1.0,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                gapPadding: 1,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 3,
                                                ),
                                              ),
                                              
                                              hintText: 'Area / Route',
                                              helperText: ' ', // th
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  fieldText.clear();
                                                  _selectedAreaId = ' ';
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .getCustomer(
                                                          _selectedAreaId);
                                                },
                                                icon: const Icon(Icons.clear),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please choose area!!';
                                              }
                                              return null;
                                            },
                                            textInputAction:
                                                TextInputAction.next,

                                            controller: fieldText,
                                            focusNode: fieldFocusNode,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      },
                                      optionsViewBuilder: (BuildContext context,
                                          AutocompleteOnSelected<
                                                  Map<String, dynamic>>
                                              onSelected,
                                          Iterable<Map<String, dynamic>>
                                              options) {
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: Material(
                                            child: SizedBox(
                                              height: size.height * 0.2,
                                              width: size.width * 0.84,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                itemCount: options.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final Map<String, dynamic>
                                                      option =
                                                      options.elementAt(index);
                                                  print("option----$option");
                                                  return SizedBox(
                                                    height: size.height * 0.05,
                                                    child: ListTile(
                                                      // tileColor: Colors.amber,
                                                      onTap: () {
                                                        onSelected(option);
                                                        print(
                                                            "optionaid------${option["aid"]}");
                                                        Provider.of<Controller>(
                                                                    context,
                                                                    listen: false)
                                                                .areaId =
                                                            option["aid"];
                                                        //     option["aid"];
                                                      },
                                                      title: Text(
                                                          option["aname"]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black)),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // SizedBox(height: size.height * 0.01),
                                const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text("Customer",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // height: size.height * 0.06,
                                        child:
                                            Autocomplete<Map<String, dynamic>>(
                                          // initialValue: TextEditingValue(
                                          //     text: values.boolCustomerSet
                                          //         ? values.customer_Name
                                          //             .toString()
                                          //         : "helloooo"

                                          //  values.customer_Name ==
                                          //             null ||
                                          //         values.customer_Name!
                                          //             .isEmpty
                                          //     ? ''
                                          //     : '${values.customer_Name.toString()}'

                                          // ),
                                          optionsBuilder:
                                              (TextEditingValue value) {
                                            if (value.text.isEmpty) {
                                              return [];
                                            } else {
                                              print(
                                                  "TextEditingValue---${value.text}");
                                              return values.custmerDetails
                                                  .where((suggestion) =>
                                                      suggestion["hname"]
                                                          .toLowerCase()
                                                          .startsWith(value.text
                                                              .toLowerCase()));

                                              // contains(value.text
                                              //     .toLowerCase()));
                                            }
                                          },

                                          displayStringForOption:
                                              (Map<String, dynamic> option) =>
                                                  option["hname"].toUpperCase(),
                                          onSelected: (value) {
                                            setState(() {
                                              print("value----$value");
                                              _selectedItemcus = value["hname"];
                                              customerName =
                                                  value["hname"].toUpperCase();
                                              custmerId = value["ac_code"];
                                              print(
                                                  "Code .........---$custmerId");
                                              Provider.of<Controller>(context,
                                                          listen: false)
                                                      .customer_Name =
                                                  values.customer_Name
                                                      .toString();
                                            });
                                          },
                                          fieldViewBuilder: (BuildContext
                                                  context,
                                              fieldText,
                                              FocusNode fieldFocusNode,
                                              VoidCallback onFieldSubmitted) {
                                            print("fieldText----$fieldText");
                                            return SizedBox(
                                              // height: size.height * 0.1,
                                              child: TextFormField(
                                                readOnly: true,
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              199,
                                                              198,
                                                              198),
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              199,
                                                              198,
                                                              198),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    gapPadding: 0.3,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.black,
                                                      width: 3,
                                                    ),
                                                  ),
                                                  helperText: ' ',
                                                  hintText: 'Customer Name',
                                                  // helperText: ' ',
                                                  prefixIcon: IconButton(
                                                    onPressed: () {
                                                      print(
                                                          "szfjzjfnjd------$_selectedAreaId");
                                                      // if (values.custmerDetails
                                                      //         .length ==
                                                      //     0) {
                                                      //   if (Provider.of<Controller>(
                                                      //               context,
                                                      //               listen:
                                                      //                   false)
                                                      //           .areaId ==
                                                      //       null) {
                                                      //     print("yes correct");
                                                      //     Provider.of<Controller>(
                                                      //             context,
                                                      //             listen: false)
                                                      //         .getCustomer(
                                                      //             _selectedAreaId);
                                                      //   } else {
                                                      //     print(
                                                      //         "else---${Provider.of<Controller>(context, listen: false).areaId}");
                                                      //     Provider.of<Controller>(
                                                      //             context,
                                                      //             listen: false)
                                                      //         .getCustomer(Provider.of<
                                                      //                     Controller>(
                                                      //                 context,
                                                      //                 listen:
                                                      //                     false)
                                                      //             .areaId);
                                                      //   }
                                                      // }

                                                      print(
                                                          "values.custmerDetails-----------${values.custmerDetails}");

                                                      showModalBottomSheet<
                                                          void>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                            height: values
                                                                    .custmerDetails
                                                                    .isNotEmpty
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.5
                                                                : size.height *
                                                                    0.2,
                                                            color: Colors.white,
                                                            child: Center(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <Widget>[
                                                                  values.custmerDetails
                                                                          .isNotEmpty
                                                                      ? Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            IconButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                icon: const Icon(Icons.close))
                                                                          ],
                                                                        )
                                                                      : Container(),
                                                                  values.custmerDetails
                                                                              .isNotEmpty &&
                                                                          values
                                                                              .custmerDetails
                                                                              .isNotEmpty
                                                                      ? const Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 8.0),
                                                                          child:
                                                                              Text(
                                                                            'Customers',
                                                                            style:
                                                                                TextStyle(fontSize: 20),
                                                                          ),
                                                                        )
                                                                      : const Text(
                                                                          ''),
                                                                  values.custmerDetails
                                                                          .isNotEmpty
                                                                      ? const Divider(
                                                                          indent:
                                                                              50,
                                                                          endIndent:
                                                                              50,
                                                                          thickness:
                                                                              1,
                                                                        )
                                                                      : const Text(
                                                                          ""),
                                                                  values.custmerDetails
                                                                          .isNotEmpty
                                                                      ? Expanded(
                                                                          child: Padding(
                                                                              padding: const EdgeInsets.only(left: 10, top: 20),
                                                                              child: ListView.builder(
                                                                                itemCount: values.custmerDetails.length,
                                                                                itemBuilder: (context, index) {
                                                                                  return ListTile(
                                                                                    trailing: const Icon(Icons.arrow_circle_right_rounded),
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        customertext.text = values.custmerDetails[index]['hname'];
                                                                                        custmerId = values.custmerDetails[index]['ac_code'];
                                                                                      });
                                                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                                                      // Provider.of<Controller>(context, listen: false).setCustomerName(values.custmerDetails[index]['hname']);
                                                                                      // Navigator.of(context).push(
                                                                                      //   PageRouteBuilder(
                                                                                      //     opaque: false, // set to false
                                                                                      //     pageBuilder: (_, __, ___) => OrderForm(widget.areaname, "sales"),
                                                                                      //   ),
                                                                                      // );
                                                                                      //      customerName =
                                                                                      // values.custmerDetails[index]
                                                                                      //     ['hname'];
                                                                                      print("customer name.......${Provider.of<Controller>(context, listen: false).customer_Name}");
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                                                                    textColor: P_Settings.wavecolor,
                                                                                    title: Text(
                                                                                      "${values.custmerDetails[index]['hname']}",
                                                                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                                                    ),

                                                                                    // onTap: (() {
                                                                                    //   print("selected index");
                                                                                    // }),
                                                                                  );
                                                                                },
                                                                              )),
                                                                        )
                                                                      : Text(
                                                                          "No Customer Found!!!",
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: P_Settings.extracolor),
                                                                        ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                      Icons.book,
                                                      size: 15,
                                                    ),
                                                  ), // th
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        customertext.clear();
                                                        fieldText.clear();
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.clear,
                                                    ),
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please choose Customer!!!';
                                                  }
                                                  return null;
                                                },
                                                controller:
                                                    customertext.text != null
                                                        ? customertext
                                                        : fieldText,
                                                scrollPadding: EdgeInsets.only(
                                                    bottom: topInsets +
                                                        size.height * 0.34),
                                                focusNode: fieldFocusNode,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[700],
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          },
                                          optionsMaxHeight: size.height * 0.02,
                                          optionsViewBuilder:
                                              (BuildContext context,
                                                  AutocompleteOnSelected<
                                                          Map<String, dynamic>>
                                                      onSelected,
                                                  Iterable<Map<String, dynamic>>
                                                      options) {
                                            return Align(
                                              alignment: Alignment.topLeft,
                                              child: Material(
                                                child: SizedBox(
                                                  width: size.width * 0.84,
                                                  height: size.height * 0.2,
                                                  child: ListView.builder(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    itemCount: options.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      //      print(
                                                      // "option----${options}");
                                                      print("index----$index");
                                                      final Map<String, dynamic>
                                                          option = options
                                                              .elementAt(index);
                                                      print(
                                                          "option----$option");
                                                      return SizedBox(
                                                        height:
                                                            size.height * 0.05,
                                                        child: ListTile(
                                                          onTap: () async {
                                                            print(
                                                                "optonsssssssssssss$option");
                                                            onSelected(option);
                                                            final prefs =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            prefs.setString(
                                                                'cus_id',
                                                                option[
                                                                    "ac_code"]);
                                                            // Provider.of<Controller>(
                                                            //             context,
                                                            //             listen:
                                                            //                 false)
                                                            //         .custmerSelection =
                                                            //     option["code"];
                                                          },
                                                          title: Text(
                                                              option["hname"]
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      widget.type == "return"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  // width: size.width * 0.4,
                                                  height: size.height * 0.05,
                                                  child: ElevatedButton.icon(
                                                    icon: const Icon(
                                                      Icons.library_add_check,
                                                      color: Colors.white,
                                                      size: 15.0,
                                                    ),
                                                    label: const Text(
                                                      "Return",
                                                      style: TextStyle(
                                                          fontSize: 14,color: Colors.white,),
                                                    ),
                                                    onPressed: () async {
                                                      // await OrderAppDB
                                                      //     .instance
                                                      //     .deleteFromTableCommonQuery(
                                                      //         "returnBagTable",
                                                      //         "");
                                                      FocusScopeNode
                                                          currentFocus =
                                                          FocusScope.of(
                                                              context);

                                                      if (!currentFocus
                                                          .hasPrimaryFocus) {
                                                        currentFocus.unfocus();
                                                      }

                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .getreturnList(
                                                                custmerId
                                                                    .toString(),
                                                                "orderform");

                                                        String os = "R"
                                                            "${values.ordernum[0]["os"]}";
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .countFromTable(
                                                          "returnBagTable",
                                                          os,
                                                          custmerId.toString(),
                                                        );
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .fetchProductCompanyList();

                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .count = "0";
                                                        Provider.of<Controller>(
                                                                    context,
                                                                    listen: false)
                                                                .returnfilterCompany =
                                                            false;
                                                        Navigator.of(context)
                                                            .push(
                                                          PageRouteBuilder(
                                                            opaque:
                                                                false, // set to false
                                                            pageBuilder:
                                                                (_, __, ___) =>
                                                                    ReturnItem(
                                                              customerId:
                                                                  custmerId
                                                                      .toString(),
                                                              areaId: values.areaidFrompopup ==
                                                                          null ||
                                                                      values
                                                                          .areaidFrompopup!
                                                                          .isEmpty
                                                                  ? Provider.of<Controller>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .areaAutoComplete[
                                                                      0]
                                                                  : Provider.of<
                                                                              Controller>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .areaidFrompopup!,
                                                              os: os,
                                                              areaName: values.areaidFrompopup ==
                                                                          null ||
                                                                      values
                                                                          .areaidFrompopup!
                                                                          .isEmpty
                                                                  ? Provider.of<Controller>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .areaAutoComplete[
                                                                      1]
                                                                  : Provider.of<
                                                                              Controller>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .areaSelecton!,
                                                              type: "return",
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          P_Settings
                                                              .returnbuttnColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.05,
                                                ),
                                              ],
                                            )
                                          : widget.type == "collection"
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      // width: size.width * 0.27,
                                                      height:
                                                          size.height * 0.05,
                                                      child:
                                                          ElevatedButton.icon(
                                                        onPressed: () async {
                                                          print(
                                                              "prov area-xx----${Provider.of<Controller>(context, listen: false).areaId}");

                                                          FocusScopeNode
                                                              currentFocus =
                                                              FocusScope.of(
                                                                  context);

                                                          if (!currentFocus
                                                              .hasPrimaryFocus) {
                                                            currentFocus
                                                                .unfocus();
                                                          }

                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .fetchwallet();
                                                            final prefs =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            String? cuid =
                                                                prefs.getString(
                                                                    'cus_id');
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              PageRouteBuilder(
                                                                opaque:
                                                                    false, // set to false
                                                                pageBuilder: (_, __, ___) => CollectionPage(
                                                                    os: os,
                                                                    sid: sid,
                                                                    cuid: custmerId
                                                                        .toString(),
                                                                    aid: Provider.of<Controller>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .areaId),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        label: const Text(
                                                          'Collection',
                                                          style: TextStyle(
                                                              fontSize: 12,color: Colors.white,),
                                                        ),
                                                        icon: const Icon(
                                                          Icons.comment,
                                                          size: 15,
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              P_Settings
                                                                  .collectionbuttnColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.05,
                                                    ),
                                                  ],
                                                )
                                              : widget.type == "sales"
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          // width:
                                                          //     size.width * 0.3,
                                                          child: ElevatedButton
                                                              .icon(
                                                            icon: const Icon(
                                                              Icons.sell,
                                                              color:
                                                                  Colors.white,
                                                              size: 15.0,
                                                            ),
                                                            label: const Text(
                                                              "Sales",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                  fontSize: 14),
                                                            ),
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  P_Settings
                                                                      .wavecolor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              FocusScopeNode
                                                                  currentFocus =
                                                                  FocusScope.of(
                                                                      context);

                                                              if (!currentFocus
                                                                  .hasPrimaryFocus) {
                                                                currentFocus
                                                                    .unfocus();
                                                              }

                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                List
                                                                    customerDet =
                                                                    await OrderAppDB
                                                                        .instance
                                                                        .selectAllcommon(
                                                                            'accountHeadsTable',
                                                                            "ac_code='$custmerId'");
                                                                print(
                                                                    "customerDet------$customerDet");
                                                                String os = "S"
                                                                    "${values.ordernum[0]["os"]}";

                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .countFromTable(
                                                                  "salesBagTable",
                                                                  os,
                                                                  custmerId
                                                                      .toString(),
                                                                );
                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .fromSalesbagTable_X001(
                                                                        custmerId
                                                                            .toString(),
                                                                        "sales");
                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .fetchProductCompanyList();

                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .salefilterCompany = false;
                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .getSaleProductList(
                                                                        custmerId!);
                                                                //  os = "S" +
                                                                //   "${values.ordernum[0]["os"]}";
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                  PageRouteBuilder(
                                                                    opaque:
                                                                        false, // set to false
                                                                    pageBuilder: (_, __, ___) => SalesItem(
                                                                        customerId:
                                                                            custmerId
                                                                                .toString(),
                                                                        areaId: values.areaidFrompopup == null || values.areaidFrompopup!.isEmpty
                                                                            ? Provider.of<Controller>(context, listen: false).areaAutoComplete[
                                                                                0]
                                                                            : Provider.of<Controller>(context, listen: false)
                                                                                .areaidFrompopup!,
                                                                        os: os,
                                                                        areaName: values.areaidFrompopup == null || values.areaidFrompopup!.isEmpty
                                                                            ? Provider.of<Controller>(context, listen: false).areaAutoComplete[
                                                                                1]
                                                                            : Provider.of<Controller>(context, listen: false)
                                                                                .areaSelecton!,
                                                                        type:
                                                                            "sale",
                                                                        gtype: customerDet[0]["gtype"]),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        ElevatedButton.icon(
                                                          icon: const Icon(
                                                            Icons
                                                                .library_add_check,
                                                            color: Colors.white,
                                                            size: 15.0,
                                                          ),
                                                          label: const Text(
                                                            "Add Items",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                                fontSize: 14),
                                                          ),
                                                          onPressed: () async {
                                                            String oos = "O"
                                                                "${values.ordernum[0]['os']}";
                                                            FocusScopeNode
                                                                currentFocus =
                                                                FocusScope.of(
                                                                    context);

                                                            if (!currentFocus
                                                                .hasPrimaryFocus) {
                                                              currentFocus
                                                                  .unfocus();
                                                            }

                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              Provider.of<Controller>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .fromOrderbagTable_X001(
                                                                      custmerId
                                                                          .toString(),
                                                                      "sale order");
                                                              // Provider.of<Controller>(
                                                              //         context,
                                                              //         listen:
                                                              //             false)
                                                              //     .getProductList(
                                                              //         custmerId
                                                              //             .toString());
                                                              Provider.of<Controller>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .countFromTable(
                                                                "orderBagTable",
                                                                oos,
                                                                custmerId
                                                                    .toString(),
                                                              );

                                                              Provider.of<Controller>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .fetchProductCompanyList();

                                                              Provider.of<Controller>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .filterCompany = false;

                                                              // Provider.of<Controller>(
                                                              //         context,
                                                              //         listen:
                                                              //             false)
                                                              //     .getProductList(
                                                              //         custmerId
                                                              //             .toString());
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                PageRouteBuilder(
                                                                  opaque:
                                                                      false, // set to false
                                                                  pageBuilder: (_, __, ___) => X001OrderItemSelection(
                                                                      customerId:
                                                                          custmerId
                                                                              .toString(),
                                                                      areaId: values.areaidFrompopup == null ||
                                                                              values
                                                                                  .areaidFrompopup!.isEmpty
                                                                          ? Provider.of<Controller>(context, listen: false).areaAutoComplete[
                                                                              0]
                                                                          : Provider.of<Controller>(context, listen: false)
                                                                              .areaidFrompopup!,
                                                                      os: oos,
                                                                      areaName: values.areaidFrompopup == null ||
                                                                              values.areaidFrompopup!.isEmpty
                                                                          ? Provider.of<Controller>(context, listen: false).areaAutoComplete[1]
                                                                          : Provider.of<Controller>(context, listen: false).areaSelecton!,
                                                                      type: "sale order"),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                P_Settings
                                                                    .wavecolor,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

///////////////////////////////////////////////////////////////////
}

///////////////////////////////////
Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
              backgroundColor: Colors.white,

        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit from this app'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
