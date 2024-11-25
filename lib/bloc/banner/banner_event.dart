part of 'banner_bloc.dart';

@immutable
sealed class BannerEvent {
  const BannerEvent();
}

class FetchBanners extends BannerEvent {
  final int? page;
  final int? limit;
  final List<Banner>? previousBanners;

  const FetchBanners({this.page = 3, this.limit = 5, this.previousBanners});
}
