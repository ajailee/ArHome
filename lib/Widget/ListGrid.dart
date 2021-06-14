import 'package:aj_ar/Model/ArchiModel.dart';
import 'package:flutter/material.dart';

import 'MyGrid.dart';

class ListGrid extends StatelessWidget {
  final List<ArchiModel> list;
  final double height;
  ListGrid(this.list, this.height);
  @override
  Widget build(BuildContext context) {
    return list != null
        ? ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) => MyGrid(list[index], height),
          )
        : Center(
            child: Text('Coming Soon'),
          );
  }
}
