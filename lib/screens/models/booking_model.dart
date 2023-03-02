import 'package:flutter/cupertino.dart';

class CourseBookings {
  CourseBookings({
    String? id,
    String? courseCode,
    String? userEmail,
    String? userName,
    String? userPhone,
    int? date,
  }) {
    _id = id;
    _courseCode = courseCode;
    _userEmail = userEmail;
    _userName = userName;
    _userPhone = userPhone;
    _date = date;
  }

  CourseBookings.fromJson(dynamic json) {
    _id = json['id'];
    _courseCode = json['code'];
    _userEmail = json['userEmail'];
    _userName = json['userName'];
    _userPhone = json['userPhone'];
    _date = json['date'];
  }

  String? _id;
  String? _courseCode;
  String? _userEmail;
  String? _userName;
  String? _userPhone;
  int? _date;

  String? get courseCode => _courseCode;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  String? get userPhone => _userPhone;
  String? get id => _id;
  int? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _courseCode;
    map['id'] = _id;
    map['userEmail'] = _userEmail;
    map['userName'] = _userName;
    map['userPhone'] = _userPhone;
    map['date'] = _date;

    return map;
  }
}
