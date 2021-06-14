import 'dart:convert';

import 'package:flutter/foundation.dart';

class BookModel {
  String userId;
  String userName;
  String userEmail;
  String modelId;
  String builderId;
  String builderName;
  String requestedMode;
  String time;
  String date;
  BookModel({
    @required this.userId,
    @required this.userName,
    @required this.userEmail,
    @required this.modelId,
    @required this.builderId,
    @required this.builderName,
    @required this.requestedMode,
    @required this.time,
    @required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'modelId': modelId,
      'builderId': builderId,
      'builderName': builderName,
      'requestedMode': requestedMode,
      'time': time,
      'date': date,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      userId: map['userId'],
      userName: map['userName'],
      userEmail: map['userEmail'],
      modelId: map['modelId'],
      builderId: map['builderId'],
      builderName: map['builderName'],
      requestedMode: map['requestedMode'],
      time: map['time'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookModel(userId: $userId, userName: $userName, userEmail: $userEmail, modelId: $modelId, builderId: $builderId, builderName: $builderName, requestedMode: $requestedMode, time: $time, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookModel &&
        other.userId == userId &&
        other.userName == userName &&
        other.userEmail == userEmail &&
        other.modelId == modelId &&
        other.builderId == builderId &&
        other.builderName == builderName &&
        other.requestedMode == requestedMode &&
        other.time == time &&
        other.date == date;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        userEmail.hashCode ^
        modelId.hashCode ^
        builderId.hashCode ^
        builderName.hashCode ^
        requestedMode.hashCode ^
        time.hashCode ^
        date.hashCode;
  }
}
