import 'package:bloc/bloc.dart';
import 'package:exampur_mobile/logic/bloc/user_events.dart';
import 'package:exampur_mobile/logic/bloc/user_state.dart';
import 'package:exampur_mobile/models/user.dart';
import 'package:exampur_mobile/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc({required this.repository}) : super(UserEmpty());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUser) {
      yield UserLoading();
      try {
        final User announcement = await repository.fetcher();
        yield UserLoaded(announcement: announcement);
      } catch (_) {
        yield UserError();
      }
    }
  }
}
