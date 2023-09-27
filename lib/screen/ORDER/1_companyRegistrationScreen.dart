import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salesapp/components/waveclipper.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:salesapp/screen/ORDER/externalDir.dart';
import 'package:provider/provider.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/commoncolor.dart';
import '../../db_helper.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  final _formKey = GlobalKey<FormState>();
  FocusNode? fieldFocusNode;
  TextEditingController codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? manufacturer;
  String? model;
  String? fp;
  String? textFile;
  ExternalDir externalDir = ExternalDir();
  late String uniqId;

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        manufacturer = deviceData["manufacturer"];
        model = deviceData["model"];
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'manufacturer': build.manufacturer,
      'model': build.model,
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deletemenu();
    initPlatformState();
  }

  deletemenu() async {
    print("delete");
    // await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
  }

  @override
  Widget build(BuildContext context) {
    // final textfile = externalDirtext.getPublicDirectoryPath("");
    // print("Textfile data....$textfile");
    double topInsets = MediaQuery.of(context).viewInsets.top;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: InkWell(
          // onTap: () {
          //   FocusScope.of(context).requestFocus(FocusNode());
          // },
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: Stack(
                          children: <Widget>[
                            ClipPath(
                              clipper:
                                  WaveClipper(), //set our custom wave clipper.
                              child: Container(
                                padding: EdgeInsets.only(bottom: 50),
                                color: P_Settings.wavecolor,
                                height: size.height * 0.3,
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Container(
                          height: size.height * 0.08,
                          child: ListView(
                            children: _deviceData.keys.map(
                              (String property) {
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      child: Text(
                                        '${_deviceData[property]}',
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.12,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 20, right: 20),
                        child: TextFormField(
                          controller: codeController,
                          decoration:InputDecoration(
                             focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 199, 198, 198),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 199, 198, 198),
                                width: 1.0,
                              ),
                            ),
                            icon: Icon(Icons.business),
                            labelText: 'Company Key',
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please Enter Company Key';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          controller: phoneController,
                          decoration:InputDecoration(
                             focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 199, 198, 198),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 199, 198, 198),
                                width: 1.0,
                              ),
                            ),
                            icon: Icon(Icons.phone),
                            labelText: 'Mobile Number',
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please Enter Mobile Number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
                        height: size.height * 0.05,
                        width: size.width * 0.3,
                        child: ElevatedButton(
                            onPressed: () async {
                              String deviceInfo =
                                  "$manufacturer" + '' + "$model";
                              print("device info-----$deviceInfo");
                              await OrderAppDB.instance
                                  .deleteFromTableCommonQuery('menuTable', "");
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formKey.currentState!.validate()) {
                                // textFile = await externalDir
                                //     .getPublicDirectoryPath();
                                // print("textfile........$textFile");
                                String tempFp1 = await externalDir.fileRead();
                                // String? tempFp1=externalDir.tempFp;

                                // if(externalDir.tempFp==null){
                                //    tempFp="";
                                // }
                                print("tempFp---${tempFp1}");
                                Provider.of<Controller>(context, listen: false)
                                    .postRegistration(
                                        codeController.text,
                                        tempFp1,
                                        phoneController.text,
                                        deviceInfo,
                                        context);
                              }
                            },
                            child: Text("Register")),
                      ),
                      SizedBox(
                        height: size.height * 0.09,
                      ),
                      Consumer<Controller>(
                        builder: (context, value, child) {
                          if (value.isLoading) {
                            return SpinKitCircle(
                              // backgroundColor:,
                              color: P_Settings.wavecolor,

                              // valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                              // value: 0.25,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(context: context, builder: (context) => exit(0));
}
