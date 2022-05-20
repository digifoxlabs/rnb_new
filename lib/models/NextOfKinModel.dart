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