import 'package:equatable/equatable.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();
}

class FetchBanner extends BannerEvent {
  const FetchBanner();

  @override
  List<Object> get props => [];
}