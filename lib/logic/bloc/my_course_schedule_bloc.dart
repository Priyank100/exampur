import 'package:bloc/bloc.dart';
import 'package:exampur_mobile/models/my_course_schedule.dart';
import 'package:exampur_mobile/repositories/my_course_schedule_repository.dart';
import 'my_course_schedule_events.dart';
import 'my_course_schedule_state.dart';

class MyCourseScheduleBloc extends Bloc<MyCourseScheduleEvent, MyCourseScheduleState> {
  final MyCourseScheduleRepository repository;

  MyCourseScheduleBloc({required this.repository}) : super(MyCourseScheduleEmpty());

  @override
  Stream<MyCourseScheduleState> mapEventToState(MyCourseScheduleEvent event) async* {
    if (event is FetchMyCourseSchedule) {
      yield MyCourseScheduleLoading();
      try {
        final MyCourseScheduleList myCourseScheduleList = await repository.fetcher();
        if (myCourseScheduleList.myCourseScheduleList.isEmpty) {
          yield MyCourseScheduleEmpty();
        }
        yield MyCourseScheduleLoaded(myCourseScheduleList: myCourseScheduleList);
      } catch (_) {
        yield MyCourseScheduleError();
      }
    }
  }
}
