import 'package:flutter/cupertino.dart';

class Jobs {
  Jobs({
    String? id,
    String? name,
    String? conditions,
    String? requirments,
    int? date,
  }) {
    _id = id;
    _name = name;
    _conditions = conditions;
    _requirments = requirments;
    _date = date;
  }

  Jobs.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _requirments = json['requirments'];
    _conditions = json['conditions'];
     _date = json['date'];
  }

  String? _id;
  String? _name;
  String? _requirments;
  String? _conditions;
  int? _date;

  String? get id => _id;
  String? get name => _name;
  String? get requirments => _requirments;
  String? get conditions => _conditions;
  int? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['requirments'] = _requirments;
    map['conditions'] = _conditions;
    map['date'] = _date;

    return map;
  }
}