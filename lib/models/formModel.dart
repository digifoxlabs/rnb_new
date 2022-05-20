import 'dart:convert';
import 'PartAModel.dart';
import 'PartBModel.dart';
import 'PartCModel.dart';
import 'PartDModel.dart';

FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));

String formModelToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
  FormModel({
    required this.partA,
    required this.partB,
    required this.partC,
    required this.partD,
  });

  PartA partA;
  PartB partB;
  PartC partC;
  PartD partD;

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
    partA: PartA.fromJson(json["part_a"]),
    partB: PartB.fromJson(json["part_b"]),
    partC: PartC.fromJson(json["part_c"]),
    partD: PartD.fromJson(json["part_d"]),
  );

  Map<String, dynamic> toJson() => {
    "part_a": partA.toJson(),
    "part_b": partB.toJson(),
    "part_c": partC.toJson(),
    "part_d": partD.toJson(),
  };
}