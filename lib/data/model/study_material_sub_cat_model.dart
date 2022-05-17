import 'dart:convert';
/// id : 32
/// category_name : "UP Lekhpal"
/// sub_category : [{"id":67,"name":"उत्तर प्रदेश सामान्य ज्ञान","category":[{"id":769,"title":"उत्तरप्रदेश  स्मरणीय तथ्य","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-1_1%E0%A4%89%E0%A4%A4%E0%A4%A4%E0%A4%B0%E0%A4%AA%E0%A4%B0%E0%A4%A6%E0%A4%B6__%E0%A4%B8%E0%A4%AE%E0%A4%B0%E0%A4%A3%E0%A4%AF_%E0%A4%A4%E0%A4%A5%E0%A4%AF.pdf"}]},{"id":66,"name":"हिंदी","category":[{"id":740,"title":"हिंदी भाषा का विकास एवं देवनागरी लिपि","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_1_%E0%A4%B9%E0%A4%A6_%E0%A4%AD%E0%A4%B7_%E0%A4%95_%E0%A4%B5%E0%A4%95%E0%A4%B8_%E0%A4%8F%E0%A4%B5_%E0%A4%A6%E0%A4%B5%E0%A4%A8%E0%A4%97%E0%A4%B0_%E0%A4%B2%E0%A4%AA.pdf"},{"id":741,"title":"वर्णमाला","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_2_%E0%A4%B5%E0%A4%B0%E0%A4%A3%E0%A4%AE%E0%A4%B2.pdf"},{"id":742,"title":"वर्तनी","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_4__%E0%A4%B8%E0%A4%A8%E0%A4%A7.pdf"},{"id":744,"title":"सन्धि","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_4__%E0%A4%B8%E0%A4%A8%E0%A4%A7_dvapZjR.pdf"},{"id":747,"title":"उपसर्ग एवं प्रत्यय","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_5_%E0%A4%89%E0%A4%AA%E0%A4%B8%E0%A4%B0%E0%A4%97_%E0%A4%8F%E0%A4%B5_%E0%A4%AA%E0%A4%B0%E0%A4%A4%E0%A4%AF%E0%A4%AF.pdf"},{"id":748,"title":"समास","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_6_%E0%A4%B8%E0%A4%AE%E0%A4%B8.pdf"},{"id":749,"title":"शब्द भेद, तत्सम -तद्भव","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_7_%E0%A4%B6%E0%A4%AC%E0%A4%A6_%E0%A4%AD%E0%A4%A6_%E0%A4%A4%E0%A4%A4%E0%A4%B8%E0%A4%AE_-%E0%A4%A4%E0%A4%A6%E0%A4%AD%E0%A4%B5.pdf"},{"id":750,"title":"संज्ञा से अव्यय तक","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_8_%E0%A4%B8%E0%A4%9C%E0%A4%9E_%E0%A4%B8_%E0%A4%85%E0%A4%B5%E0%A4%AF%E0%A4%AF_%E0%A4%A4%E0%A4%95.pdf"},{"id":751,"title":"पर्यायवाची शब्द","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_9_%E0%A4%AA%E0%A4%B0%E0%A4%AF%E0%A4%AF%E0%A4%B5%E0%A4%9A_%E0%A4%B6%E0%A4%AC%E0%A4%A6.pdf"},{"id":752,"title":"विपरीतार्थक या विलोम शब्द","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_10_%E0%A4%B5%E0%A4%AA%E0%A4%B0%E0%A4%A4%E0%A4%B0%E0%A4%A5%E0%A4%95_%E0%A4%AF_%E0%A4%B5%E0%A4%B2%E0%A4%AE_%E0%A4%B6%E0%A4%AC%E0%A4%A6.pdf"},{"id":753,"title":"वाक्यंश के लिए एक शब्द","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_11_%E0%A4%B5%E0%A4%95%E0%A4%AF%E0%A4%B6_%E0%A4%95_%E0%A4%B2%E0%A4%8F_%E0%A4%8F%E0%A4%95_%E0%A4%B6%E0%A4%AC%E0%A4%A6.pdf"},{"id":754,"title":"रिक्त स्थानों की पूर्ति","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_12_%E0%A4%B0%E0%A4%95%E0%A4%A4_%E0%A4%B8%E0%A4%A5%E0%A4%A8_%E0%A4%95_%E0%A4%AA%E0%A4%B0%E0%A4%A4.pdf"},{"id":755,"title":"वाक्य भेद","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_13_%E0%A4%B5%E0%A4%95%E0%A4%AF_%E0%A4%AD%E0%A4%A6.pdf"},{"id":756,"title":"वाक्य शुद्धि","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_14_%E0%A4%B5%E0%A4%95%E0%A4%AF_%E0%A4%B6%E0%A4%A6%E0%A4%A7.pdf"},{"id":757,"title":"मुहावरे एवं लोकोक्तियाँ","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_15_%E0%A4%AE%E0%A4%B9%E0%A4%B5%E0%A4%B0_%E0%A4%8F%E0%A4%B5_%E0%A4%B2%E0%A4%95%E0%A4%95%E0%A4%A4%E0%A4%AF.pdf"},{"id":758,"title":"क्रमबध्दता","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_16_%E0%A4%95%E0%A4%B0%E0%A4%AE%E0%A4%AC%E0%A4%A7%E0%A4%A6%E0%A4%A4.pdf"},{"id":759,"title":"पाठ बोधन","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_17_%E0%A4%AA%E0%A4%A0_%E0%A4%AC%E0%A4%A7%E0%A4%A8.pdf"},{"id":760,"title":"शब्द शक्ति","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_18_%E0%A4%B6%E0%A4%AC%E0%A4%A6_%E0%A4%B6%E0%A4%95%E0%A4%A4.pdf"},{"id":761,"title":"रस","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_19_%E0%A4%B0%E0%A4%B8.pdf"},{"id":762,"title":"छंद","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_20_%E0%A4%9B%E0%A4%A6.pdf"},{"id":763,"title":"अलंकार","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_21_%E0%A4%85%E0%A4%B2%E0%A4%95%E0%A4%B0.pdf"},{"id":764,"title":"हिंदी साहित्य का सामान्य परिचय","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-_22_%E0%A4%B9%E0%A4%A6_%E0%A4%B8%E0%A4%B9%E0%A4%A4%E0%A4%AF_%E0%A4%95_%E0%A4%B8%E0%A4%AE%E0%A4%A8%E0%A4%AF_%E0%A4%AA%E0%A4%B0%E0%A4%9A%E0%A4%AF.pdf"}]},{"id":36,"name":"गणित","category":[{"id":354,"title":"संख्या पद्धति (Number System)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_1.pdf"},{"id":356,"title":"प्रतिशतता (Precentage)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_2_qTGrKSo.pdf"},{"id":357,"title":"लाभ तथा हानि (Profit and Loss)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_3.pdf"},{"id":358,"title":"सांख्यिकीय ऑकड़ो  का वर्गीकरण (Classification of Statistical Data)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_4.pdf"},{"id":359,"title":"बारंबारता एवं संचयी बारंबारता (Frequency and Cumulative Frequency)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_5.pdf"},{"id":360,"title":"आँकड़ों की प्रस्तुति) Presentation of Data","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_6.pdf"},{"id":361,"title":"केंद्रीय मापें  (माध्य, माध्यिका एवं  बहुलक) [Central Tendency (Mean, Median and Mode)]","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_7.pdf"},{"id":362,"title":"युगपत समीकरण (Simultaneous Equations)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_9.pdf"},{"id":363,"title":"द्विघात समीकरण (Quadratic Equations)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_10_pdf.pdf"},{"id":364,"title":"गुणनखंड (Factors)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_11.pdf"},{"id":365,"title":"क्षेत्र प्रमेय (Area Theorem)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_12.pdf"},{"id":366,"title":"त्रिभुज संबंधित पाइथागोरस प्रमेय (Pythagoras Theorem Related to Triangle)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_13.pdf"},{"id":367,"title":"त्रिभुज (Triangles)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_14.pdf"},{"id":368,"title":"आयत (rectangle)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_15.pdf"},{"id":369,"title":"वर्ग (Square)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_16.pdf"},{"id":370,"title":"समलंब (Trapezium)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_17.pdf"},{"id":371,"title":"समांतर चतुर्भुज (parallelogram)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_18_1.pdf"},{"id":372,"title":"समचतुर्भुज (Rhombus)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_19.pdf"},{"id":373,"title":"वृत्त की परिधि और क्षेत्रफल (Circumference and Area of Circle)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_20.pdf"},{"id":374,"title":"विविध (Miscellaneous)","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/UP_Lekhpal_Gaint_Ch_21.pdf"}]},{"id":79,"name":"उत्तर प्रदेश (ग्राम समाज एवं विकास )","category":[{"id":836,"title":"पंचवर्षीय योजनाएँ (कृषि विशेष तथ्य )","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/11-%E0%A4%AA%E0%A4%9A%E0%A4%B5%E0%A4%B0%E0%A4%B7%E0%A4%AF_%E0%A4%AF%E0%A4%9C%E0%A4%A8%E0%A4%8F_%E0%A4%95%E0%A4%B7_%E0%A4%B5%E0%A4%B6%E0%A4%B7_%E0%A4%A4%E0%A4%A5%E0%A4%AF_.pdf"},{"id":826,"title":"ग्राम सभा एवं पंचायती राज","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/1-%E0%A4%97%E0%A4%B0%E0%A4%AE_%E0%A4%B8%E0%A4%AD_%E0%A4%8F%E0%A4%B5_%E0%A4%AA%E0%A4%9A%E0%A4%AF%E0%A4%A4_%E0%A4%B0%E0%A4%9C.pdf"},{"id":827,"title":"कृषि से सम्बन्धित महत्त्वपूर्ण शब्दावलियाँ एवं क्रांतियाँ","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/2-%E0%A4%95%E0%A4%B7_%E0%A4%B8_%E0%A4%B8%E0%A4%AE%E0%A4%AC%E0%A4%A8%E0%A4%A7%E0%A4%A4_%E0%A4%AE%E0%A4%B9%E0%A4%A4%E0%A4%A4%E0%A4%B5%E0%A4%AA%E0%A4%B0%E0%A4%A3_%E0%A4%B6%E0%A4%AC%E0%A4%A6%E0%A4%B5%E0%A4%B2%E0%A4%AF_%E0%A4%8F%E0%A4%B5_%E0%A4%95%E0%A4%B0%E0%A4%A4%E0%A4%AF.pdf"},{"id":828,"title":"भूमि बन्दोबस्त और भूमि पैमाइश","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/3-%E0%A4%AD%E0%A4%AE_%E0%A4%AC%E0%A4%A8%E0%A4%A6%E0%A4%AC%E0%A4%B8%E0%A4%A4_%E0%A4%94%E0%A4%B0_%E0%A4%AD%E0%A4%AE_%E0%A4%AA%E0%A4%AE%E0%A4%87%E0%A4%B6.pdf"},{"id":829,"title":"ग्रामीण क्षेत्र में केंद्र सरकार की योजनाएँ","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/4-_%E0%A4%97%E0%A4%B0%E0%A4%AE%E0%A4%A3_%E0%A4%95%E0%A4%B7%E0%A4%A4%E0%A4%B0_%E0%A4%AE_%E0%A4%95%E0%A4%A6%E0%A4%B0_%E0%A4%B8%E0%A4%B0%E0%A4%95%E0%A4%B0_%E0%A4%95_%E0%A4%AF%E0%A4%9C%E0%A4%A8%E0%A4%8F.pdf"},{"id":830,"title":"पशुपालन एवं पशुगणना","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/5-%E0%A4%AA%E0%A4%B6%E0%A4%AA%E0%A4%B2%E0%A4%A8_%E0%A4%8F%E0%A4%B5_%E0%A4%AA%E0%A4%B6%E0%A4%97%E0%A4%A3%E0%A4%A8.pdf"},{"id":831,"title":"ग्रामीण क्षेत्र में उत्तर प्रदेश सरकार की योजनाएँ","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/6-%E0%A4%97%E0%A4%B0%E0%A4%AE%E0%A4%A3_%E0%A4%95%E0%A4%B7%E0%A4%A4%E0%A4%B0_%E0%A4%AE_%E0%A4%89%E0%A4%A4%E0%A4%A4%E0%A4%B0_%E0%A4%AA%E0%A4%B0%E0%A4%A6%E0%A4%B6_%E0%A4%B8%E0%A4%B0%E0%A4%95%E0%A4%B0_%E0%A4%95_%E0%A4%AF%E0%A4%9C%E0%A4%A8%E0%A4%8F.pdf"},{"id":832,"title":"ग्रामीण विकास में डिजिटल समन्वय","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/7-%E0%A4%97%E0%A4%B0%E0%A4%AE%E0%A4%A3_%E0%A4%B5%E0%A4%95%E0%A4%B8_%E0%A4%AE_%E0%A4%A1%E0%A4%9C%E0%A4%9F%E0%A4%B2_%E0%A4%B8%E0%A4%AE%E0%A4%A8%E0%A4%B5%E0%A4%AF.pdf"},{"id":833,"title":"भरतीय कृषि व्यवस्था एवं महत्त्वपूर्ण कृषि आन्दोलन","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/8-%E0%A4%AD%E0%A4%B0%E0%A4%A4%E0%A4%AF_%E0%A4%95%E0%A4%B7_%E0%A4%B5%E0%A4%AF%E0%A4%B5%E0%A4%B8%E0%A4%A5_%E0%A4%8F%E0%A4%B5_%E0%A4%AE%E0%A4%B9%E0%A4%A4%E0%A4%A4%E0%A4%B5%E0%A4%AA%E0%A4%B0%E0%A4%A3_%E0%A4%95%E0%A4%B7_%E0%A4%86%E0%A4%A8%E0%A4%A6%E0%A4%B2%E0%A4%A8.pdf"},{"id":834,"title":"राजस्व परिषद","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/9-%E0%A4%B0%E0%A4%9C%E0%A4%B8%E0%A4%B5_%E0%A4%AA%E0%A4%B0%E0%A4%B7%E0%A4%A6.pdf"},{"id":835,"title":"उत्तर प्रदेश की मिट्टीयां","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/10-%E0%A4%89%E0%A4%A4%E0%A4%A4%E0%A4%B0_%E0%A4%AA%E0%A4%B0%E0%A4%A6%E0%A4%B6_%E0%A4%95_%E0%A4%AE%E0%A4%9F%E0%A4%9F%E0%A4%AF.pdf"},{"id":837,"title":"सिंचाई पध्दति व्यवस्था","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/12-%E0%A4%B8%E0%A4%9A%E0%A4%88_%E0%A4%AA%E0%A4%A7%E0%A4%A6%E0%A4%A4_%E0%A4%B5%E0%A4%AF%E0%A4%B5%E0%A4%B8%E0%A4%A5.pdf"},{"id":838,"title":"उत्तर प्रदेश वन रिपोर्ट -2019","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/13-%E0%A4%89%E0%A4%A4%E0%A4%A4%E0%A4%B0_%E0%A4%AA%E0%A4%B0%E0%A4%A6%E0%A4%B6_%E0%A4%B5%E0%A4%A8_%E0%A4%B0%E0%A4%AA%E0%A4%B0%E0%A4%9F_-2019.pdf"},{"id":839,"title":"जनगणना (2011) एवं जनसांख्यिकी रेखाचित्र (उत्तर प्रदेश के संदर्भ में )","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/14-_%E0%A4%9C%E0%A4%A8%E0%A4%97%E0%A4%A3%E0%A4%A8_2011_%E0%A4%8F%E0%A4%B5_%E0%A4%9C%E0%A4%A8%E0%A4%B8%E0%A4%96%E0%A4%AF%E0%A4%95_%E0%A4%B0%E0%A4%96%E0%A4%9A%E0%A4%A4%E0%A4%B0_%E0%A4%89%E0%A4%A4%E0%A4%A4%E0%A4%B0_%E0%A4%AA%E0%A4%B0%E0%A4%A6%E0%A4%B6_%E0%A4%95_%E0%A4%B8%E0%A4%A6%E0%A4%B0%E0%A4%AD_%E0%A4%AE_.pdf"},{"id":840,"title":"उत्तर प्रदेश विशेष एक नजर में","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/15-%E0%A4%89%E0%A4%A4%E0%A4%A4%E0%A4%B0_%E0%A4%AA%E0%A4%B0%E0%A4%A6%E0%A4%B6_%E0%A4%B5%E0%A4%B6%E0%A4%B7_%E0%A4%8F%E0%A4%95_%E0%A4%A8%E0%A4%9C%E0%A4%B0_%E0%A4%AE.pdf"}]}]

