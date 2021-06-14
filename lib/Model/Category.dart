import 'dart:convert';

import 'package:flutter/foundation.dart';

class Category {
  final List<String> category;
  Category({
    @required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      category: List<String>.from(map['category']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() => 'Category(category: $category)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category && listEquals(other.category, category);
  }

  @override
  int get hashCode => category.hashCode;
}
