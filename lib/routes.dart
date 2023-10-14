import 'package:afshon_ar/routes.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.noTransition,
          page: HomeRoute.page,
          path: "/",
          initial: true,
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.fadeIn,
          page: SearchRoute.page,
          path: "/search",
        ),
        AutoRoute(
          page: ObjectsRoute.page,
          path: "/objects",
        ),
      ];
}
