import 'package:equatable/equatable.dart';

abstract class DemoClassEvent extends Equatable {
  const DemoClassEvent();
}

class FetchDemoClass extends DemoClassEvent {
  const FetchDemoClass();

  @override
  List<Object> get props => [];
}