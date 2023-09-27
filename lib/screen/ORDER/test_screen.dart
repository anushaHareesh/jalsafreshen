import 'package:flutter/material.dart';
import "package:webview_flutter/webview_flutter.dart";

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
    late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        
        Uri.parse("https://mp.imin.sg/WebPrint/M.html"),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
        
        controller: controller,
      ),
      // body: SafeArea(
      //   child: WebView(
      //     initialUrl: 'https://mp.imin.sg/WebPrint/M.html',

      //     javascriptMode: JavascriptMode.unrestricted,
      //     // onWebViewCreated: (WebViewController tmp) {
      //     //   webViewController = tmp;
      //     //   loadLocalHTML();
      //     // },
      //   ),
      // ),
    );
  }
}
