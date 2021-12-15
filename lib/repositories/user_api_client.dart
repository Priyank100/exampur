import 'dart:convert';
import 'package:exampur_mobile/models/user.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class UserApiClient {
  UserApiClient();

  Future<UserList> fetcher() async {
    UserList _localList = new UserList(userList: []);
    String url = "$baseUrl";
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'authorization': jwtToken,
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = jsonDecode(response.body);

    } else {
      print('got no response ' + response.body);
      throw Exception('Sorry fetching imp user failed');
    }
    return _localList;
  }
}
