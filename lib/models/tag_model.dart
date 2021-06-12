
import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.tags,
  });

  List<TagModel> tags;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    tags: List<TagModel>.from(json["tags"].map((x) => TagModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
  };
}

class TagModel {
  TagModel({
    this.id,
    this.tagName,
  });

  int id;
  String tagName;

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
    id: json["id"],
    tagName: json["tagName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tagName": tagName,
  };
}
