// To parse this JSON data, do
//
//     final currentAffairsNewDetailModel = currentAffairsNewDetailModelFromJson(jsonString);

import 'dart:convert';

CurrentAffairsNewDetailModel currentAffairsNewDetailModelFromJson(String str) => CurrentAffairsNewDetailModel.fromJson(json.decode(str));

String currentAffairsNewDetailModelToJson(CurrentAffairsNewDetailModel data) => json.encode(data.toJson());

class CurrentAffairsNewDetailModel {
  CurrentAffairsNewDetailModel({
    this.id,
    this.slug,
    this.titleEng,
    this.descriptionEng,
    this.titleHindi,
    this.descriptionHindi,
    this.caTags,
    this.caArticle,
  });

  int? id;
  String? slug;
  String? titleEng;
  String? descriptionEng;
  String? titleHindi;
  String? descriptionHindi;
  List<CaTag>? caTags;
  CaArticle? caArticle;

  factory CurrentAffairsNewDetailModel.fromJson(Map<String, dynamic> json) => CurrentAffairsNewDetailModel(
    id: json["id"],
    slug: json["slug"],
    titleEng: json["title_eng"],
    descriptionEng: json["description_eng"],
    titleHindi: json["title_hindi"],
    descriptionHindi: json["description_hindi"],
    caTags: List<CaTag>.from(json["ca_tags"].map((x) => CaTag.fromJson(x))),
    caArticle: CaArticle.fromJson(json["ca_article"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "title_eng": titleEng,
    "description_eng": descriptionEng,
    "title_hindi": titleHindi,
    "description_hindi": descriptionHindi,
    "ca_tags": List<dynamic>.from(caTags!.map((x) => x.toJson())),
    "ca_article": caArticle!.toJson(),
  };
}

class CaArticle {
  CaArticle({
    this.id,
    this.slug,
    this.date,
  });

  int? id;
  String? slug;
  DateTime? date;

  factory CaArticle.fromJson(Map<String, dynamic> json) => CaArticle(
    id: json["id"],
    slug: json["slug"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  };
}

class CaTag {
  CaTag({
    this.id,
    this.name,
    this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory CaTag.fromJson(Map<String, dynamic> json) => CaTag(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}
