import 'dart:async';
import 'package:exampur_mobile/models/banner.dart';
import 'banner_api_client.dart';

class BannerRepository {
  final BannerApiClient bannerApiClient;

  BannerRepository({required this.bannerApiClient});

  Future<BannerList> fetcher() async {
    return await bannerApiClient.fetcher();
  }
}
