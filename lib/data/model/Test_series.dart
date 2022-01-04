class TestSeriesModel {
  String? imagePath;
  String? title;
  String? target;

  TestSeriesModel({
    this.imagePath,
    this.title,
    this.target,
  });

  factory TestSeriesModel.fromJson(Map<String, dynamic> json) => TestSeriesModel(
    imagePath: json["image_path"],
    title: json["title"],
    target: json["target"],
  );

  Map<String, dynamic> toJson() => {
    "image_path": imagePath,
    "title": title,
    "target": target,
  };
}