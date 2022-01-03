class One2oneModel {
  String? videoPath;
  String? imagePath;
  String? title;
  String? teacher;

  One2oneModel(
      {this.videoPath,
        this.imagePath,
        this.title,this.teacher
      });

  One2oneModel.fromJson(Map<String, dynamic> json) {
    videoPath = json['video_path'];
    imagePath = json['image_path'];
    title = json['title'];
    teacher =json['teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_path'] = this.videoPath;
    data['image_path'] = this.imagePath;
    data['title'] = this.title;
    data['teacher'] = this.teacher;
    return data;
  }
}