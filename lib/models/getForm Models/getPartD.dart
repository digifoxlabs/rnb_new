
class PartDGet {
  PartDGet({
    required this.photoUrl,
    required this.idProofUrl,
  });

  String photoUrl;
  String idProofUrl;

  factory PartDGet.fromJson(Map<String, dynamic> json) => PartDGet(
    photoUrl: json["photo_url"],
    idProofUrl: json["id_proof_url"],
  );

  Map<String, dynamic> toJson() => {
    "photo_url": photoUrl,
    "id_proof_url": idProofUrl,
  };
}