import 'package:flutter/cupertino.dart';

class JobsListV {
  JobsListV({
    String? id,
    String? faculty,
    String? name,
    String? exp,
    String? jobName,
    String? qualification,
    String? phoneNumber,
    String? age,
  }) {
    _id = id;
    _faculty = faculty;
    _name = name;
    _exp = exp;
    jobName =jobName;
    _qualification = qualification;
    _phoneNumber = phoneNumber;
    _age = age;
  }

  JobsListV.fromJson(dynamic json) {
    _id = json['id'];
    _faculty = json['faculty'];
    _name = json['name'];
    _exp = json['exp'];
    _jobName = json['jobName'];
    _qualification = json['qualification'];
    _phoneNumber = json['phoneNumber'];
    _age = json['age'];
  }

  String? _id;
  String? _faculty;
  String? _name;
  String? _exp;
  String? _jobName;
  String? _qualification;
  String? _phoneNumber;
  String? _age;

  String? get id => _id;
  String? get faculty => _faculty;
  String? get name => _name;
  String? get exp => _exp;
  String? get jobName => _jobName;
  String? get qualification => _qualification;
  String? get phoneNumber => _phoneNumber;
  String? get age => _age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['faculty'] = _faculty;
    map['name'] = _name;
    map['exp'] = _exp;
    map['jobName'] = jobName;
    map['qualification'] = _qualification;
    map['phoneNumber'] = _phoneNumber;
    map['age'] = _age;

    return map;
  }
}