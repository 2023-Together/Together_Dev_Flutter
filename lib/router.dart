import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_update_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/customer_service/customer_service_screen.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/customer_service/notice/notice_screen.dart';
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
      builder: (context, state) {
        int initIndex = 2;
        if (state.queryParams["initIndex"] != null) {
          initIndex = int.parse(state.queryParams["initIndex"]!);
        }
        return MainNavigation(initSelectedIndex: initIndex);
      },
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
    GoRoute(
      name: CustomerServiceScreen.routeName,
      path: CustomerServiceScreen.routeURL,
      builder: (context, state) {
        int initIndex = 0;
        if (state.queryParams["initIndex"] != null) {
          initIndex = int.parse(state.queryParams["initIndex"]!);
        }
        return CustomerServiceScreen(initSelectedIndex: initIndex);
      },
    ),
    GoRoute(
      name: PostDetailScreen.routeName,
      path: PostDetailScreen.routeURL,
      builder: (context, state) {
        final args = state.extra as PostDetailScreenArgs;
        return PostDetailScreen(
          postId: args.postId,
          category: args.category,
          title: args.title,
          content: args.content,
          images: args.images,
          user: args.user,
          date: args.date,
          tabBarSelected: args.tabBarSelected,
        );
      },
    ),
    GoRoute(
      name: PostEditScreen.routeName,
      path: PostEditScreen.routeURL,
      builder: (context, state) {
        if (state.extra != null) {
          final args = state.extra as PostEditScreenArgs;
          return PostEditScreen(
            id: args.id,
            category: args.category,
            title: args.title,
            content: args.content,
            images: args.images,
          );
        }

        return const PostEditScreen();
      },
    ),
    GoRoute(
      name: PostUpdateScreen.routeName,
      path: PostUpdateScreen.routeURL,
      builder: (context, state) {
        final args = state.extra as PostUpdateScreenArgs;
        return PostUpdateScreen(
          title: args.title,
          content: args.content,
          images: args.images,
        );
      },
    ),
  ],
);
