part of 'banner_bloc.dart';

@immutable
sealed class BannerEvent {
  const BannerEvent();
}

class FetchBanners extends BannerEvent {
  final int? page;
  final int? limit;

  const FetchBanners({this.page = 3, this.limit = 5});
}
