part of 'banner_bloc.dart';

@immutable
sealed class BannerState {
  const BannerState();
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {
  final List<Banner>? previousBanners;

  const BannerLoading({this.previousBanners});
}

class BannerLoaded extends BannerState {
  final List<Banner> banners;

  const BannerLoaded(this.banners);
}

class BannerError extends BannerState {
  final String message;

  const BannerError(this.message);
}
