import 'package:flutter/material.dart';

class PrintPage extends StatefulWidget {
  const PrintPage({Key? key}) : super(key: key);

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Printing"),
    );
  }
}
