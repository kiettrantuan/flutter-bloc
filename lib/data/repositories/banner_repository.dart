import 'package:f_bloc_1/data/models/banner.dart';
import 'package:f_bloc_1/data/providers/banner_provider.dart';

class BannerRepository {
  final BannerDataProvider dataProvider;

  BannerRepository({required this.dataProvider});

  Future<List<Banner>> getBanners({int? page, int? limit}) async {
    return await dataProvider.fetchBanners(page: page, limit: limit);
  }
}
