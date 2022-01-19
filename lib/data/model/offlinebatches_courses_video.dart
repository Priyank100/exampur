class OfflinebatchesCoursesVideo {
  int? statusCode;
  Data? data;

  OfflinebatchesCoursesVideo({this.statusCode, this.data});

  OfflinebatchesCoursesVideo.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? bannerPath;
  String? logoPath;
  String? description;
  String? videoPath;
  int? amount;
  bool? isEmi;
  bool? isDemo;
  String? flag;
  List<Macro>? macro;
  List<Category>? category;
  List<CenterId>? centerId;
  int? monthDuration;

  Data(
      {this.sId,
        this.title,
        this.bannerPath,
        this.logoPath,
        this.description,
        this.videoPath,
        this.amount,
        this.isEmi,
        this.isDemo,
        this.flag,
        this.macro,
        this.category,
        this.centerId,
        this.monthDuration});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    bannerPath = json['banner_path'];
    logoPath = json['logo_path'];
    description = json['description'];
    videoPath = json['video_path'];
    amount = json['amount'];
    isEmi = json['is_emi'];
    isDemo = json['is_demo'];
    flag = json['flag'];
    if (json['macro'] != null) {
      macro = <Macro>[];
      json['macro'].forEach((v) {
        macro!.add(new Macro.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['center_id'] != null) {
      centerId = <CenterId>[];
      json['center_id'].forEach((v) {
        centerId!.add(new CenterId.fromJson(v));
      });
    }
    monthDuration = json['month_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['banner_path'] = this.bannerPath;
    data['logo_path'] = this.logoPath;
    data['description'] = this.description;
    data['video_path'] = this.videoPath;
    data['amount'] = this.amount;
    data['is_emi'] = this.isEmi;
    data['is_demo'] = this.isDemo;
    data['flag'] = this.flag;
    if (this.macro != null) {
      data['macro'] = this.macro!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.centerId != null) {
      data['center_id'] = this.centerId!.map((v) => v.toJson()).toList();
    }
    data['month_duration'] = this.monthDuration;
    return data;
  }
}

class Macro {
  String? icon;
  String? title;

  Macro({this.icon, this.title});

  Macro.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    return data;
  }
}

class Category {
  String? sId;
  String? name;

  Category({this.sId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class CenterId {
  String? sId;
  String? name;
  String? city;

  CenterId({this.sId, this.name, this.city});

  CenterId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['city'] = this.city;
    return data;
  }
}