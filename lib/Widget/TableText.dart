import 'package:flutter/material.dart';

class TableText extends StatelessWidget {
  final String text;

  TableText(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
