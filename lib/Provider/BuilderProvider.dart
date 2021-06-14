import 'package:aj_ar/Model/BuilderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class BuilderProvider extends ChangeNotifier {
  List<BuilderModel> _list;

  List<BuilderModel> get builderList {
    if (_list != null) {
      return [..._list].toList();
    }
    return null;
  }

  Future<BuilderModel> getBuilderById(String id) async {
    {
      final model = await FirebaseFirestore.instance
          .collection('builder')
          .doc(id)
          .get()
          .then((ele) => BuilderModel.fromMap(ele.data()));
      return model;
    }
  }

  Future<void> getFullBuilderList() async {
    List<BuilderModel> list = [];
    if (_list == null) {
      await FirebaseFirestore.instance
          .collection('builder')
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((rawdata) {
          list.add(BuilderModel.fromMap(rawdata.data()));
        });
      });
      _list = [...list];
      notifyListeners();
    } else {
      return;
    }
  }

  Future<void> refreshFullList() async {
    _list = null;
    await getFullBuilderList();
  }

  // void addBuilder(String i) {
  //   int v = int.parse(i);
  //   FirebaseFirestore.instance.collection('builder').doc(i).set(BuilderModel(
  //         architect: true,
  //         awards: ['hj'],
  //         branch: ['hj'],
  //         civilEngineer: true,
  //         experience: '${i * 5}',
  //         governmentTender: ['hj'],
  //         id: i,
  //         imageUrl: 'jh',
  //         licienceId: 'hj',
  //         name: 'SM Builders',
  //         noOfArchitect: v * 10,
  //         noOfBranch: v * 3,
  //         noOfCivilEngineer: v * 20,
  //         noOfEmployee: v * 80,
  //         noOfProjects: v * 30,
  //         siteUrl: 'fg',
  //         supplyLabour: true,
  //         supplyRawMaterial: true,
  //         workMode: ['time charge', 'contract', 'day charge'],
  //         yearOfjoiningTheApp: 'Since 200$i',
  //       ).toMap());
  // }
}

// void addBuilder(String i) {
//   int v = int.parse(i);
//   FirebaseFirestore.instance.collection('builder').doc(i).set(BuilderModel(
//         architect: true,
//         awards: ['hj'],
//         branch: ['hj'],
//         civilEngineer: true,
//         experience: '${i * 5}',
//         governmentTender: ['hj'],
//         id: i,
//         imageUrl: 'jh',
//         licienceId: 'hj',
//         name: 'SM Builders',
//         noOfArchitect: v * 10,
//         noOfBranch: v * 3,
//         noOfCivilEngineer: v * 20,
//         noOfEmployee: v * 80,
//         noOfProjects: v * 30,
//         siteUrl: 'fg',
//         supplyLabour: true,
//         supplyRawMaterial: true,
//         workMode: ['time charge', 'contract', 'day charge'],
//         yearOfjoiningTheApp: 'Since 200$i',
//       ).toMap());
// }
