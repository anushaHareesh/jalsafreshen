import 'package:flutter/material.dart';

class TestP extends StatefulWidget {
  const TestP({Key? key}) : super(key: key);

  @override
  State<TestP> createState() => _TestPState();
}

class _TestPState extends State<TestP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}