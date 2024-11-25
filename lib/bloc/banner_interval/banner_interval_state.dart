part of 'banner_interval_bloc.dart';

@immutable
sealed class BannerIntervalState {
  const BannerIntervalState();
}

class BannerIntervalInitial extends BannerIntervalState {}

class BannerIntervalLoading extends BannerIntervalState {
  final List<Banner> previousBanners;

  const BannerIntervalLoading({this.previousBanners = const []});
}

class BannerIntervalLoaded extends BannerIntervalState {
  final List<Banner> banners;

  const BannerIntervalLoaded(this.banners);
}

class BannerIntervalError extends BannerIntervalState {
  final String message;

  const BannerIntervalError(this.message);
}

class BannerIntervalCountdown extends BannerIntervalState {
  final int countdown;
  final List<Banner> previousBanners;

  const BannerIntervalCountdown(
      {this.countdown = 0, this.previousBanners = const []});
}
