/// id : 3
/// super_category : "Exam Wise Study Material"
/// category : [{"id":32,"name":"UP Lekhpal","slug":"up-lekhpal"},{"id":50,"name":"SSC GD","slug":"ssc-gd"},{"id":51,"name":"Up Constable","slug":"up-constabel-samany-hindi"},{"id":52,"name":"UPSSSC PET","slug":"upsssc-pet"},{"id":43,"name":"SUPER TET","slug":"super-tet-ebook"},{"id":35,"name":"NDA EXAM","slug":"nda-exam"},{"id":26,"name":"CTET","slug":"ctet"}]

class StudyMaterialNewModel {
  StudyMaterialNewModel({
      int? id, 
      String? superCategory, 
      List<Category>? category,}){
    _id = id;
    _superCategory = superCategory;
    _category = category;
}

  StudyMaterialNewModel.fromJson(dynamic json) {
    _id = json['id'];
    _superCategory = json['super_category'];
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(Category.fromJson(v));
      });
    }
  }
  int? _id;
  String? _superCategory;
  List<Category>? _category;

  int? get id => _id;
  String? get superCategory => _superCategory;
  List<Category>? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['super_category'] = _superCategory;
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 32
/// name : "UP Lekhpal"
/// slug : "up-lekhpal"

class Category {
  Category({
      int? id, 
      String? name, 
      String? slug,}){
    _id = id;
    _name = name;
    _slug = slug;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
  }
  int? _id;
  String? _name;
  String? _slug;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    return map;
  }

}