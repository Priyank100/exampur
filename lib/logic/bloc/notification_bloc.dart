import 'package:bloc/bloc.dart';
import 'package:exampur_mobile/models/notification.dart';
import 'package:exampur_mobile/repositories/notification_repository.dart';
import 'notification_events.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;

  NotificationBloc({required this.repository}) : super(NotificationEmpty());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is FetchNotification) {
      yield NotificationLoading();
      try {
        final NotificationList notificationList = await repository.fetcher();
        yield NotificationLoaded(notificationList: notificationList);
      } catch (_) {
        yield NotificationError();
      }
    }
  }
}
