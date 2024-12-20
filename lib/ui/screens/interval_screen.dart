import 'package:f_bloc_1/bloc/banner_interval/banner_interval_bloc.dart';
import 'package:f_bloc_1/data/providers/banner_provider.dart';
import 'package:f_bloc_1/data/repositories/banner_repository.dart';
import 'package:f_bloc_1/ui/components/banner/interval_banner.dart';
import 'package:f_bloc_1/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntervalScreen extends StatelessWidget {
  const IntervalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = BannerRepository(dataProvider: BannerDataProvider());

    return BlocProvider(
        create: (_) => BannerIntervalBloc(repository: repository)
          ..add(const StartFetchingBanners()),
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
                      physics: ClampingScrollPhysics(),
                      child: IntervalBanner())),
            ),
            // BlocBuilder<BannerBloc, BannerState>(
            BlocBuilder<BannerIntervalBloc, BannerIntervalState>(
              builder: (ctx, state) {
                if (state is BannerIntervalLoading) {
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
          // floatingActionButton: BlocBuilder<BannerBloc, BannerState>(
          floatingActionButton:
              BlocBuilder<BannerIntervalBloc, BannerIntervalState>(
            builder: (ctx, state) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'to_home',
                  onPressed: () {
                    ctx
                        .read<BannerIntervalBloc>()
                        .add(const StopFetchingBanners());
                    Navigator.of(ctx).push(
                      MaterialPageRoute(
                        builder: (ctx) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.timer_off_outlined),
                ),
                const SizedBox(
                  height: 10,
                ),
                IgnorePointer(
                  ignoring: state is BannerIntervalLoading,
                  child: FloatingActionButton(
                    heroTag: 'toggle_timer',
                    tooltip: 'Stop',
                    backgroundColor:
                        state is BannerIntervalLoading ? Colors.black54 : null,
                    foregroundColor:
                        state is BannerIntervalLoading ? Colors.grey : null,
                    onPressed: () {
                      ctx.read<BannerIntervalBloc>().isStop
                          ? ctx
                              .read<BannerIntervalBloc>()
                              .add(const StartFetchingBanners())
                          : ctx
                              .read<BannerIntervalBloc>()
                              .add(const StopFetchingBanners());
                    },
                    child: state is BannerIntervalCountdown
                        ? Text('${state.countdown}')
                        : const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
