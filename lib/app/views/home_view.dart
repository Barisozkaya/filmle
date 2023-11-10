import 'package:auto_route/auto_route.dart';
import 'package:filmle/core/style/colors.dart';
import 'package:filmle/core/widgets/genres.dart';
import 'package:filmle/core/widgets/populer_movies.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Filmle",
          style: TextStyle(color: black),
        ),
      ),
      body: ListView(
        children: const [
          Genres(),
          BestMovies(),
        ],
      ),
    );
  }
}
