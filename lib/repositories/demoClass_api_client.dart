import 'package:exampur_mobile/logic/globals.dart';
import 'package:exampur_mobile/models/demo_class.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class DemoClassApiClient {
  DemoClassApiClient();

  Future<DemoClassList> fetcher() async {
    DemoClassList _localList = new DemoClassList(demoClassList: []);
    String url = "$baseUrl/demoClass";
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
      throw Exception('Sorry fetching imp demoClass failed');
    }
    return _localList;
  }
}
