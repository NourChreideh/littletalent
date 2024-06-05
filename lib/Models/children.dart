import 'package:flutter/material.dart';

class Children extends ChangeNotifier {
  int? age;
  String? firstName;
  String? lastName;
  String profileimageUrl;
  String ClassUrl;
  String ageType;

  Children(
    this.age,
    this.firstName,
    this.lastName,
    this.profileimageUrl,
    this.ClassUrl,
    this.ageType
  );

  factory Children.fromjson(Map<String, dynamic> json) {
    return Children(
      json['Age'] as int,
      json['firstName'] as String,
      json['lastName'] as String,
      json['profileimageUrl'] as String,
      json['Class'] as String,
      json['ageType'] as String
    );
  }
}

class CurrentChildren extends ChangeNotifier {
  Children? children;
  void currentChildren(Children children) {
    this.children = children;
    notifyListeners();
  }
}
