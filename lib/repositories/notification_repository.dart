import 'dart:async';
import 'package:exampur_mobile/models/notification.dart';

import 'notification_api_client.dart';

class NotificationRepository {
  final NotificationApiClient notificationApiClient;

  NotificationRepository({required this.notificationApiClient});

  Future<NotificationList> fetcher() async {
    return await notificationApiClient.fetcher();
  }
}
