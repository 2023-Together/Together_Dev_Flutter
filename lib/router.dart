import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/community/club/club_comunity_screen.dart';
import 'package:swag_cross_app/features/community/club/club_search_detail_screen.dart';
import 'package:swag_cross_app/features/community/club/club_search_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/customer_service/customer_service_screen.dart';
import 'package:swag_cross_app/features/customer_service/notice/notice_detail_screen.dart';
import 'package:swag_cross_app/features/customer_service/qna/qna_detail_screen.dart';
import 'package:swag_cross_app/features/customer_service/qna/qna_edit_screen.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
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
          isLogined: args.isLogined,
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
            isCategory: args.isCategory,
            maxImages: args.maxImages,
          );
        }
        return const PostEditScreen();
      },
    ),
    GoRoute(
      path: ClubSearchScreen.routeURL,
      name: ClubSearchScreen.routeName,
      builder: (context, state) => const ClubSearchScreen(),
    ),
    GoRoute(
      path: ClubCommunityScreen.routeURL,
      name: ClubCommunityScreen.routeName,
      builder: (context, state) {
        final args = state.extra as ClubCommunityScreenArgs;
        return ClubCommunityScreen(
          clubId: args.clubId,
        );
      },
      routes: [
        GoRoute(
          path: ClubSearchDetailScreen.routeURL,
          name: ClubSearchDetailScreen.routeName,
          builder: (context, state) {
            final args = state.extra as ClubSearchDetailScreenArgs;
            return ClubSearchDetailScreen(
              postId: args.postId,
              postTitle: args.postTitle,
              postContent: args.postContent,
              clubName: args.clubName,
              postDate: args.postDate,
              clubMaster: args.clubMaster,
            );
          },
        ),
      ],
    ),
    GoRoute(
      name: CustomerServiceScreen.routeName,
      path: CustomerServiceScreen.routeURL,
      builder: (context, state) {
        if (state.extra != null) {
          final args = state.extra as CustomerServiceScreenArgs;
          return CustomerServiceScreen(
            initSelectedIndex: args.initSelectedIndex,
            isLogined: args.isLogined,
          );
        }
        return const CustomerServiceScreen(
          initSelectedIndex: 0,
          isLogined: false,
        );
      },
      routes: [
        GoRoute(
          name: QnAEditScreen.routeName,
          path: QnAEditScreen.routeURL,
          builder: (context, state) {
            if (state.extra != null) {
              final args = state.extra as QnAEditScreenArgs;
              return QnAEditScreen(
                id: args.id,
                title: args.title,
                content: args.content,
              );
            }
            return const QnAEditScreen();
          },
        ),
        GoRoute(
          path: NoticeDetailScreen.routeURL,
          name: NoticeDetailScreen.routeName,
          builder: (context, state) {
            final args = state.extra as NoticeDetailScreenArgs;
            return NoticeDetailScreen(
              noticeId: args.noticeId,
              noticeTitle: args.noticeTitle,
              noticeContent: args.noticeContent,
              noticeDate: args.noticeDate,
              noticeImage: args.noticeImage,
              isLogined: args.isLogined,
              isPageWhere: args.isPageWhere,
            );
          },
        ),
        GoRoute(
          path: QnADetailScreen.routeURL,
          name: QnADetailScreen.routeName,
          builder: (context, state) {
            final args = state.extra as QnADetailScreenArgs;
            return QnADetailScreen(
              qnaId: args.qnaId,
              qnaUser: args.qnaUser,
              qnaContent: args.qnaContent,
              qnaDate: args.qnaDate,
              isLogined: args.isLogined,
              answerText: args.answerText,
            );
          },
        ),
      ],
    ),
    GoRoute(
      name: AlertScreen.routeName,
      path: AlertScreen.routeURL,
      builder: (context, state) => const AlertScreen(),
    ),
  ],
);
