import 'package:equatable/equatable.dart';

abstract class MyCourseScheduleEvent extends Equatable {
  const MyCourseScheduleEvent();
}

class FetchMyCourseSchedule extends MyCourseScheduleEvent {
  const FetchMyCourseSchedule();

  @override
  List<Object> get props => [];
}