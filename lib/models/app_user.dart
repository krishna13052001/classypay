import 'package:flutter/foundation.dart';

class AppUser {
  String id;
  String name;
  String phoneNumber;

  AppUser(
      {@required this.id,
      @required this.name,
      @required this.phoneNumber,
      });

  AppUser.fromMap(Map<String, dynamic> doc) {
    this.id = doc['id'];
    this.name = doc['name'];
    this.phoneNumber = doc['phNo'];
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'phNo': this.phoneNumber      };
}