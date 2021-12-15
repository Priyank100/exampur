import 'dart:async';
import 'package:exampur_mobile/models/user.dart';
import 'user_api_client.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository({required this.userApiClient});

  Future<UserList> fetcher() async {
    return await userApiClient.fetcher();
  }
}
