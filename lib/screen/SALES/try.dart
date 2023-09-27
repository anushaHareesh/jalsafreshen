import 'package:flutter/material.dart';

class CartPageCard extends StatefulWidget {
  const CartPageCard({Key? key}) : super(key: key);

  @override
  State<CartPageCard> createState() => _CartPageCardState();
}

class _CartPageCardState extends State<CartPageCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            
          );
        },
      ),
    );
  }
}
