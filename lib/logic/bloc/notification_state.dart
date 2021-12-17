import 'package:equatable/equatable.dart';
import 'package:exampur_mobile/models/notification.dart';
import 'package:exampur_mobile/models/notification.dart';

class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationEmpty extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final NotificationList notificationList;

  const NotificationLoaded({required this.notificationList});

  @override
  List<Object> get props => [notificationList];
}

class NotificationError extends NotificationState {}
