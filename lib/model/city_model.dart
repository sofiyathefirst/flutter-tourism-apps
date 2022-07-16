import 'package:flutter/cupertino.dart';

class CityModel {
  late String name;

  CityModel({required this.name});

  CityModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    return data;
  }
}
