class SamplingBottomSheetParam {

  static Map<String, dynamic> _deliveryDetailParam = {};
  static List<String> _featuresList = [];

  static Map<String, dynamic> get getDeliveryDetailParam => _deliveryDetailParam;
  static List<String> get getFeaturesList => _featuresList;

  static set setDeliveryDetailParam(Map<String, dynamic> value) {
    _deliveryDetailParam = value;
  }

  static set setFeaturesList(List<String> value) {
    _featuresList = value;
  }

}