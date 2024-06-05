// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users {
  bool? checkinNotification;
  bool? checkoutNotification;
  int? unpaidServices;
  String? firstName;
  String? lastName;
  bool? foodNotification;
  String? profileimageUrl;
  dynamic notificationToken;
  Timestamp dateTime;
  dynamic userId;

  Users(
    this.checkinNotification,
    this.checkoutNotification,
    this.firstName,
    this.lastName,
    this.foodNotification,
    this.profileimageUrl,
    this.unpaidServices,
    this.dateTime,
    this.notificationToken,
    this.userId,
  );
  Users.fromSnapshot(DocumentSnapshot snapshot)
      : checkinNotification = snapshot['checkinNotification'],
        checkoutNotification = snapshot['checkoutNotification'],
        unpaidServices = snapshot['unpaidServices'],
        firstName = snapshot['firstName'],
        lastName = snapshot['lastName'],
        foodNotification = snapshot['foodNotification'],
        profileimageUrl = snapshot['profileImageUrl'],
        dateTime = snapshot['Timestamp'],
        userId = snapshot['UserID'],
        notificationToken = snapshot['notificationToken'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'checkinNotification': checkinNotification,
      'checkoutNotification': checkoutNotification,
      'unpaidServices': unpaidServices,
      'firstName': firstName,
      'lastName': lastName,
      'foodNotification': foodNotification,
      'profileimageUrl': profileimageUrl,
      'Timestamp': dateTime,
      'UserID': userId,
      'notificationToken': ''
    };
  }

  String toJson() => json.encode(toMap());
}

class CurrentUser extends ChangeNotifier {
  Users? user;
  void currentUser(Users user) {
    this.user = user;
    notifyListeners();
  }
}
