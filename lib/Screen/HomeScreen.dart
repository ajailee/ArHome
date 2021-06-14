import 'package:aj_ar/Model/ArchiModel.dart';
import 'package:aj_ar/Provider/ArchiProvider.dart';
import 'package:aj_ar/Screen/ErrorScreen.dart';
import 'package:aj_ar/Widget/MyGrid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: unused_import
import 'package:velocity_x/velocity_x.dart' as velocity;

class HomeScrenn extends StatefulWidget {
  static String routeName = '/homePage';
  @override
  _HomeScrennState createState() => _HomeScrennState();
}

class _HomeScrennState extends State<HomeScrenn> {
  bool isInIt = true;
  bool isLoading = false;

  EdgeInsets padding = const EdgeInsets.all(12);

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;
  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);

  Color unselectedColor = Colors.red;
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);
  int currentIndex = 0;
  PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInIt) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<ArchiProvider>(context, listen: false).loadcategory();
      final list = Provider.of<ArchiProvider>(context, listen: false).category;
      await Provider.of<ArchiProvider>(context, listen: false)
          .searchByCategory(list[_selectedIndex]);
      setState(() {
        isLoading = false;
      });
    }
    isInIt = false;
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = Provider.of<ArchiProvider>(context);
    final list = Provider.of<ArchiProvider>(context).category;
    return RefreshIndicator(
      onRefresh: () => data.searchByCategory(list[_selectedIndex]),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Home',
              style: TextStyle(
                color: Colors.white,
              )),
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
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(right: 5, left: 10),
                          child: FilterChip(
                            checkmarkColor: Colors.white,
                            backgroundColor: Colors.black,
                            selectedColor: Colors.green,
                            selected: _selectedIndex == index,
                            label: Text(
                              list[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            onSelected: (value) async {
                              setState(() {
                                _selectedIndex = index;
                              });
                              await data.searchByCategory(list[_selectedIndex]);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: FutureBuilder(
                      future: data.getSearchlist(list[_selectedIndex]),
                      builder:
                          (context, AsyncSnapshot<List<ArchiModel>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: 200,
                            width: 200,
                          ).shimmer();
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            !snapshot.hasData) {
                          return ErrorScreen();
                        } else {
                          return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: MyGrid(
                                  snapshot.data[index], size.height * 0.3),
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
