import 'package:equatable/equatable.dart';
import 'package:exampur_mobile/models/banner.dart';

class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerEmpty extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final BannerList bannerList;

  const BannerLoaded({required this.bannerList});

  @override
  List<Object> get props => [bannerList];
}

class BannerError extends BannerState {}
