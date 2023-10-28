import 'package:auto_route/auto_route.dart';
import 'package:filmle/ui/home_view.dart';
import 'package:filmle/ui/splash_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: SplashRoute.page),
        AutoRoute(page: HomeRoute.page)
      ];
}
