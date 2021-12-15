import 'package:equatable/equatable.dart';
import 'package:exampur_mobile/models/user.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserEmpty extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserList userList;

  const UserLoaded({required this.userList});

  @override
  List<Object> get props => [userList];
}

class UserError extends UserState {}