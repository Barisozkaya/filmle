import 'package:filmle/core/style/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Fılmle",
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
