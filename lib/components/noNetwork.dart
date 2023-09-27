import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';

class NoNetwork extends StatefulWidget {
  const NoNetwork({Key? key}) : super(key: key);

  @override
  State<NoNetwork> createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                // Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
                Icons.signal_wifi_connected_no_internet_4,

                size: 50,
                color: Colors.black,
              ),
              Text(
                "Page Not Found",
                style: TextStyle(color: P_Settings.extracolor, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
