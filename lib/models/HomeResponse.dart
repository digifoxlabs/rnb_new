
import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  HomeResponse({
    required this.status,
    required this.message,
  });

  bool status;
  Message message;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
    status: json["status"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message.toJson(),
  };
}

class Message {
  Message({
    required this.totalLabour,
    required this.activeLabour,
    required this.categories,
  });

  int totalLabour;
  int activeLabour;
  List<Category> categories;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    totalLabour: json["total_labour"],
    activeLabour: json["active_labour"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_labour": totalLabour,
    "active_labour": activeLabour,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    required this.catId,
    required this.categoryName,
    required this.count,
    required this.active,
  });

  String catId;
  String categoryName;
  int count;
  int active;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    catId: json["cat_id"],
    categoryName: json["category_name"],
    count: json["count"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "category_name": categoryName,
    "count": count,
    "active": active,
  };
}
