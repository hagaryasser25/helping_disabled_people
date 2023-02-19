import 'package:flutter/cupertino.dart';

class Places {
  Places({
    String? id,
    String? name,
    String? address,
    String? price,
    int? date,
  }) {
    _id = id;
    _name = name;
    _address = address;
    _price = price;
    _date = date;
  }

  Places.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _address = json['address'];
     _date = json['date'];
  }

  String? _id;
  String? _name;
  String? _price;
  String? _address;
  int? _date;

  String? get id => _id;
  String? get name => _name;
  String? get price => _price;
  String? get address => _address;
  int? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['address'] = _address;
    map['date'] = _date;

    return map;
  }
}