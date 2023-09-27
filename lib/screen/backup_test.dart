import 'package:flutter/material.dart';

import '../db_helper.dart';

class BackupTest extends StatefulWidget {
  const BackupTest({Key? key}) : super(key: key);

  @override
  State<BackupTest> createState() => _BackupTestState();
}

class _BackupTestState extends State<BackupTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await OrderAppDB.instance.getDbPath();
                await OrderAppDB.instance.restoreDB();
              },
              child: Text("Restore")),
          ElevatedButton(
              onPressed: () async {
                await OrderAppDB.instance.backupDB();
              },
              child: Text("Backup")),
        ],
      )),
    );
  }
}
