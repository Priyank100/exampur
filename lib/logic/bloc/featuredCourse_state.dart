import 'package:equatable/equatable.dart';
import 'package:exampur_mobile/models/course.dart';

class FeaturedCourseState extends Equatable {
  const FeaturedCourseState();

  @override
  List<Object> get props => [];
}

class FeaturedCourseEmpty extends FeaturedCourseState {}

class FeaturedCourseLoading extends FeaturedCourseState {}

class FeaturedCourseLoaded extends FeaturedCourseState {
  final FeaturedCourseList featuredCourseList;

  const FeaturedCourseLoaded({required this.featuredCourseList});

  @override
  List<Object> get props => [featuredCourseList];
}


class FeaturedCourseError extends FeaturedCourseState {}
