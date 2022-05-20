
class PartC {
  PartC({
    required this.permanentAddress,
    required this.district,
    required this.city,
    required this.state,
    required this.pincode,
    required this.postalAddressInMeghalaya,
  });

  String permanentAddress;
  String district;
  String city;
  String state;
  String pincode;
  String postalAddressInMeghalaya;

  factory PartC.fromJson(Map<String, dynamic> json) => PartC(
    permanentAddress: json["permanent_address"],
    district: json["district"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    postalAddressInMeghalaya: json["postal_address_in_meghalaya"],
  );

  Map<String, dynamic> toJson() => {
    "permanent_address": permanentAddress,
    "district": district,
    "city": city,
    "state": state,
    "pincode": pincode,
    "postal_address_in_meghalaya": postalAddressInMeghalaya,
  };
}