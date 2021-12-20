import 'dart:convert';
import 'package:exampur_mobile/logic/globals.dart';
import 'package:exampur_mobile/logic/jwt_token.dart';
import 'package:exampur_mobile/models/my_course_schedule.dart';
import 'package:http/http.dart' as http;


class MyCourseScheduleApiClient {
  MyCourseScheduleApiClient();

  Future<MyCourseScheduleList> fetcher() async {
    MyCourseScheduleList _localList = new MyCourseScheduleList(myCourseScheduleList: []);
    String url = "${Globals.baseUrl}/myCourseSchedule";
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{'authorization': jwt.jwtToken},
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('got no response ' + response.body);
      throw Exception('Sorry fetching imp myCourseSchedule failed');
    }
    return _localList;
  }
}
