import 'package:flutter/cupertino.dart';

class DoctorsBookings {
  DoctorsBookings({
    String? id,
    String? doctorName,
    String? userEmail,
    String? userName,
    String? userPhone,
    String? date,
    String? status,
  }) {
    _id = id;
    _doctorName = doctorName;
    _userEmail = userEmail;
    _userName = userName;
    _userPhone = userPhone;
    _date = date;
    _status = status;
  }

  DoctorsBookings.fromJson(dynamic json) {
    _id = json['id'];
    _doctorName = json['doctorName'];
    _userEmail = json['userEmail'];
    _userName = json['userName'];
    _userPhone = json['userPhone'];
    _date = json['date'];
    _status = json['status'];
  }

  String? _id;
  String? _doctorName;
  String? _userEmail;
  String? _userName;
  String? _userPhone;
  String? _date;
  String? _status;

  String? get id => _id;
  String? get doctorName => _doctorName;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  String? get userPhone => _userPhone;
  String? get status => _status;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['doctorName'] = _doctorName;
    map['userEmail'] = _userEmail;
    map['userName'] = _userName;
    map['userPhone'] = _userPhone;
    map['status'] = _status;
    map['date'] = _date;

    return map;
  }
}
