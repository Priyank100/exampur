import 'package:equatable/equatable.dart';
import 'package:exampur_mobile/models/my_course_schedule.dart';

class MyCourseScheduleState extends Equatable {
  const MyCourseScheduleState();

  @override
  List<Object> get props => [];
}

class MyCourseScheduleEmpty extends MyCourseScheduleState {}

class MyCourseScheduleLoading extends MyCourseScheduleState {}

class MyCourseScheduleLoaded extends MyCourseScheduleState {
  final MyCourseScheduleList myCourseScheduleList;

  const MyCourseScheduleLoaded({required this.myCourseScheduleList});

  @override
  List<Object> get props => [myCourseScheduleList];
}

class MyCourseScheduleError extends MyCourseScheduleState {}
