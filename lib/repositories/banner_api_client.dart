import 'dart:convert';
import 'package:exampur_mobile/logic/globals.dart';
import 'package:exampur_mobile/models/banner.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class BannerApiClient {
  BannerApiClient();

  Future<BannerList> fetcher() async {
    BannerList _localList = new BannerList(bannerList: []);
    String url = "${baseUrl}/banner";
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
      throw Exception('Sorry fetching imp banner failed');
    }
    return _localList;
  }
}
