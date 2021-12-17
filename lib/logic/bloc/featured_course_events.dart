import 'package:equatable/equatable.dart';

abstract class FeaturedCourseEvent extends Equatable {
  const FeaturedCourseEvent();
}

class FetchFeaturedCourse extends FeaturedCourseEvent {
  const FetchFeaturedCourse();

  @override
  List<Object> get props => [];
}