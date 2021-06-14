import 'package:flutter/material.dart';

class AvaliableWidget extends StatelessWidget {
  final String name;
  final bool value;

  const AvaliableWidget({Key key, this.name, this.value = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: FilterChip(
        avatar: value ? Icon(Icons.check) : Icon(Icons.close),
        padding: EdgeInsets.all(3),
        selectedColor: Colors.green[200],
        backgroundColor: Colors.red,
        label: Text(name),
        selected: value,
        onSelected: (val) {},
      ),
    );
  }
}
