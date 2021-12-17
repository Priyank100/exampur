import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class FetchNotification extends NotificationEvent {
  const FetchNotification();

  @override
  List<Object> get props => [];
}