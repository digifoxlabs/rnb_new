
import 'FamilyDetailModel.dart';

class PartB {
  PartB({
    required this.colonyName,
    required this.familyDetails,
  });

  String colonyName;
  List<FamilyDetail> familyDetails;

  factory PartB.fromJson(Map<String, dynamic> json) => PartB(
    colonyName: json["colony_name"],
    familyDetails: List<FamilyDetail>.from(json["family_details"].map((x) => FamilyDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "colony_name": colonyName,
    "family_details": List<dynamic>.from(familyDetails.map((x) => x.toJson())),
  };
}