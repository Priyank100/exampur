import 'dart:async';
import 'package:exampur_mobile/models/demo_class.dart';
import 'demoClass_api_client.dart';

class DemoClassRepository {
  final DemoClassApiClient demoClassApiClient;

  DemoClassRepository({required this.demoClassApiClient});

  Future<DemoClassList> fetcher() async {
    return await demoClassApiClient.fetcher();
  }
}