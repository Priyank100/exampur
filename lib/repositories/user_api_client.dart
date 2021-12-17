import 'dart:convert';
import 'package:exampur_mobile/logic/globals.dart';
import 'package:exampur_mobile/models/user.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class UserApiClient {
  UserApiClient();

  Future<User> fetcher() async {
    User temp;
    String url = "$baseUrl/user";
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'authorization': jwtToken,
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      temp = userFromJson(response.body);
    } else {
      print('got no response ' + response.body);
      throw Exception('Sorry fetching imp user failed');
    }
    return temp;
  }
}
