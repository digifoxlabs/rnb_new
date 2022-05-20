import 'package:rnb/models/Vaccination.dart';

import 'NextOfKinModel.dart';

class PartA {
  PartA({
    required this.employeeName,
    required this.dob,
    required this.gender,
    required this.mobileNo,
    required this.emailId,
    required this.category,
    required this.contractor,
    required this.designation,
    required this.jobNature,
    required this.doj,
    required this.tribe,
    required this.height,
    required this.yearsInMeghalaya,
    required this.identificationMark,
    required this.maritalStatus,
    required this.fathersName,
    required this.mothersName,
    required this.religion,
    required this.familyMembersInMeghalaya,
    required this.criminalRecord,
    required this.pendingCriminalCase,
    required this.salaryPm,
    required this.indiaCitizen,
    required this.emergencyPhoneNo,
    required this.bloodGroup,
    required this.sufferingFromIllness,
    required this.stableMindDeclaration,
    required this.expectedDurationOfStay,
    required this.otherInformation,
    required this.nextOfKin,
    required this.relative,
    required this.vaccination,
  });

  String employeeName;
  String dob;
  String gender;
  String mobileNo;
  String emailId;
  String category;
  String contractor;
  String designation;
  String jobNature;
  String doj;
  String tribe;
  String height;
  String yearsInMeghalaya;
  String identificationMark;
  String maritalStatus;
  String fathersName;
  String mothersName;
  String religion;
  String familyMembersInMeghalaya;
  String criminalRecord;
  String pendingCriminalCase;
  String salaryPm;
  String indiaCitizen;
  String emergencyPhoneNo;
  String bloodGroup;
  String sufferingFromIllness;
  String stableMindDeclaration;
  String expectedDurationOfStay;
  String otherInformation;
  NextOfKin nextOfKin;
  NextOfKin relative;
  Vaccination vaccination;



  factory PartA.fromJson(Map<String, dynamic> json) => PartA(
    employeeName: json["employee_name"],
    dob: json["dob"],
    gender: json["gender"],
    mobileNo: json["mobile_no"],
    emailId: json["email_id"],
    category: json["category"],
    contractor: json["contractor"],
    designation: json["designation"],
    jobNature: json["job_nature"],
    doj: json["doj"],
    tribe: json["tribe"],
    height: json["height"],
    yearsInMeghalaya: json["years_in_meghalaya"],
    identificationMark: json["identification_mark"],
    maritalStatus: json["marital_status"],
    fathersName: json["fathers_name"],
    mothersName: json["mothers_name"],
    religion: json["religion"],
    familyMembersInMeghalaya: json["family_members_in_meghalaya"],
    criminalRecord: json["criminal_record"],
    pendingCriminalCase: json["pending_criminal_case"],
    salaryPm: json["salary_pm"],
    indiaCitizen: json["india_citizen"],
    emergencyPhoneNo: json["emergency_phone_no"],
    bloodGroup: json["blood_group"],
    sufferingFromIllness: json["suffering_from_illness"],
    stableMindDeclaration: json["stable_mind_declaration"],
    expectedDurationOfStay: json["expected_duration_of_stay"],
    otherInformation: json["other_information"],
    nextOfKin: NextOfKin.fromJson(json["next_of_kin"]),
    relative: NextOfKin.fromJson(json["relative"]),
    vaccination: Vaccination.fromJson(json["vaccination"]),
  );

  Map<String, dynamic> toJson() => {
    "employee_name": employeeName,
    "dob": dob,
    "gender": gender,
    "mobile_no": mobileNo,
    "email_id": emailId,
    "category": category,
    "contractor": contractor,
    "designation": designation,
    "job_nature": jobNature,
    "doj": doj,
    "tribe": tribe,
    "height": height,
    "years_in_meghalaya": yearsInMeghalaya,
    "identification_mark": identificationMark,
    "marital_status": maritalStatus,
    "fathers_name": fathersName,
    "mothers_name": mothersName,
    "religion": religion,
    "family_members_in_meghalaya": familyMembersInMeghalaya,
    "criminal_record": criminalRecord,
    "pending_criminal_case": pendingCriminalCase,
    "salary_pm": salaryPm,
    "india_citizen": indiaCitizen,
    "emergency_phone_no": emergencyPhoneNo,
    "blood_group": bloodGroup,
    "suffering_from_illness": sufferingFromIllness,
    "stable_mind_declaration": stableMindDeclaration,
    "expected_duration_of_stay": expectedDurationOfStay,
    "other_information": otherInformation,
    "next_of_kin": nextOfKin.toJson(),
    "relative": relative.toJson(),
    "vaccination": vaccination.toJson(),
  };
}