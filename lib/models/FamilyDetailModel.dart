
class FamilyDetail {
  FamilyDetail({
    required this.fName,
    required this.fDob,
    required this.fGender,
    required this.fPhoto,
  });

  String fName;
  String fDob;
  String fGender;
  String fPhoto;

  factory FamilyDetail.fromJson(Map<String, dynamic> json) => FamilyDetail(
    fName: json["f_name"],
    fDob: json["f_dob"],
    fGender: json["f_gender"],
    fPhoto: json["f_photo"],
  );

  Map<String, dynamic> toJson() => {
    "f_name": fName,
    "f_dob": fDob,
    "f_gender": fGender,
    "f_photo": fPhoto,
  };
}