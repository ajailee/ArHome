import 'dart:convert';

import 'package:flutter/foundation.dart';

class BuilderModel {
  String name;
  String id;
  String yearOfjoiningTheApp;
  String experience;
  String licienceId;
  String imageUrl;
  String siteUrl;

  int noOfBranch;
  int noOfEmployee;
  int noOfArchitect;
  int noOfCivilEngineer;
  int noOfProjects;

  bool architect;
  bool civilEngineer;
  bool supplyRawMaterial;
  bool supplyLabour;

  List<String> awards;
  List<String> governmentTender;
  List<String> branch;
  List<String> workMode;
  BuilderModel({
    @required this.name,
    @required this.id,
    @required this.yearOfjoiningTheApp,
    @required this.experience,
    @required this.licienceId,
    @required this.imageUrl,
    @required this.siteUrl,
    @required this.noOfBranch,
    @required this.noOfEmployee,
    @required this.noOfArchitect,
    @required this.noOfCivilEngineer,
    @required this.noOfProjects,
    @required this.architect,
    @required this.civilEngineer,
    @required this.supplyRawMaterial,
    @required this.supplyLabour,
    @required this.awards,
    @required this.governmentTender,
    @required this.branch,
    @required this.workMode,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'yearOfjoiningTheApp': yearOfjoiningTheApp,
      'experience': experience,
      'licienceId': licienceId,
      'imageUrl': imageUrl,
      'siteUrl': siteUrl,
      'noOfBranch': noOfBranch,
      'noOfEmployee': noOfEmployee,
      'noOfArchitect': noOfArchitect,
      'noOfCivilEngineer': noOfCivilEngineer,
      'noOfProjects': noOfProjects,
      'architect': architect,
      'civilEngineer': civilEngineer,
      'supplyRawMaterial': supplyRawMaterial,
      'supplyLabour': supplyLabour,
      'awards': awards,
      'governmentTender': governmentTender,
      'branch': branch,
      'workMode': workMode,
    };
  }

  factory BuilderModel.fromMap(Map<String, dynamic> map) {
    return BuilderModel(
      name: map['name'],
      id: map['id'],
      yearOfjoiningTheApp: map['yearOfjoiningTheApp'],
      experience: map['experience'],
      licienceId: map['licienceId'],
      imageUrl: map['imageUrl'],
      siteUrl: map['siteUrl'],
      noOfBranch: map['noOfBranch'],
      noOfEmployee: map['noOfEmployee'],
      noOfArchitect: map['noOfArchitect'],
      noOfCivilEngineer: map['noOfCivilEngineer'],
      noOfProjects: map['noOfProjects'],
      architect: map['architect'],
      civilEngineer: map['civilEngineer'],
      supplyRawMaterial: map['supplyRawMaterial'],
      supplyLabour: map['supplyLabour'],
      awards: List<String>.from(map['awards']),
      governmentTender: List<String>.from(map['governmentTender']),
      branch: List<String>.from(map['branch']),
      workMode: List<String>.from(map['workMode']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BuilderModel.fromJson(String source) =>
      BuilderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BuilderModel(name: $name, id: $id, yearOfjoiningTheApp: $yearOfjoiningTheApp, experience: $experience, licienceId: $licienceId, imageUrl: $imageUrl, siteUrl: $siteUrl, noOfBranch: $noOfBranch, noOfEmployee: $noOfEmployee, noOfArchitect: $noOfArchitect, noOfCivilEngineer: $noOfCivilEngineer, noOfProjects: $noOfProjects, architect: $architect, civilEngineer: $civilEngineer, supplyRawMaterial: $supplyRawMaterial, supplyLabour: $supplyLabour, awards: $awards, governmentTender: $governmentTender, branch: $branch, workMode: $workMode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BuilderModel &&
        other.name == name &&
        other.id == id &&
        other.yearOfjoiningTheApp == yearOfjoiningTheApp &&
        other.experience == experience &&
        other.licienceId == licienceId &&
        other.imageUrl == imageUrl &&
        other.siteUrl == siteUrl &&
        other.noOfBranch == noOfBranch &&
        other.noOfEmployee == noOfEmployee &&
        other.noOfArchitect == noOfArchitect &&
        other.noOfCivilEngineer == noOfCivilEngineer &&
        other.noOfProjects == noOfProjects &&
        other.architect == architect &&
        other.civilEngineer == civilEngineer &&
        other.supplyRawMaterial == supplyRawMaterial &&
        other.supplyLabour == supplyLabour &&
        listEquals(other.awards, awards) &&
        listEquals(other.governmentTender, governmentTender) &&
        listEquals(other.branch, branch) &&
        listEquals(other.workMode, workMode);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        yearOfjoiningTheApp.hashCode ^
        experience.hashCode ^
        licienceId.hashCode ^
        imageUrl.hashCode ^
        siteUrl.hashCode ^
        noOfBranch.hashCode ^
        noOfEmployee.hashCode ^
        noOfArchitect.hashCode ^
        noOfCivilEngineer.hashCode ^
        noOfProjects.hashCode ^
        architect.hashCode ^
        civilEngineer.hashCode ^
        supplyRawMaterial.hashCode ^
        supplyLabour.hashCode ^
        awards.hashCode ^
        governmentTender.hashCode ^
        branch.hashCode ^
        workMode.hashCode;
  }
}
