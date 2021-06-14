import 'package:aj_ar/Provider/ArchiProvider.dart';
import 'package:aj_ar/Screen/SearchResults.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Category extends StatelessWidget {
  final List<String> _list = [
    'Residential',
    'Educational',
    'Institutional',
    'Assembly',
    'Business',
    'Mercantile',
    'Industrial',
    'Storage',
    'Wholesale Establishments',
    'Mixed Land Use',
    'Hazardous',
    'Detached',
    'Semi-Detached',
    'Multi-Storey or High Rise',
    'Slums',
    'Multi-Level Car Parking',
    'Others'
  ];
  @override
  Widget build(BuildContext context) {
    final ArchiProvider provider = Provider.of<ArchiProvider>(context);
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              provider.searchByCategory(_list[index]);
              Navigator.pushNamed(context, SearchResults.routeName);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: -5,
                    offset: Offset(-5, -5),
                    blurRadius: 30,
                  ),
                  BoxShadow(
                    color: Colors.blue[900].withOpacity(0.2),
                    spreadRadius: 2,
                    offset: Offset(7, 7),
                    blurRadius: 20,
                  )
                ],
                color: Colors.black54,
              ),
              margin: EdgeInsets.all(10),
              height: 200,
              width: 300,
              child: FittedBox(
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                child: Text(
                  _list[index] + '\n Buildings',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
