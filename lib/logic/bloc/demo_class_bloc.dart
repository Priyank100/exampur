import 'package:bloc/bloc.dart';
import 'package:exampur_mobile/models/demo_class.dart';
import 'package:exampur_mobile/repositories/demo_class_repository.dart';
import 'demo_class_events.dart';
import 'demoClass_state.dart';

class DemoClassBloc extends Bloc<DemoClassEvent, DemoClassState> {
  final DemoClassRepository repository;

  DemoClassBloc({required this.repository}) : super(DemoClassEmpty());

  @override
  Stream<DemoClassState> mapEventToState(DemoClassEvent event) async* {
    if (event is FetchDemoClass) {
      yield DemoClassLoading();
      try {
        final DemoClassList demoClassList = await repository.fetcher();
        yield DemoClassLoaded(demoClassList: demoClassList);
      } catch (_) {
        yield DemoClassError();
      }
    }
  }
}
