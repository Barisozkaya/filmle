import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomescreenState();
}

class HomescreenState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
