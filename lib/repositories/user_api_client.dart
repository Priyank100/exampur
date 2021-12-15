import 'dart:convert';
import 'package:exampur_mobile/models/user.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class UserApiClient {
  UserApiClient();

  Future<User> fetcher() async {
    late User _localList; //= new UserList(userList: []);
    String url = '$baseUrl/user';
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'authorization': jwtToken,
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      User temp=User(phoneExt: "phoneExt", phone: "phone", firstName: "firstName", lastName: "lastName", language: "language", emailId: "emailId", city: "city", state: "state", country: "country", emailConf: false, phoneConf: false);
      _localList = temp;
    } else {
      print('got no response ' + response.body);
      throw Exception('Sorry fetching imp user failed');
    }
    return _localList;
  }
}
