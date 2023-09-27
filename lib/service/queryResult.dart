import "package:flutter/material.dart";
import 'package:salesapp/controller/controller.dart';
import 'package:provider/provider.dart';

class QueryResultScreen extends StatefulWidget {
  const QueryResultScreen({Key? key}) : super(key: key);

  @override
  State<QueryResultScreen> createState() => _QueryResultScreenState();
}

class _QueryResultScreenState extends State<QueryResultScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String cusid = "VGMHD5";
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: size.height * 0.1,
              width: size.width * 1.2,
              child: Card(
                child: TextField(
                  controller: controller,
                ),
              ),
            ),
            Container(
              height: size.height * 0.04,
              child: ElevatedButton(
                  onPressed: () {
                    // // controller.text="select convert(integer,value) con from maxSeriesTable";
                    // controller.text =
                    //     "SELECT MAX(x) maxVal from ( SELECT value as x FROM maxSeriesTable WHERE prefix = 'ORP' UNION ALL SELECT MAX(order_id)+1 as x FROM orderMasterTable )";
                    String qryyy = "SELECT p.pid,p.code,p.item,p.unit, 1 pkg ,p.companyId,p.hsn, " +
                        "p.tax,p.prate,p.mrp,p.cost,p.rate1 from 'productDetailsTable' p union all " +
                        "SELECT pd.pid,pd.code,pd.item,u.unit_name unit,u.package pkg,pd.companyId,pd.hsn, " +
                        "pd.tax,pd.prate,pd.mrp,pd.cost,pd.rate1 from 'productDetailsTable' pd " +
                        "inner join 'productUnits' u  ON u.pid = pd.pid ";
                    controller.text = "$qryyy";
                    Provider.of<Controller>(context, listen: false)
                        .queryExecuteResult(controller.text);
                  },
                  child: Text("execute")),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              height: size.height * 0.7,
              child: Consumer<Controller>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                            title: SelectableText(
                          value.queryResult.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        )
                            // Text(
                            //   value.queryResult.toString(),
                            // ),
                            ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
