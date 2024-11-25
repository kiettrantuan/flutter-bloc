import 'package:f_bloc_1/bloc/banner/banner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final minHeight = MediaQuery.of(context).size.height -
        (Scaffold.of(context).appBarMaxHeight ?? 0);
    return BlocBuilder<BannerBloc, BannerState>(builder: (ctx, state) {
      return ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: width, maxWidth: width, minHeight: minHeight),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Column(
            children: state is BannerLoaded
                ? state.banners
                    .map((item) => SizedBox(
                          width: width,
                          height: minHeight,
                          child: Image.network(
                            item.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, child, progress) {
                              if (progress == null) return child;
                              return SizedBox(
                                width: width,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    color: Colors.teal,
                                    value: progress.expectedTotalBytes != null
                                        ? (progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes!)
                                        : 0.0,
                                  ),
                                ),
                              );
                            },
                          ),
                        ))
                    .toList()
                : [],
          ),
        ),
      );
    });
  }
}
