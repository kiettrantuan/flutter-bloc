import 'dart:math';

import 'package:f_bloc_1/bloc/banner/banner_bloc.dart';
import 'package:f_bloc_1/data/providers/banner_provider.dart';
import 'package:f_bloc_1/data/repositories/banner_repository.dart';
import 'package:f_bloc_1/ui/components/banner/home_banner.dart';
import 'package:f_bloc_1/ui/screens/interval_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = BannerRepository(dataProvider: BannerDataProvider());

    return BlocProvider(
        create: (_) =>
            BannerBloc(repository: repository)..add(const FetchBanners()),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Flutter Bloc'),
          ),
          body: Stack(children: [
            const ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: Colors.black54,
                  child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(), child: HomeBanner())),
            ),
            BlocBuilder<BannerBloc, BannerState>(
              builder: (ctx, state) {
                if (state is BannerLoading) {
                  return Container(
                    color: Colors.black45,
                    width: MediaQuery.of(ctx).size.width,
                    height: MediaQuery.of(ctx).size.height -
                        (Scaffold.of(ctx).appBarMaxHeight ?? 0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const LinearProgressIndicator(),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ]),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'to_interval',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const IntervalScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.timer_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<BannerBloc, BannerState>(
                builder: (ctx, state) => IgnorePointer(
                  ignoring: state is BannerLoading,
                  child: FloatingActionButton(
                    heroTag: 're-fetch',
                    tooltip: 'Reload',
                    backgroundColor:
                        state is BannerLoading ? Colors.black54 : null,
                    foregroundColor:
                        state is BannerLoading ? Colors.grey : null,
                    onPressed: () {
                      final previousBanners =
                          (state is BannerLoaded) ? state.banners : null;
                      ctx.read<BannerBloc>().add(FetchBanners(
                            page: 1 + Random().nextInt(10),
                            limit: 3 + Random().nextInt(10),
                            previousBanners: previousBanners,
                          ));
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ),
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
