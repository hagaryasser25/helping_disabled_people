import 'package:flutter/cupertino.dart';

class Doctors {
  Doctors({
    String? id,
    String? speciality,
    String? code,
    int? date,
    String? exp,
    String? imageUrl,
    String? name,
    String? workPlace,
    String? price,
  }) {
    _id = id;
    _speciality = speciality;
    _code = code;
    _date = date;
    _exp = exp;
    _imageUrl = imageUrl;
    _name = name;
    _workPlace = workPlace;
    _price = price;
  }

  Doctors.fromJson(dynamic json) {
    _id = json['id'];
    _speciality = json['speciality'];
    _code = json['code'];
    _date = json['date'];
    _exp = json['exp'];
    _imageUrl = json['imageUrl'];
    _name = json['name'];
    _workPlace = json['workPlace'];
    _price = json['price'];
  }

  String? _id;
  String? _speciality;
  String? _code;
  int? _date;
  String? _exp;
  String? _imageUrl;
  String? _name;
  String? _workPlace;
  String? _price;

  String? get id => _id;
  String? get speciality => _speciality;
  String? get code => _code;
  String? get exp => _exp;
  String? get imageUrl => _imageUrl;
  String? get name => _name;
  String? get workPlace => _workPlace;
  String? get price => _price;
  int? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['speciality'] = _speciality;
    map['code'] = _code;
    map['exp'] = _exp;
    map['imageUrl'] = _imageUrl;
    map['name'] = _name;
    map['workPlace'] = _workPlace;
    map['price'] = _price;
    map['date'] = _date;

    return map;
  }
}
