import 'package:auto_route/auto_route.dart';
import 'package:filmle/app/views/home_view.dart';
import 'package:filmle/app/views/login_view.dart';
import 'package:filmle/app/views/splash_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: LoginRoute.page),
        AutoRoute(page: SplashRoute.page),
        AutoRoute(page: HomeRoute.page)
      ];
}
