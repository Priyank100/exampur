import 'dart:async';
import 'package:exampur_mobile/models/my_course_schedule.dart';
import 'my_course_schedule_api_client.dart';

class MyCourseScheduleRepository {
  final MyCourseScheduleApiClient myCourseScheduleApiClient;

  MyCourseScheduleRepository({required this.myCourseScheduleApiClient});

  Future<MyCourseScheduleList> fetcher() async {
    return await myCourseScheduleApiClient.fetcher();
  }
}
