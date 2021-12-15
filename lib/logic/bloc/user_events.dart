import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FetchUser extends UserEvent {

  const FetchUser();

  @override
  List<Object> get props => [];
}