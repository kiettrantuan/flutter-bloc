part of 'banner_interval_bloc.dart';

@immutable
sealed class BannerIntervalState {
  const BannerIntervalState();
}

class BannerInitial extends BannerIntervalState {}

class BannerLoading extends BannerIntervalState {
  final List<Banner> previousBanners;

  const BannerLoading({this.previousBanners = const []});
}

class BannerLoaded extends BannerIntervalState {
  final List<Banner> banners;

  const BannerLoaded(this.banners);
}

class BannerError extends BannerIntervalState {
  final String message;

  const BannerError(this.message);
}

class BannerCountdown extends BannerIntervalState {
  final int countdown;
  final List<Banner> previousBanners;

  const BannerCountdown({this.countdown = 0, this.previousBanners = const []});
}
