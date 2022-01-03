class DummyModel {
  String? imagePath;
  String? title;
  String? target;

  DummyModel({
    this.imagePath,
    this.title,
    this.target,
  });

  factory DummyModel.fromJson(Map<String, dynamic> json) => DummyModel(
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