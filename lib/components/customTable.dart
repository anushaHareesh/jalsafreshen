import 'package:flutter/material.dart';
import 'package:salesapp/controller/controller.dart';
import 'package:provider/provider.dart';

class CustomTable extends StatefulWidget {
  const CustomTable({Key? key}) : super(key: key);

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(builder: (context, value, child) {
      if (value.isLoading) {
        return Container(

          child: CircularProgressIndicator(),
        );
      } else {
        return Container(
          height: 700,
          child: Table(
            defaultColumnWidth: FixedColumnWidth(120.0),  
            children: [
              TableRow(
                children: [
                  Column(children: [
                    Text(
                      '',
                    )
                  ]),
                  Column(children: [
                    Text(
                      'Company Name',
                    )
                  ]),
                  Column(children: [
                    Text(
                      "${value.c_d[0].cnme}",
                    )
                  ]),
                ],
              ),
              TableRow(
                children: [
                  Column(children: [
                    Text(
                      '',
                    )
                  ]),
                  Column(children: [
                    Text(
                      'Address1',
                    )
                  ]),
                  Column(children: [
                    Text(
                      '${value.c_d[0].ad1}',
                    )
                  ]),
                ],
              ),
              TableRow(
                children: [
                  Column(children: [
                    Text(
                      'Website',
                    )
                  ]),
                  Column(children: [
                    Text(
                      'Address1',
                    )
                  ]),
                  Column(children: [
                    Text(
                      '${value.c_d[0].ad2}',
                    )
                  ]),
                ],
              ),
              TableRow(
                children: [
                  Column(children: [
                    Text(
                      'Website',
                    )
                  ]),
                  Column(children: [
                    Text(
                      'PinCode',
                    )
                  ]),
                  Column(children: [
                    Text(
                      '${value.c_d[0].pcode}',
                    )
                  ]),
                ],
              ),
              TableRow(
                children: [
                  Column(children: [
                    Text(
                      'Website',
                    )
                  ]),
                  Column(children: [
                    Text(
                      'Company Prefix',
                    )
                  ]),
                  Column(children: [
                    Text(
                      '${value.c_d[0].cpre}',
                    )
                  ]),
                ],
              ),
              TableRow(
                children: [
                  Column(children: [
                    Text(
                      'Website',
                    )
                  ]),
                  Column(children: [
                    Text(
                      'Land',
                    )
                  ]),
                  Column(children: [
                    Text(
                      '${value.c_d[0].land}',
                    )
                  ]),
                ],
              ),
              TableRow(
                children: [
                  Column(children: [
                    Text(
                      'Website',
                    )
                  ]),
                  Column(children: [
                    Text(
                      'Mobile',
                    )
                  ]),
                  Column(children: [
                    Text(
                      '${value.c_d[0].mob}',
                    )
                  ]),
                ],
              ),
              TableRow(
                children: [
                  Column(children: [
                    Text(
                      'Website',
                    )
                  ]),
                  Column(children: [
                    Text(
                      'GST',
                    )
                  ]),
                  Column(children: [
                    Text(
                      '${value.c_d[0].gst}',
                    )
                  ]),
                ],
              ),
              TableRow(
                children: [
                  Column(children: [
                    Text(
                      'Website',
                    )
                  ]),
                  Column(children: [
                    Text(
                      'Country Code',
                    )
                  ]),
                  Column(children: [
                    Text(
                      '${value.c_d[0].ccode}',
                    )
                  ]),
                ],
              ),
            ],
          ),
        );
      }
    });
  }
}
