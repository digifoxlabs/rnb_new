// To parse this JSON data, do
//
//     final vaccination = vaccinationFromJson(jsonString);

import 'dart:convert';

Vaccination vaccinationFromJson(String str) => Vaccination.fromJson(json.decode(str));

String vaccinationToJson(Vaccination data) => json.encode(data.toJson());

class Vaccination {
  Vaccination({
    required this.status,
    required this.firstDose,
    required this.secondDose,
  });

  String status;
  String firstDose;
  String secondDose;

  factory Vaccination.fromJson(Map<String, dynamic> json) => Vaccination(
    status: json["status"],
    firstDose: json["first_dose"],
    secondDose: json["second_dose"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "first_dose": firstDose,
    "second_dose": secondDose,
  };
}
