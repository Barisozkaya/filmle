import 'package:auto_route/auto_route.dart';
import 'package:filmle/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      context.router.push(const HomeRoute());
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 44, 44, 44),
            Color.fromARGB(255, 245, 232, 232)
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        )),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_outlined, size: 100, color: Colors.white),
            SizedBox(
              height: 50,
            ),
            Text(
              "FİLMLE",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
