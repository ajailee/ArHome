import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _selectedChips = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
              child: Text('Category', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute<List<String>>(builder: (context) {
                  return CategoryPage(
                    selectedList: _selectedChips,
                  );
                })).then((List<String> selectedList) {
                  this._selectedChips = selectedList;
                });
              })
        ],
      ),
      body: Center(
        child: Wrap(
          children: _selectedChips != null
              ? _selectedChips.map((s) {
                  return Chip(label: Text(s));
                }).toList()
              : [],
        ),
      ),
    );
  }
}

class CategoryPage extends StatefulWidget {
  final List<String> selectedList;

  CategoryPage({this.selectedList = const ['Movies']});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> data = ['Food', 'Entertainment', 'Other', 'Clear'];
  List<String> foodList = ['Veg', 'Non Veg'];
  List<String> entertainmentList = ['Books', 'Movies'];
  List<String> otherList = ['Travelling', 'Something else'];

  List<String> selectedList;

  @override
  void initState() {
    super.initState();
    selectedList = widget.selectedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop(selectedList);
            },
          ),
        ],
      ),
      body: Wrap(
        spacing: 6,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: data.map(
          (dataItem) {
            return dataItem == 'Clear'
                ? ActionChip(
                    label: Text(dataItem),
                    elevation: 3,
                    backgroundColor: Colors.red,
                    onPressed: () {
                      setState(
                        () {
                          foodList.forEach((s) => data.remove(s));
                          entertainmentList.forEach((s) => data.remove(s));
                          otherList.forEach((s) => data.remove(s));
                          selectedList.clear();
                        },
                      );
                    },
                  )
                : FilterChip(
                    label: Text(dataItem),
                    selected: selectedList.contains(dataItem),
                    backgroundColor: () {
                      if (foodList.contains(dataItem)) {
                        return Colors.orange;
                      }
                      if (entertainmentList.contains(dataItem)) {
                        return Colors.amber;
                      }
                      if (otherList.contains(dataItem)) {
                        return Colors.blueGrey;
                      }
                      return Colors.grey;
                    }(),
                    selectedColor: Colors.white,
                    elevation: 3,
                    labelStyle: TextStyle(
                      color: !selectedList.contains(dataItem)
                          ? Colors.white
                          : Colors.black,
                    ),
                    onSelected: (bool selected) {
                      setState(
                        () {
                          if (selected) {
                            this.selectedList.add(dataItem);
                          } else {
                            this.selectedList.remove(dataItem);
                          }

                          if (dataItem == 'Food') {
                            foodList.forEach(
                              (s) {
                                addOrRemoveElement(
                                  selected: selected,
                                  dataItem: dataItem,
                                  newItem: s,
                                );
                              },
                            );
                          }

                          if (dataItem == 'Entertainment') {
                            entertainmentList.forEach(
                              (s) {
                                addOrRemoveElement(
                                  selected: selected,
                                  dataItem: dataItem,
                                  newItem: s,
                                );
                              },
                            );
                          }

                          if (dataItem == 'Other') {
                            otherList.forEach(
                              (s) {
                                addOrRemoveElement(
                                  selected: selected,
                                  dataItem: dataItem,
                                  newItem: s,
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  );
          },
        ).toList(),
      ),
    );
  }

  void addOrRemoveElement({bool selected, String dataItem, String newItem}) {
    if (selected) {
      setState(() => data.insert(data.indexOf(dataItem) + 1, newItem));
    } else {
      setState(() => data.remove(newItem));
    }
  }
}
