import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  final String value;
  final IconData icon;
  final String text;
  MyIcon(this.icon, this.value, this.text);

  @override
  Widget build(BuildContext context) {
    String val = text.contains('Floor')
        ? 'G + $value'
        : int.parse(value) > 1
            ? ' Rooms'
            : ' Room';
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.pink,
            size: 25,
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Column(
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.grey),
              ),
              text.contains('Floor')
                  ? Text(
                      val,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      value + val,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
