import 'dart:math';

import 'package:f_bloc_1/bloc/banner/banner_bloc.dart';
import 'package:f_bloc_1/ui/components/home/home_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: BlocBuilder<BannerBloc, BannerState>(
        builder: (ctx, state) => IgnorePointer(
          ignoring: state is BannerLoading,
          child: FloatingActionButton(
            tooltip: 'Reload',
            backgroundColor: state is BannerLoading ? Colors.black54 : null,
            foregroundColor: state is BannerLoading ? Colors.grey : null,
            onPressed: () {
              ctx.read<BannerBloc>().add(FetchBanners(
                  page: 1 + Random().nextInt(10),
                  limit: 3 + Random().nextInt(10)));
            },
            child: const Icon(Icons.refresh),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
