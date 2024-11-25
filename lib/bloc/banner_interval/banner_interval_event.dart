part of 'banner_interval_bloc.dart';

@immutable
sealed class BannerIntervalEvent {
  const BannerIntervalEvent();
}

class StartFetchingBanners extends BannerIntervalEvent {
  const StartFetchingBanners();
}

class FetchingBanners extends BannerIntervalEvent {
  final List<Banner> previousBanners;

  const FetchingBanners({this.previousBanners = const []});
}

class StopFetchingBanners extends BannerIntervalEvent {
  final String? errorMessage;

  const StopFetchingBanners({this.errorMessage});
}

class UpdateBanners extends BannerIntervalEvent {
  final List<Banner> banners;

  const UpdateBanners(this.banners);
}

class CountdownTick extends BannerIntervalEvent {
  final int countdown;
  final List<Banner> previousBanners;

  const CountdownTick({this.countdown = 0, this.previousBanners = const []});
}
