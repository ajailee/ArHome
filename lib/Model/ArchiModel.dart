import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ArchiModel {
  final String id;
  final int length;
  final int breath;
  final int noOfBathRoom;
  final int noOfBedRoom;
  final int noOfKitchen;
  final int noOfFloor;
  final bool attachedBathRoom;
  final bool parking;
  final String category;
  final String coverImage;
  final List<String> imageList;
  final Map<String, dynamic> arImage;
  final String des;
  final List<String> approvedDoc;
  final String builderName;
  final String builderId;
  final int sqft;

  ArchiModel({
    @required this.id,
    @required this.length,
    @required this.breath,
    @required this.noOfBathRoom,
    @required this.noOfBedRoom,
    @required this.noOfKitchen,
    @required this.noOfFloor,
    @required this.attachedBathRoom,
    @required this.parking,
    @required this.category,
    @required this.coverImage,
    @required this.imageList,
    @required this.arImage,
    @required this.des,
    @required this.approvedDoc,
    @required this.builderName,
    @required this.builderId,
    @required this.sqft,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'length': length,
      'breath': breath,
      'noOfBathRoom': noOfBathRoom,
      'noOfBedRoom': noOfBedRoom,
      'noOfKitchen': noOfKitchen,
      'noOfFloor': noOfFloor,
      'attachedBathRoom': attachedBathRoom,
      'parking': parking,
      'category': category,
      'coverImage': coverImage,
      'imageList': imageList,
      'arImage': arImage,
      'des': des,
      'approvedDoc': approvedDoc,
      'builderName': builderName,
      'builderId': builderId,
      'sqft': sqft,
    };
  }

  factory ArchiModel.fromMap(Map<String, dynamic> map) {
    return ArchiModel(
      id: map['id'],
      length: map['length'],
      breath: map['breath'],
      noOfBathRoom: map['noOfBathRoom'],
      noOfBedRoom: map['noOfBedRoom'],
      noOfKitchen: map['noOfKitchen'],
      noOfFloor: map['noOfFloor'],
      attachedBathRoom: map['attachedBathRoom'],
      parking: map['parking'],
      category: map['category'],
      coverImage: map['coverImage'],
      imageList: List<String>.from(map['imageList']),
      arImage: Map<String, dynamic>.from(map['arImage']),
      des: map['des'],
      approvedDoc: List<String>.from(map['approvedDoc']),
      builderName: map['builderName'],
      builderId: map['builderId'],
      sqft: map['sqft'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ArchiModel.fromJson(String source) =>
      ArchiModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ArchiModel(id: $id, length: $length, breath: $breath, noOfBathRoom: $noOfBathRoom, noOfBedRoom: $noOfBedRoom, noOfKitchen: $noOfKitchen, noOfFloor: $noOfFloor, attachedBathRoom: $attachedBathRoom, parking: $parking, category: $category, coverImage: $coverImage, imageList: $imageList, arImage: $arImage, des: $des, approvedDoc: $approvedDoc, builderName: $builderName, builderId: $builderId, sqft: $sqft)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArchiModel &&
        other.id == id &&
        other.length == length &&
        other.breath == breath &&
        other.noOfBathRoom == noOfBathRoom &&
        other.noOfBedRoom == noOfBedRoom &&
        other.noOfKitchen == noOfKitchen &&
        other.noOfFloor == noOfFloor &&
        other.attachedBathRoom == attachedBathRoom &&
        other.parking == parking &&
        other.category == category &&
        other.coverImage == coverImage &&
        listEquals(other.imageList, imageList) &&
        mapEquals(other.arImage, arImage) &&
        other.des == des &&
        listEquals(other.approvedDoc, approvedDoc) &&
        other.builderName == builderName &&
        other.builderId == builderId &&
        other.sqft == sqft;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        length.hashCode ^
        breath.hashCode ^
        noOfBathRoom.hashCode ^
        noOfBedRoom.hashCode ^
        noOfKitchen.hashCode ^
        noOfFloor.hashCode ^
        attachedBathRoom.hashCode ^
        parking.hashCode ^
        category.hashCode ^
        coverImage.hashCode ^
        imageList.hashCode ^
        arImage.hashCode ^
        des.hashCode ^
        approvedDoc.hashCode ^
        builderName.hashCode ^
        builderId.hashCode ^
        sqft.hashCode;
  }
}
