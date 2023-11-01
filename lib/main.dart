import 'package:filmle/app/views/home_view.dart';
import 'package:filmle/app/views/splash_view.dart';
import 'package:filmle/core/viewmodel/movie_provider.dart';
import 'package:filmle/core/viewmodel/search_provider.dart';
import 'package:filmle/core/viewmodel/youtube_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const seedColor = Color(0xffC0392B);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => MovieProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => SearchProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => YoutubeVideoProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.dark,
            ),
          ),
          home: SplashView()),
    );
  }
}