StudyMaterialSubCatModel studyMaterialSubCatModelFromJson(String str) => StudyMaterialSubCatModel.fromJson(json.decode(str));
String studyMaterialSubCatModelToJson(StudyMaterialSubCatModel data) => json.encode(data.toJson());

class StudyMaterialSubCatModel {
  StudyMaterialSubCatModel({
      int? id, 
      String? categoryName, 
      List<SubCategory>? subCategory,}){
    _id = id;
    _categoryName = categoryName;
    _subCategory = subCategory;
}

  StudyMaterialSubCatModel.fromJson(dynamic json) {
    _id = json['id'];
    _categoryName = json['category_name'];
    if (json['sub_category'] != null) {
      _subCategory = [];
      json['sub_category'].forEach((v) {
        _subCategory?.add(SubCategory.fromJson(v));
      });
    }
  }
  int? _id;
  String? _categoryName;
  List<SubCategory>? _subCategory;

  int? get id => _id;
  String? get categoryName => _categoryName;
  List<SubCategory>? get subCategory => _subCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_name'] = _categoryName;
    if (_subCategory != null) {
      map['sub_category'] = _subCategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 67
/// name : "उत्तर प्रदेश सामान्य ज्ञान"
/// category : [{"id":769,"title":"उत्तरप्रदेश  स्मरणीय तथ्य","file_path":"https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-1_1%E0%A4%89%E0%A4%A4%E0%A4%A4%E0%A4%B0%E0%A4%AA%E0%A4%B0%E0%A4%A6%E0%A4%B6__%E0%A4%B8%E0%A4%AE%E0%A4%B0%E0%A4%A3%E0%A4%AF_%E0%A4%A4%E0%A4%A5%E0%A4%AF.pdf"}]

SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));
String subCategoryToJson(SubCategory data) => json.encode(data.toJson());
class SubCategory {
  SubCategory({
      int? id, 
      String? name, 
      List<Category>? category,}){
    _id = id;
    _name = name;
    _category = category;
}

  SubCategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(Category.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  List<Category>? _category;

  int? get id => _id;
  String? get name => _name;
  List<Category>? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 769
/// title : "उत्तरप्रदेश  स्मरणीय तथ्य"
/// file_path : "https://testwale.s3.amazonaws.com/media/pdf-content/Chapter_-1_1%E0%A4%89%E0%A4%A4%E0%A4%A4%E0%A4%B0%E0%A4%AA%E0%A4%B0%E0%A4%A6%E0%A4%B6__%E0%A4%B8%E0%A4%AE%E0%A4%B0%E0%A4%A3%E0%A4%AF_%E0%A4%A4%E0%A4%A5%E0%A4%AF.pdf"

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      int? id, 
      String? title, 
      String? filePath,}){
    _id = id;
    _title = title;
    _filePath = filePath;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _filePath = json['file_path'];
  }
  int? _id;
  String? _title;
  String? _filePath;

  int? get id => _id;
  String? get title => _title;
  String? get filePath => _filePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['file_path'] = _filePath;
    return map;
  }

}