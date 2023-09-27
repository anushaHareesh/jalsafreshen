import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  String? company_code;
  String? fp;
  String? cid;
  String? os;
  String? userType;
  String? staff_id;
  WebViewTest(
      {required this.company_code,
      required this.fp,
      required this.cid,
      required this.os,
      required this.userType,
      required this.staff_id});

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
    late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        
        Uri.parse("https://trafiqerp.in/order/php/index.php?fp=${widget.fp}&company_code=${widget.company_code}&company_id=${widget.cid}&c_type=${widget.userType}&order_series=${widget.os}&staff_id=${widget.staff_id}"),
      );
  }
  getCompaniId() async {
    // String urllink =
    //     "http://trafiqerp.in/order/php/index.php?fp=fp&company_code=company_code&company_id=cid&c_type=userType&order_series=os&staff_id=staff_id";
    //       "http://trafiqerp.in/order/php/index.php?fp=$fp&company_code=$company_code&company_id=$cid&c_type=$userType&order_series=$os&staff_id=$sid1";
    // print(
    //     "webview   company code.finger..........$staff_id.....$company_code.......$fp........$os..$cid......$userType");
    print(
        "https://trafiqerp.in/order/php/index.php?fp=${widget.fp}&company_code=${widget.company_code}&company_id=${widget.cid}&c_type=${widget.userType}&order_series=${widget.os}&staff_id=${widget.staff_id}");
  }

  @override
  Widget build(BuildContext context) {
    print("dfydhdhdd");
    getCompaniId();
    return Scaffold(
      // appBar: ,
       body: WebViewWidget(
        
        controller: controller,
      ),
      // body: WebView(
      //   // navigationDelegate: (NavigationRequest request) {
      //   //   if (request.url.startsWith("http://trafiqerp.in/order/php/")) {
      //   //     return NavigationDecision.prevent;
      //   //   }
      //   //   return NavigationDecision.navigate;
      //   // },
      //   javascriptMode: JavascriptMode.unrestricted,
      //   initialUrl:
      //       "https://trafiqerp.in/order/php/index.php?fp=${widget.fp}&company_code=${widget.company_code}&company_id=${widget.cid}&c_type=${widget.userType}&order_series=${widget.os}&staff_id=${widget.staff_id}",
      //   // "http://trafiqerp.in/order/php/index.php?fp=fp&company_code=company_code&company_id=cid&c_type=userType&order_series=os&staff_id=staff_id",
      //   // initialUrl:
      //   //     "http://trafiqerp.in/order/php/index.php?fp=$fp&company_code=2Z1KOED1AXVO&company_id=CO1002&c_type=staff&order_series=DV&staff_id=VGMHD1",
      // ),
    );
  }
}
