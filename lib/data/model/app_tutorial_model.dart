class AppTutorialModel {
  String? videoPath;
  String? imagePath;
  String? title;

  AppTutorialModel(
      {this.videoPath,
        this.imagePath,
        this.title});

  AppTutorialModel.fromJson(Map<String, dynamic> json) {
    videoPath = json['video_path'];
    imagePath = json['image_path'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_path'] = this.videoPath;
    data['image_path'] = this.imagePath;
    data['title'] = this.title;
    return data;
  }
}