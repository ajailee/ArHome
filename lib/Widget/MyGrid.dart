import 'package:aj_ar/Model/ArchiModel.dart';
import 'package:aj_ar/Screen/DetailedScreen.dart';
import 'package:aj_ar/Screen/ErrorScreen.dart';
import 'package:flutter/material.dart';

class MyGrid extends StatelessWidget {
  final ArchiModel model;
  final double height;
  MyGrid(this.model, this.height);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailedScreen.routeName,
          arguments: model,
        );
      },
      child: model == null
          ? ErrorScreen()
          : ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: height,
                width: double.infinity,
                child: GridTile(
                  child: Image.network(model.coverImage,
                      width: double.infinity, height: height, fit: BoxFit.fill),
                  footer: GridTileBar(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.king_bed),
                        Text(
                          model.noOfBedRoom.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.bathtub),
                        Text(
                          model.noOfBathRoom.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.photo_size_select_small_sharp,
                        ),
                        Text(
                          '${model.sqft} sq.ft',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
