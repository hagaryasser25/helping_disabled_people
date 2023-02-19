import 'package:flutter/cupertino.dart';

class Essay {
  Essay({
    String? id,
    String? title,
    String? essay,
    int? date,
  }) {
    _id = id;
    _title = title;
    _essay = essay;
    _date = date;
  }

  Essay.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _essay = json['essay'];
     _date = json['date'];
  }

  String? _id;
  String? _title;
  String? _essay;
  int? _date;

  String? get id => _id;
  String? get title => _title;
  String? get essay => _essay;
  int? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['essay'] = _essay;
    map['date'] = _date;

    return map;
  }
}