import 'package:aj_ar/Model/ArchiModel.dart';
import 'package:aj_ar/Provider/ArchiProvider.dart';
import 'package:aj_ar/Screen/ErrorScreen.dart';
import 'package:aj_ar/Screen/Stepper.dart';
import 'package:aj_ar/Widget/ListGrid.dart';
import 'package:aj_ar/Widget/MyGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:velocity_x/velocity_x.dart' as velocity;

class SearchResults extends StatefulWidget {
  static String routeName = '/searchResults';
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  bool isLoading = false;
  bool isInIt = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final data = Provider.of<ArchiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Search Results'),
      ),
      body: isLoading
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.black,
              ),
              margin: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * .80,
              width: MediaQuery.of(context).size.width * .95,
              child: GridTile(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ).shimmer(
              primaryColor: Colors.grey[400], secondaryColor: Colors.white)
          : FutureBuilder(
              future: data.getFilterList,
              builder: (context, AsyncSnapshot<List<ArchiModel>> snapshot) {
                print('snap-> + ${snapshot.data}');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data.isNotEmpty) {
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: MyGrid(snapshot.data[index], size.height * 0.3),
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/oops.jpeg'),
                    Image.asset('assets/under.gif'),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'We Cant Find As Per Your Request No Problem Say Your Requirements We Will Arrange For You',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, StepperDemo.routeName,
                            arguments: null);
                      },
                      child: Icon(Icons.call),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
