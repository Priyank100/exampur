class VideoCaModel {
  String? videoPath;
  String? imagePath;
  String? title;

  VideoCaModel(
      {this.videoPath,
        this.imagePath,
        this.title});

  VideoCaModel.fromJson(Map<String, dynamic> json) {
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