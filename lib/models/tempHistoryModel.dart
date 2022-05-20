// To parse this JSON data, do
//
//     final idCardModel = idCardModelFromJson(jsonString);

import 'dart:convert';

TempHistoryModel tempHistoryModelFromJson(String str) => TempHistoryModel.fromJson(json.decode(str));

String tempHistoryModelToJson(TempHistoryModel data) => json.encode(data.toJson());

class TempHistoryModel {
  TempHistoryModel({
    required this.employeeId,
    required this.employeeName,
    required this.temperature,
    required this.dated,
    required this.photoUrl,
    required this.doj,
    required this.validity,
    required this.status,
    required this.categoryName,
    required this.contractorName,
    required this.designation,
    required this.jobNatureName,
  });

  String employeeId;
  String employeeName;
  String temperature;
  DateTime dated;
  String photoUrl;
  DateTime doj;
  DateTime validity;
  String status;
  String categoryName;
  String contractorName;
  String designation;
  String jobNatureName;

  factory TempHistoryModel.fromJson(Map<String, dynamic> json) => TempHistoryModel(
    employeeId: json["employee_id"],
    employeeName: json["employee_name"],
    temperature: json["temperature"],
    dated: DateTime.parse(json["dated"]),
    photoUrl: json["photo_url"],
    doj: DateTime.parse(json["doj"]),
    validity: DateTime.parse(json["validity"]),
    status: json["status"],
    categoryName: json["category_name"],
    contractorName: json["contractor_name"],
    designation: json["designation"],
    jobNatureName: json["job_nature_name"],
  );

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "employee_name": employeeName,
    "temperature": temperature,
    "dated": dated.toIso8601String(),
    "photo_url": photoUrl,
    "doj": "${doj.year.toString().padLeft(4, '0')}-${doj.month.toString().padLeft(2, '0')}-${doj.day.toString().padLeft(2, '0')}",
    "validity": "${validity.year.toString().padLeft(4, '0')}-${validity.month.toString().padLeft(2, '0')}-${validity.day.toString().padLeft(2, '0')}",
    "status": status,
    "category_name": categoryName,
    "contractor_name": contractorName,
    "designation": designation,
    "job_nature_name": jobNatureName,
  };
}
