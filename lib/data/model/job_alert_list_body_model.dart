class JobAlertListBodyModel {
  String? alertCategoryId;
  List<String>? category;
  int? limit;
  int? skip;

  JobAlertListBodyModel(
      {this.alertCategoryId, this.category, this.limit, this.skip});

  JobAlertListBodyModel.fromJson(Map<String, dynamic> json) {
    alertCategoryId = json['alert_category_id'];
    category = json['category'].cast<String>();
    limit = json['limit'];
    skip = json['skip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alert_category_id'] = this.alertCategoryId;
    data['category'] = this.category;
    data['limit'] = this.limit;
    data['skip'] = this.skip;
    return data;
  }
}