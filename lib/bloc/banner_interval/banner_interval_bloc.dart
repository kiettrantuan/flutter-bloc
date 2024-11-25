import 'dart:async';
import 'dart:math';

import 'package:f_bloc_1/data/models/banner.dart';
import 'package:f_bloc_1/data/repositories/banner_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'banner_interval_event.dart';
part 'banner_interval_state.dart';

class BannerIntervalBloc
    extends Bloc<BannerIntervalEvent, BannerIntervalState> {
  final BannerRepository repository;
  final _intervalSeconds = 10;
  bool _isStop = true;

  bool get isStop => _isStop;

  BannerIntervalBloc({required this.repository}) : super(BannerInitial()) {
    on<StartFetchingBanners>(_onStartFetchingBanners);
    on<FetchingBanners>(_onFetchingBanners);
    on<StopFetchingBanners>(_onStopFetchingBanners);
    on<UpdateBanners>(_onUpdateBanners);
    on<CountdownTick>(_onCountdownTick);
  }

  Future<void> _onStartFetchingBanners(
      StartFetchingBanners event, Emitter<BannerIntervalState> emit) async {
    _isStop = false;
    add(const FetchingBanners());
    final initBanners = await repository.getBanners(
        page: 1 + Random().nextInt(10), limit: 3 + Random().nextInt(10));
    _recursiveFetchBanners(_intervalSeconds, initBanners);
  }

  void _onStopFetchingBanners(
      StopFetchingBanners event, Emitter<BannerIntervalState> emit) {
    debugPrint('_onStopFetchingBanners');
    _isStop = true;
    if (event.errorMessage != null) emit(BannerError(event.errorMessage!));
  }

  void _onUpdateBanners(
      UpdateBanners event, Emitter<BannerIntervalState> emit) {
    emit(BannerLoaded(event.banners));
  }

  void _onFetchingBanners(
      FetchingBanners event, Emitter<BannerIntervalState> emit) {
    emit(BannerLoading(previousBanners: event.previousBanners));
  }

  void _onCountdownTick(
      CountdownTick event, Emitter<BannerIntervalState> emit) {
    debugPrint('_onCountdownTick ${event.countdown}');
    emit(BannerCountdown(
        countdown: event.countdown, previousBanners: event.previousBanners));
  }

  Future<void> _recursiveFetchBanners(
      int countdown, List<Banner> previousBanners) async {
    if (_isStop) return;
    var banners = previousBanners;
    try {
      if (countdown > 0) {
        var newCountdown = countdown - 1;
        add(CountdownTick(countdown: newCountdown, previousBanners: banners));
        await Future.delayed(const Duration(seconds: 1));
        await _recursiveFetchBanners(newCountdown, banners);
      } else {
        add(FetchingBanners(previousBanners: banners));
        banners = await repository.getBanners(
            page: 1 + Random().nextInt(10), limit: 3 + Random().nextInt(10));
        add(UpdateBanners(banners));
        await _recursiveFetchBanners(_intervalSeconds, banners);
      }
    } catch (error) {
      add(StopFetchingBanners(errorMessage: error.toString()));
    }
  }
}
