import 'package:bloc/bloc.dart';
import 'package:exampur_mobile/models/user.dart';
import 'package:exampur_mobile/repositories/user_repository.dart';

import 'user_events.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc({required this.repository}) : super(UserEmpty());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUser) {
      yield UserLoading();
      try {
        final UserList userList = await repository.fetcher();
        yield UserLoaded(userList: userList);
      } catch (_) {
        yield UserError();
      }
    }
  }
}
