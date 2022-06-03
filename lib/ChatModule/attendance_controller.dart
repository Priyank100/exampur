import 'package:exampur_mobile/ChatModule/live_attendance.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class AttendanceController {

  static String URL = "https://script.google.com/macros/s/AKfycbyg1AlqDUmuzMH_cZDpBsmie2gvUD91oTDZo4T5jhwNS2SLFLSkDGs4Psve-XxSgs3ilg/exec";
  static String STATUS_SUCCESS = "SUCCESS";

  static void submitAttendance(LiveAttendance liveAttendance, void Function(String) callback) async {
    try {
      await http.post(Uri.parse(URL), body: liveAttendance.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      AppConstants.printLog(e);
    }
  }
}