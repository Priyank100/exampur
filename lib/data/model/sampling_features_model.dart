import 'dart:convert';
/// statusCode : 200
/// data : {"features":["500+ Interactive Videos","500+ Live Videos","500+ Chapter Notes","500+ Test Series"]}

SamplingFeaturesModel samplingFeaturesFromJson(String str) => SamplingFeaturesModel.fromJson(json.decode(str));
String samplingFeaturesToJson(SamplingFeaturesModel data) => json.encode(data.toJson());
class SamplingFeaturesModel {
  SamplingFeaturesModel({
      num? statusCode,
    SamplingData? data,}){
    _statusCode = statusCode;
    _data = data;
}

  SamplingFeaturesModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _data = json['data'] != null ? SamplingData.fromJson(json['data']) : null;
  }
  num? _statusCode;
  SamplingData? _data;
  SamplingFeaturesModel copyWith({  num? statusCode,
  SamplingData? data,
}) => SamplingFeaturesModel(  statusCode: statusCode ?? _statusCode,
  data: data ?? _data,
);
  num? get statusCode => _statusCode;
  SamplingData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// features : ["500+ Interactive Videos","500+ Live Videos","500+ Chapter Notes","500+ Test Series"]

SamplingData dataFromJson(String str) => SamplingData.fromJson(json.decode(str));
String dataToJson(SamplingData data) => json.encode(data.toJson());
class SamplingData {
  SamplingData({
      List<String>? features,}){
    _features = features;
}

  SamplingData.fromJson(dynamic json) {
    _features = json['features'] != null ? json['features'].cast<String>() : [];
  }
  List<String>? _features;
  SamplingData copyWith({  List<String>? features,
}) => SamplingData(  features: features ?? _features,
);
  List<String>? get features => _features;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['features'] = _features;
    return map;
  }

}