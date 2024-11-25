import 'package:f_bloc_1/bloc/banner/banner_bloc.dart';
import 'package:f_bloc_1/data/providers/banner_provider.dart';
import 'package:f_bloc_1/data/repositories/banner_repository.dart';
import 'package:f_bloc_1/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = BannerRepository(dataProvider: BannerDataProvider());
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (_) =>
              BannerBloc(repository: repository)..add(const FetchBanners()),
          child: const HomeScreen()),
    );
  }
}
