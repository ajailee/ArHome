import 'package:aj_ar/Provider/ArchiProvider.dart';
import 'package:aj_ar/Screen/SearchResults.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName;
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isInIt = true;
  bool isLoading = false;

  RangeValues _roomvalue = RangeValues(1, 5);
  RangeValues _bathroomvalue = RangeValues(1, 5);
  RangeValues _kitchenvalue = RangeValues(1, 5);
  RangeValues _sqft = RangeValues(80, 200);

  List<String> categoryList;
  List<String> selectedCategory = [];
  List<String> accList = [
    'Parking',
    'Attached BathRoom',
    'Cover Image',
    'AR View',
    'Documents Approved',
    'Verified Builder',
    'Online Support',
  ];
  List<String> selectedacc = [];

  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInIt) {
      setState(() {
        isLoading = true;
      });
      categoryList =
          Provider.of<ArchiProvider>(context, listen: false).category;
      setState(() {
        isLoading = false;
      });
    }
    isInIt = false;
  }

  bool _showcategory = true;
  bool _showroomsize = false;
  bool _showsqft = false;
  bool _showacc = false;
  bool _isSearching = false;

  Future<void> search() async {
    if (selectedCategory.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("My Home"),
            content: Text("Atleast Select On Category"),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      _isSearching = true;
    });
    await Provider.of<ArchiProvider>(context, listen: false).setFilter(
        selectedCategory, _roomvalue, _bathroomvalue, _sqft, selectedacc);
    setState(() {
      _isSearching = false;
    });
    Navigator.pushNamed(context, SearchResults.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: _isSearching
          ? Center(child: CircularProgressIndicator())
          : Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    width: size.width / 2.5,
                    height: size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          minWidth: size.width / 2.5,
                          textColor:
                              !_showcategory ? Colors.white : Colors.black,
                          color: _showcategory ? Colors.white : Colors.black,
                          child: Text(
                            'Category',
                          ),
                          onPressed: () {
                            setState(() {
                              _showcategory = true;
                              _showroomsize = false;
                              _showsqft = false;
                              _showacc = false;
                            });
                          },
                        ),
                        FlatButton(
                          minWidth: size.width / 2.5,
                          textColor:
                              !_showroomsize ? Colors.white : Colors.black,
                          color: _showroomsize ? Colors.white : Colors.black,
                          child: Text(
                            'Room',
                          ),
                          onPressed: () {
                            setState(() {
                              _showroomsize = true;
                              _showcategory = false;
                              _showsqft = false;
                              _showacc = false;
                            });
                          },
                        ),
                        FlatButton(
                            minWidth: size.width / 2.5,
                            textColor: !_showsqft ? Colors.white : Colors.black,
                            color: _showsqft ? Colors.white : Colors.black,
                            child: Text(
                              'Square Feet',
                            ),
                            onPressed: () {
                              setState(() {
                                _showsqft = true;
                                _showcategory = false;
                                _showroomsize = false;
                                _showacc = false;
                              });
                            }),
                        FlatButton(
                          minWidth: size.width / 2.5,
                          textColor: !_showacc ? Colors.white : Colors.black,
                          color: _showacc ? Colors.white : Colors.black,
                          child: Text(
                            'Additional',
                          ),
                          onPressed: () {
                            setState(() {
                              _showacc = true;
                              _showcategory = false;
                              _showroomsize = false;
                              _showsqft = false;
                            });
                          },
                        ),
                        Row(
                          children: [
                            Spacer(),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.green),
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                              ),
                              onPressed: () {
                                search();
                              },
                            ),
                            Spacer(),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                            Spacer(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                if (_showcategory)
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                        children: categoryList
                            .map(
                              (category) => FilterChip(
                                selectedColor: Colors.green,
                                disabledColor: Colors.black,
                                selected: selectedCategory.contains(category),
                                label: Text(category),
                                onSelected: (value) => changeState(category),
                              ),
                            )
                            .toList()),
                  ),
                if (_showroomsize)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('No Of Bedroom or Cabin'),
                      Text(
                          '${_roomvalue.start.toInt()} - ${_roomvalue.end.toInt()}'),
                      RangeSlider(
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.black,
                        divisions: 20,
                        min: 1,
                        values: _roomvalue,
                        max: 20,
                        onChanged: (value) {
                          setState(() {
                            _roomvalue = value;
                          });
                        },
                      ),
                      Text('No Of Kitchen or mess'),
                      Text(
                          '${_kitchenvalue.start.toInt()} - ${_kitchenvalue.end.toInt()}'),
                      RangeSlider(
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.black,
                        divisions: 20,
                        min: 1,
                        values: _kitchenvalue,
                        max: 20,
                        onChanged: (value) {
                          setState(() {
                            _kitchenvalue = value;
                          });
                        },
                      ),
                      Text('No Of Bathroom'),
                      Text(
                          '${_bathroomvalue.start.toInt()} - ${_bathroomvalue.end.toInt()}'),
                      RangeSlider(
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.black,
                        divisions: 20,
                        min: 1,
                        values: _bathroomvalue,
                        max: 20,
                        onChanged: (value) {
                          setState(() {
                            _bathroomvalue = value;
                          });
                        },
                      )
                    ],
                  ),
                if (_showsqft)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Square Feet'),
                      Text('${_sqft.start.toInt()} - ${_sqft.end.toInt()}'),
                      RangeSlider(
                        values: _sqft,
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.black,
                        min: 0,
                        max: 1000,
                        onChanged: (value) {
                          setState(() {
                            _sqft = value;
                          });
                        },
                      ),
                    ],
                  ),
                if (_showacc)
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                        children: accList
                            .map(
                              (acc) => FilterChip(
                                selectedColor: Colors.green,
                                disabledColor: Colors.black,
                                selected: selectedacc.contains(acc),
                                label: Text(acc),
                                onSelected: (value) => changeAccState(acc),
                              ),
                            )
                            .toList()),
                  ),
              ],
            ),
    );
  }

  void changeState(String s) {
    print(selectedCategory);
    setState(() {
      if (selectedCategory.contains(s)) {
        selectedCategory.remove(s);
      } else {
        selectedCategory.add(s);
      }
    });
  }

  void changeAccState(String s) {
    print(selectedCategory);
    setState(() {
      if (selectedacc.contains(s)) {
        selectedacc.remove(s);
      } else {
        selectedacc.add(s);
      }
    });
  }
}
