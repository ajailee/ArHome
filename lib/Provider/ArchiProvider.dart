import 'package:aj_ar/Model/ArchiModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ArchiProvider extends ChangeNotifier {
  List<ArchiModel> _list;
  List<ArchiModel> _searchList;
  List<String> _category;
  List<ArchiModel> _filterList;

  List<String> get category {
    if (_category != null)
      return _category;
    else {
      return [
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
    }
  }

  Future<List<ArchiModel>> getlist() {
    if (_list != null) return Future.value([..._list].toList());
    return null;
  }

  Future<void> setFilter(List<String> category, RangeValues noOfRoom,
      RangeValues noOfBathRoom, RangeValues sqft, List<String> acc) async {
    List<ArchiModel> list = [];
    print(category);
    await FirebaseFirestore.instance
        .collection('model')
        .where(
          'category',
          whereIn: category,
        )
        .where(
          'noOfBedRoom',
          isGreaterThanOrEqualTo: noOfRoom.start.toInt(),
          isLessThanOrEqualTo: noOfRoom.end.toInt(),
        )
        .where('parking', isEqualTo: acc.contains('Parking'))
        .where('attachedBathRoom', isEqualTo: acc.contains('Attached BathRoom'))
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((rawdata) {
        list.add(ArchiModel.fromMap(rawdata.data()));
      });
    });
    print(list);
    var newlist = list
        .where(
          (ele) =>
              ele.noOfBathRoom >= noOfBathRoom.start.toInt() &&
              ele.noOfBathRoom <= noOfBathRoom.end.toInt() &&
              ele.sqft >= sqft.start.toInt() &&
              ele.sqft <= sqft.end.toInt(),
        )
        .toList();
    _filterList = newlist;
    print(list);
    print(newlist);
  }

  Future<List<ArchiModel>> get getFilterList {
    if (_filterList == null) {
      return null;
    } else {
      return Future.value([..._filterList]);
    }
  }

  Future<List<ArchiModel>> getSearchlist(String category) async {
    await searchByCategory(category);
    return Future.value([..._searchList].toList());
  }

  Future<void> addloadFullList() async {
    List<ArchiModel> list = [];
    if (_list == null) {
      await FirebaseFirestore.instance
          .collection('model')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((rawdata) {
          list.add(ArchiModel.fromMap(rawdata.data()));
        });
      });
      _list = [...list];
      notifyListeners();
    } else {
      return;
    }
  }

  List<ArchiModel> getBasedOnCategory(String category) {
    return [..._list.where((ele) => ele.category == category).toList()];
  }

  List<ArchiModel> getBasedOnBedRoom(int bedRoom) {
    return [..._list.where((ele) => ele.noOfBedRoom >= bedRoom).toList()];
  }

  Future<void> refreshFullList(String category) async {
    _list = null;
    await searchByCategory(category);
  }

  Future<void> loadcategory() async {
    var list;
    await FirebaseFirestore.instance.collection('category').get().then(
        (snapshot) => snapshot.docs.forEach(
            (ele) => list = ((List<String>.from(ele.data()['category'])))));
    _category = list;
  }

  Future<void> searchByCategory(String category) async {
    _searchList = null;

    List<ArchiModel> list = [];
    await FirebaseFirestore.instance
        .collection('model')
        .where('category', isEqualTo: category)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((rawdata) {
        list.add(ArchiModel.fromMap(rawdata.data()));
        _searchList = [...list];
      });
    });
  }
}
