import 'dart:convert';

import 'getPartA.dart';
import 'getPartB.dart';
import 'getPartC.dart';
import 'getPartD.dart';

GetFormModel getFormModelFromJson(String str) => GetFormModel.fromJson(json.decode(str));

String getFormModelToJson(GetFormModel data) => json.encode(data.toJson());

class GetFormModel {
  GetFormModel({
    required this.partA,
    required this.partB,
    required this.partC,
    required this.partD,
  });

  PartAGet partA;
  PartBGet partB;
  PartCGet partC;
  PartDGet partD;

  factory GetFormModel.fromJson(Map<String, dynamic> json) => GetFormModel(
    partA: PartAGet.fromJson(json["part_a"]),
    partB: PartBGet.fromJson(json["part_b"]),
    partC: PartCGet.fromJson(json["part_c"]),
    partD: PartDGet.fromJson(json["part_d"]),
  );

  Map<String, dynamic> toJson() => {
    "part_a": partA.toJson(),
    "part_b": partB.toJson(),
    "part_c": partC.toJson(),
    "part_d": partD.toJson(),
  };
}







