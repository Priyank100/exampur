import 'dart:convert';
import 'package:exampur_mobile/models/course.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class FeaturedCourseApiClient {
  FeaturedCourseApiClient();

  Future<FeaturedCourseList> fetcher() async {
    FeaturedCourseList _localList =
        new FeaturedCourseList(featuredCourseList: []);
    String url = "$baseUrl/featuredCourse";
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'authorization': jwtToken,
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('got no response ' + response.body);
      throw Exception('Sorry fetching imp featuredCourse failed');
    }
    return _localList;
  }
}
