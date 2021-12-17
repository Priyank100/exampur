import 'dart:async';
import 'package:exampur_mobile/models/course.dart';
import 'featured_course_api_client.dart';

class FeaturedCourseRepository {
  final FeaturedCourseApiClient featuredCourseApiClient;

  FeaturedCourseRepository({required this.featuredCourseApiClient});

  Future<FeaturedCourseList> fetcher() async {
    return await featuredCourseApiClient.fetcher();
  }
}
