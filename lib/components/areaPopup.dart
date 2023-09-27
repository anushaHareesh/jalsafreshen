import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:provider/provider.dart';

class AreaSelectionPopup {
  String? selected;
  Future buildPopupDialog(BuildContext context, Size size) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new AlertDialog(
      backgroundColor: Colors.white,

            content: Consumer<Controller>(builder: (context, value, child) {
              if (value.isLoading) {
                return SpinKitFadingCircle(
                  color: P_Settings.wavecolor,
                );
              } else {
                return Column(
                  children: [
                    Container(
                      color: Colors.grey[200],
                      height: size.height * 0.04,
                      child: DropdownButton<String>(
                        value: selected,
                        hint: Text("Select"),
                        isExpanded: true,
                        autofocus: false,
                        underline: SizedBox(),
                        elevation: 0,
                        items: value.areDetails
                            .map((item) => DropdownMenuItem<String>(
                                value: item["aid"].toString(),
                                child: Container(
                                  width: size.width * 0.5,
                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(item["aname"].toString())),
                                )))
                            .toList(),
                        onChanged: (item) {
                          print("clicked");

                          if (item != null) {
                            selected = item;
                            print("se;ected---$item");
                          }
                        },

                        // disabledHint: Text(selected ?? "null"),
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("save"))
                  ],
                );
              }
            }),

            // actions: [
            //   ElevatedButton(onPressed: (){
            //     Navigator.pop(context);
            //   }, child: Text("ok"))
            // ],
          );
        });
  }
}
