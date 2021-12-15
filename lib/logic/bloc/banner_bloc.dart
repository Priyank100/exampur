import 'package:bloc/bloc.dart';
import 'package:exampur_mobile/models/banner.dart';
import 'package:exampur_mobile/repositories/banner_repository.dart';
import 'banner_events.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepository repository;

  BannerBloc({required this.repository}) : super(BannerEmpty());

  @override
  Stream<BannerState> mapEventToState(BannerEvent event) async* {
    if (event is FetchBanner) {
      yield BannerLoading();
      try {
        final BannerList bannerList = await repository.fetcher();
        yield BannerLoaded(bannerList: bannerList);
      } catch (_) {
        yield BannerError();
      }
    }
  }
}
