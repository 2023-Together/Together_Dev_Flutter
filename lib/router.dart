import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/notice/notice_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_main.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_up_main.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignInMain.routeName,
      path: SignInMain.routeURL,
      builder: (context, state) => const SignInMain(),
    ),
    GoRoute(
      name: SignUpMain.routeName,
      path: SignUpMain.routeURL,
      builder: (context, state) => const SignUpMain(),
    ),
    GoRoute(
      name: MainNavigation.routeName,
      path: MainNavigation.routeURL,
      builder: (context, state) => const MainNavigation(initSelectedIndex: 2),
    ),
    GoRoute(
      name: AlertScreen.routeName,
      path: AlertScreen.routeURL,
      builder: (context, state) => const AlertScreen(),
    ),
    GoRoute(
      name: NoticeScreen.routeName,
      path: NoticeScreen.routeURL,
      builder: (context, state) => const NoticeScreen(),
    ),
  ],
);
