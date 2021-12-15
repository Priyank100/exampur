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
  final User announcement;

  const UserLoaded({required this.announcement});

  @override
  List<Object> get props => [announcement];
}

class UserError extends UserState {}
