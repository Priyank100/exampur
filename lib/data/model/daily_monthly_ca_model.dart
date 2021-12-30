class DailyMonthlyCaModel {
  String? imagePath;
  String? title;
  String? viewId;
  String? viewCount;
  String? shareText;

  DailyMonthlyCaModel(
      {this.imagePath,
        this.title,
        this.viewId,
        this.viewCount,
        this.shareText
      });

  DailyMonthlyCaModel.fromJson(Map<String, dynamic> json) {
    imagePath = json['image_path'];
    title = json['title'];
    viewId = json['view_id'];
    viewCount = json['view_count'];
    shareText = json['share_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_path'] = this.imagePath;
    data['title'] = this.title;
    data['view_id'] = this.viewId;
    data['view_count'] = this.viewCount;
    data['share_text'] = this.shareText;
    return data;
  }
}