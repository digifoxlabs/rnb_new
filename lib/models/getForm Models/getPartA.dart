import '../Vaccination.dart';

class PartAGet {
  PartAGet({
    required this.employeeId,
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
    required this.validity,
    required this.status,
    required this.vaccination,
  });

  String employeeId;
  String employeeName;
  DateTime dob;
  String gender;
  String mobileNo;
  String emailId;
  Category category;
  Contractor contractor;
  String designation;
  JobNature jobNature;
  DateTime doj;
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
  DateTime validity;
  String status;
  NextOfKin nextOfKin;
  NextOfKin relative;
  Vaccination vaccination;

  factory PartAGet.fromJson(Map<String, dynamic> json) => PartAGet(
    employeeId: json["employee_id"],
    employeeName: json["employee_name"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    mobileNo: json["mobile_no"],
    emailId: json["email_id"],
    category: Category.fromJson(json["category"]),
    contractor: Contractor.fromJson(json["contractor"]),
    designation: json["designation"],
    jobNature: JobNature.fromJson(json["job_nature"]),
    doj: DateTime.parse(json["doj"]),
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
    validity: DateTime.parse(json["validity"]),
    status: json["status"],
    nextOfKin: NextOfKin.fromJson(json["next_of_kin"]),
    relative: NextOfKin.fromJson(json["relative"]),
    vaccination: Vaccination.fromJson(json["vaccination"]),
  );

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "employee_name": employeeName,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "mobile_no": mobileNo,
    "email_id": emailId,
    "category": category.toJson(),
    "contractor": contractor.toJson(),
    "designation": designation,
    "job_nature": jobNature.toJson(),
    "doj": "${doj.year.toString().padLeft(4, '0')}-${doj.month.toString().padLeft(2, '0')}-${doj.day.toString().padLeft(2, '0')}",
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
    "validity": "${validity.year.toString().padLeft(4, '0')}-${validity.month.toString().padLeft(2, '0')}-${validity.day.toString().padLeft(2, '0')}",
    "status": status,
    "next_of_kin": nextOfKin.toJson(),
    "relative": relative.toJson(),
    "vaccination": vaccination.toJson(),
  };
}

class Category {
  Category({
    required this.categoryId,
    required this.categoryName,
  });

  String categoryId;
  String categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
  };
}

class Contractor {
  Contractor({
    required this.contractorId,
    required this.contractorName,
  });

  String contractorId;
  String contractorName;

  factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
    contractorId: json["contractor_id"],
    contractorName: json["contractor_name"],
  );

  Map<String, dynamic> toJson() => {
    "contractor_id": contractorId,
    "contractor_name": contractorName,
  };
}

class JobNature {
  JobNature({
    required this.jobNatureId,
    required this.jobNatureName,
  });

  String jobNatureId;
  String jobNatureName;

  factory JobNature.fromJson(Map<String, dynamic> json) => JobNature(
    jobNatureId: json["job_nature_id"],
    jobNatureName: json["job_nature_name"],
  );

  Map<String, dynamic> toJson() => {
    "job_nature_id": jobNatureId,
    "job_nature_name": jobNatureName,
  };
}

class NextOfKin {
  NextOfKin({
    required this.name,
    required this.address,
  });

  String name;
  String address;

  factory NextOfKin.fromJson(Map<String, dynamic> json) => NextOfKin(
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
  };
}