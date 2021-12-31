class JobAlertModel {
  String? imagePath;
  String? title;
  String? target;

  JobAlertModel (
      {
        this.imagePath,
        this.title,
        this.target
      });

  JobAlertModel .fromJson(Map<String, dynamic> json) {
    imagePath = json['image_path'];
    title = json['title'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_path'] = this.imagePath;
    data['title'] = this.title;
    data['target'] = this.target;
    return data;
  }
}