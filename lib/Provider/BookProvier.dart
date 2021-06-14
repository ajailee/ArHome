import 'package:aj_ar/Model/BookModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookProvider {
  static Future<void> bookModel(BookModel model) async {
    await FirebaseFirestore.instance.collection('bookModel').add(model.toMap());
  }
}
