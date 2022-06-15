import 'dart:convert';
/// id : 722
/// name : "News"
/// title : "UPSC-NDA/NA Exam 2/Final Result is Now Available!"
/// slug : "upsc-ndana-exam-2final-result-is-now-available"
/// content_module : [{"id":3031,"title":"UPSC","name":"UPSC","slug":"upsc","description":"<p dir=\"ltr\">On the 14th of June 2022, the Union Public Service Commission declared the <strong>final results of the National Defence Academy and Naval Academy Exam-2, 2021</strong> on their official website. Visit the Ministry of Defence&#39;s website, <a href=\"http://www.joinindianarmy.nic.in\" rel=\"noopener noreferrer\" target=\"_blank\">www.joinindianarmy.nic.in</a> , <a href=\"http://www.joinindiannavy.gov.in\" rel=\"noopener noreferrer\" target=\"_blank\">www.joinindiannavy.gov.in</a> , and <a href=\"http://www.careerindianairforce.cdac.in\" rel=\"noopener noreferrer\" target=\"_blank\">www.careerindianairforce.cdac.in</a> , to see the merit list of 462 qualifying candidates.</p><p dir=\"ltr\">How to check the result</p><p dir=\"ltr\">1. Visit the <a href=\"https://www.upsc.gov.in/\" rel=\"noopener noreferrer\" target=\"_blank\">Official Website</a>.</p><p dir=\"ltr\">2. Now, navigate for What&rsquo;s new where you have to click on &ldquo;Final Result: National Defence Academy and Naval Academy Examination (II), 2021&rdquo;</p><p dir=\"ltr\">3. After clicking on that a PDF will appear on your screen, download it for future use.</p><p dir=\"ltr\"><strong>Note that the Medical Examination results were not taken into account when compiling these lists.&nbsp;</strong></p><p dir=\"ltr\"><a href=\"https://www.upsc.gov.in/sites/default/files/FinalRes_PressNote_NDA_II_2021_140622_eng.pdf\" rel=\"noopener noreferrer\" target=\"_blank\">List of shortlisted candidates</a></p>","publish":true,"updated_on":"2022-06-15T10:46:50.411"}]

JobNotificationDetailModel jobNotificationDetailModelFromJson(String str) => JobNotificationDetailModel.fromJson(json.decode(str));
String jobNotificationDetailModelToJson(JobNotificationDetailModel data) => json.encode(data.toJson());

class JobNotificationDetailModel {
  JobNotificationDetailModel({
      int? id, 
      String? name, 
      String? title, 
      String? slug, 
      List<ContentModule>? contentModule,}){
    _id = id;
    _name = name;
    _title = title;
    _slug = slug;
    _contentModule = contentModule;
}

  JobNotificationDetailModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _title = json['title'];
    _slug = json['slug'];
    if (json['content_module'] != null) {
      _contentModule = [];
      json['content_module'].forEach((v) {
        _contentModule?.add(ContentModule.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _title;
  String? _slug;
  List<ContentModule>? _contentModule;

  int? get id => _id;
  String? get name => _name;
  String? get title => _title;
  String? get slug => _slug;
  List<ContentModule>? get contentModule => _contentModule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['title'] = _title;
    map['slug'] = _slug;
    if (_contentModule != null) {
      map['content_module'] = _contentModule?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 3031
/// title : "UPSC"
/// name : "UPSC"
/// slug : "upsc"
/// description : "<p dir=\"ltr\">On the 14th of June 2022, the Union Public Service Commission declared the <strong>final results of the National Defence Academy and Naval Academy Exam-2, 2021</strong> on their official website. Visit the Ministry of Defence&#39;s website, <a href=\"http://www.joinindianarmy.nic.in\" rel=\"noopener noreferrer\" target=\"_blank\">www.joinindianarmy.nic.in</a> , <a href=\"http://www.joinindiannavy.gov.in\" rel=\"noopener noreferrer\" target=\"_blank\">www.joinindiannavy.gov.in</a> , and <a href=\"http://www.careerindianairforce.cdac.in\" rel=\"noopener noreferrer\" target=\"_blank\">www.careerindianairforce.cdac.in</a> , to see the merit list of 462 qualifying candidates.</p><p dir=\"ltr\">How to check the result</p><p dir=\"ltr\">1. Visit the <a href=\"https://www.upsc.gov.in/\" rel=\"noopener noreferrer\" target=\"_blank\">Official Website</a>.</p><p dir=\"ltr\">2. Now, navigate for What&rsquo;s new where you have to click on &ldquo;Final Result: National Defence Academy and Naval Academy Examination (II), 2021&rdquo;</p><p dir=\"ltr\">3. After clicking on that a PDF will appear on your screen, download it for future use.</p><p dir=\"ltr\"><strong>Note that the Medical Examination results were not taken into account when compiling these lists.&nbsp;</strong></p><p dir=\"ltr\"><a href=\"https://www.upsc.gov.in/sites/default/files/FinalRes_PressNote_NDA_II_2021_140622_eng.pdf\" rel=\"noopener noreferrer\" target=\"_blank\">List of shortlisted candidates</a></p>"
/// publish : true
/// updated_on : "2022-06-15T10:46:50.411"

ContentModule contentModuleFromJson(String str) => ContentModule.fromJson(json.decode(str));
String contentModuleToJson(ContentModule data) => json.encode(data.toJson());
class ContentModule {
  ContentModule({
      int? id, 
      String? title, 
      String? name, 
      String? slug, 
      String? description, 
      bool? publish, 
      String? updatedOn,}){
    _id = id;
    _title = title;
    _name = name;
    _slug = slug;
    _description = description;
    _publish = publish;
    _updatedOn = updatedOn;
}

  ContentModule.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _name = json['name'];
    _slug = json['slug'];
    _description = json['description'];
    _publish = json['publish'];
    _updatedOn = json['updated_on'];
  }
  int? _id;
  String? _title;
  String? _name;
  String? _slug;
  String? _description;
  bool? _publish;
  String? _updatedOn;

  int? get id => _id;
  String? get title => _title;
  String? get name => _name;
  String? get slug => _slug;
  String? get description => _description;
  bool? get publish => _publish;
  String? get updatedOn => _updatedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['name'] = _name;
    map['slug'] = _slug;
    map['description'] = _description;
    map['publish'] = _publish;
    map['updated_on'] = _updatedOn;
    return map;
  }

}