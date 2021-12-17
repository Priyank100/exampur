import 'package:bloc/bloc.dart';
import 'package:exampur_mobile/models/course.dart';
import 'package:exampur_mobile/repositories/featured_course_repository.dart';
import 'featured_course_events.dart';
import 'featuredCourse_state.dart';

class FeaturedCourseBloc extends Bloc<FeaturedCourseEvent, FeaturedCourseState> {
  final FeaturedCourseRepository repository;

  FeaturedCourseBloc({required this.repository}) : super(FeaturedCourseEmpty());

  @override
  Stream<FeaturedCourseState> mapEventToState(FeaturedCourseEvent event) async* {
    if (event is FetchFeaturedCourse) {
      yield FeaturedCourseLoading();
      try {
        final FeaturedCourseList featuredCourseList = await repository.fetcher();
        yield FeaturedCourseLoaded(featuredCourseList: featuredCourseList);
      } catch (_) {
        yield FeaturedCourseError();
      }
    }
  }
}
