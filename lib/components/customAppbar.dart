import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/screen/ADMIN_/adminController.dart';

import 'package:provider/provider.dart';

class CustomAppbar extends StatefulWidget {
  String title;
  String level;
  CustomAppbar({required this.title, required this.level}) {
    print(title);
  }

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  late FocusNode myFocusNode;
  //   final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  Widget? appBarTitle;
  Icon actionIcon = Icon(Icons.search);
  TextEditingController _controller1 = TextEditingController();
  bool visible = false;
  void togle() {
    setState(() {
      visible = !visible;
    });
  }

  onChangedValue(String value) {
    print("value inside function ---${value}");
    setState(() {
      Provider.of<AdminController>(context, listen: false).searchkey = value;
      if (value.isEmpty) {
        Provider.of<AdminController>(context, listen: false).isSearch = false;
      }
      if (value.isNotEmpty) {
        Provider.of<AdminController>(context, listen: false).isSearch = true;
        // Provider.of<Controller>(context, listen: false)
        //     .searchProcess(widget.level);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode = FocusNode();
    // print("initstate----${widget.title.toString()}");
    appBarTitle = Text(
      widget.title.toString(),
      style: TextStyle(fontSize: 18),
    );
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    if (widget.level == "level1") {
      Provider.of<AdminController>(context, listen: false)
          .level1reportList
          .clear();
      Provider.of<AdminController>(context, listen: false).l1newList.clear();
    }
    if (widget.level == "level2") {
      Provider.of<AdminController>(context, listen: false)
          .level2reportList
          .clear();
      Provider.of<AdminController>(context, listen: false).l2newList.clear();
    }
    if (widget.level == "level3") {
      Provider.of<AdminController>(context, listen: false)
          .level3reportList
          .clear();
      Provider.of<AdminController>(context, listen: false).l3newList.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("widget build context----${appBarTitle}");
    // final formKey = GlobalKey<FormState>();
    // print("widget build context----${widget.title.toString()}");
    return AppBar(
      backgroundColor: widget.level == "level1"
          ? P_Settings.blue4
          : widget.level == "level2"
              ? P_Settings.blue4
              : widget.level == "level3"
                  ? P_Settings.blue4
                  : null,
      title: appBarTitle,
      leading: IconButton(
        onPressed: () {
          if (widget.level == "level1") {
            Provider.of<AdminController>(context, listen: false).isSearch =
                false;
            Provider.of<AdminController>(context, listen: false)
                .searchProcess(widget.level);
          }
          if (widget.level == "level2") {
            Provider.of<AdminController>(context, listen: false).isSearch =
                false;
            Provider.of<AdminController>(context, listen: false)
                .searchProcess(widget.level);
          }
          if (widget.level == "level3") {
            Provider.of<AdminController>(context, listen: false).isSearch =
                false;
            Provider.of<AdminController>(context, listen: false)
                .searchProcess(widget.level);
          }
          Navigator.of(context).pop(true);
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
            onPressed: () {
              togle();
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  print("hai");
                  _controller1.clear();
                  this.actionIcon = Icon(Icons.close);
                  print("this.appbar---${this.appBarTitle}");
                  this.appBarTitle = TextField(
                      focusNode: myFocusNode,
                      autofocus: false,
                      controller: _controller1,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: ((value) {
                        print("value---$value");
                        onChangedValue(value);
                      }),
                      cursorColor: Colors.black);
                } else {
                  if (this.actionIcon.icon == Icons.close) {
                    print("hellooo");
                    Provider.of<AdminController>(context, listen: false)
                        .isSearch = false;
                    this.actionIcon = Icon(Icons.search);
                    this.appBarTitle = Text(widget.title);

                    _controller1.clear();
                    Provider.of<AdminController>(context, listen: false)
                        .searchProcess(widget.level);
                    // Provider.of<Controller>(context, listen: false)
                    //     .newListClear();

                  }
                }
              });
            },
            icon: actionIcon),
        Visibility(
          visible: visible,
          child: IconButton(
              onPressed: () {
                setState(() {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Provider.of<AdminController>(context, listen: false)
                      .setisSearch(true);
                  Provider.of<AdminController>(context, listen: false)
                      .searchProcess(widget.level);
                });
              },
              icon: Icon(Icons.done)),
        )
      ],
    );
  }
}
