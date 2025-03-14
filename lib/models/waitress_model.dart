// To parse this JSON data, do
//
//     final waitressModel = waitressModelFromJson(jsonString);

import 'dart:convert';

WaitressModel waitressModelFromJson(String str) =>
    WaitressModel.fromJson(json.decode(str));

String waitressModelToJson(WaitressModel data) => json.encode(data.toJson());

class WaitressModel {
  int id;
  String name;

  WaitressModel({required this.id, required this.name});

  factory WaitressModel.fromJson(Map<String, dynamic> json) =>
      WaitressModel(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
