import 'package:flutter/material.dart';
import 'package:salesapp/components/commoncolor.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/db_helper.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> settings = ["Enable Rate Edit option  ?", "dfxdf"];
  List<bool>? _isChecked;
  String? option;
  int? edit;
  var res;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("pishku---$res");
    _isChecked = List<bool>.filled(settings.length, false);
    // Provider.of<Controller>(context, listen: false)
    //     .setSettingOption(settings.length);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<Controller>(
          builder: (context, value, child) {
            // print("jhjdhf---${value.settingsList[0]["value"]}");
            // rate = value.settingsList[0]["value"] == 0 ? false : true;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                Container(
                    alignment: Alignment.center,
                    height: size.height * 0.07,
                    // color: Colors.grey[300],
                    width: double.infinity,
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: P_Settings.wavecolor),
                    )),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  height: size.height * 0.6,
                  child: ListView.builder(
                    itemCount: settings.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(settings[index]),
                        value: _isChecked![index],
                        onChanged: (val) {
                          setState(
                            () {
                              _isChecked![index] = val!;
                            },
                          );
                          Provider.of<Controller>(context, listen: false)
                              .settingsRateOption = _isChecked![index];
                        },
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
