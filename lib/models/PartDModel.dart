
class PartD {
  PartD({
    required this.photoUrl,
    required this.idProofUrl,
  });

  String photoUrl;
  String idProofUrl;

  factory PartD.fromJson(Map<String, dynamic> json) => PartD(
    photoUrl: json["photo_url"],
    idProofUrl: json["id_proof_url"],
  );

  Map<String, dynamic> toJson() => {
    "photo_url": photoUrl,
    "id_proof_url": idProofUrl,
  };
}
