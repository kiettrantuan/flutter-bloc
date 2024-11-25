import 'package:f_bloc_1/data/models/banner.dart';
import 'package:f_bloc_1/data/repositories/banner_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepository repository;

  BannerBloc({required this.repository}) : super(BannerInitial()) {
    on<FetchBanners>((event, emit) async {
      emit(BannerLoading(previousBanners: event.previousBanners));
      try {
        final banners =
            await repository.getBanners(page: event.page, limit: event.limit);
        emit(BannerLoaded(banners));
      } catch (e) {
        emit(BannerError(e.toString()));
      }
    });
  }
}
