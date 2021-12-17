import 'package:equatable/equatable.dart';
import 'package:exampur_mobile/models/demo_class.dart';

class DemoClassState extends Equatable {
  const DemoClassState();

  @override
  List<Object> get props => [];
}

class DemoClassEmpty extends DemoClassState {}

class DemoClassLoading extends DemoClassState {}

class DemoClassLoaded extends DemoClassState {
  final DemoClassList demoClassList;

  const DemoClassLoaded({required this.demoClassList});

  @override
  List<Object> get props => [demoClassList];
}

class DemoClassError extends DemoClassState {}
