class PartBGet {
  PartBGet({
    required this.colonyName,
    required this.familyDetails,
  });

  String colonyName;
  List<FamilyDetail> familyDetails;

  factory PartBGet.fromJson(Map<String, dynamic> json) => PartBGet(
    colonyName: json["colony_name"],
    familyDetails: List<FamilyDetail>.from(json["family_details"].map((x) => FamilyDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "colony_name": colonyName,
    "family_details": List<dynamic>.from(familyDetails.map((x) => x.toJson())),
  };
}

class FamilyDetail {
  FamilyDetail({
    required this.memberId,
    required this.fName,
    required this.fDob,
    required this.fGender,
    required this.fPhoto,
  });

  String memberId;
  String fName;
  DateTime fDob;
  String fGender;
  String fPhoto;

  factory FamilyDetail.fromJson(Map<String, dynamic> json) => FamilyDetail(
    memberId: json["member_id"],
    fName: json["f_name"],
    fDob: DateTime.parse(json["f_dob"]),
    fGender: json["f_gender"],
    fPhoto: json["f_photo"],
  );

  Map<String, dynamic> toJson() => {
    "member_id": memberId,
    "f_name": fName,
    "f_dob": "${fDob.year.toString().padLeft(4, '0')}-${fDob.month.toString().padLeft(2, '0')}-${fDob.day.toString().padLeft(2, '0')}",
    "f_gender": fGender,
    "f_photo": fPhoto,
  };
}