import 'dart:convert';
import 'package:exampur_mobile/logic/globals.dart';
import 'package:exampur_mobile/models/notification.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class NotificationApiClient {
  NotificationApiClient();

  Future<NotificationList> fetcher() async {
    NotificationList _localList = new NotificationList(notificationList: []);
    String url = "$baseUrl/notification";
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
      throw Exception('Sorry fetching imp notification failed');
    }
    return _localList;
  }
}
