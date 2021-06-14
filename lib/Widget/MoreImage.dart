import 'package:aj_ar/Model/ArchiModel.dart';
import 'package:aj_ar/Screen/Gallery.dart';

import 'package:flutter/material.dart';

class MoreImage extends StatelessWidget {
  final ArchiModel model;
  MoreImage(this.model);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Gallery.routeName,
            arguments: model.imageList);
      },
      child: Container(
        height: 100,
        width: 100,
        child: Stack(
          children: [
            Positioned(
              bottom: 5,
              right: 10,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Opacity(
                    opacity: .8,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            model.imageList.last,
                            filterQuality: FilterQuality.low,
                          )),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.add),
                      Text(
                        model.imageList.length.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
