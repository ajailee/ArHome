import 'package:aj_ar/Model/BuilderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuilderStreamProvider {
  Stream<List<BuilderModel>> get builderStream {
    return FirebaseFirestore.instance.collection('builder').snapshots().map(
        (QuerySnapshot ele) =>
            ele.docs.map((res) => BuilderModel.fromMap(res.data())).toList());
  }
}
