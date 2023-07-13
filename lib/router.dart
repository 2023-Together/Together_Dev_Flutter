import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/community/club/club_comunity_screen.dart';
import 'package:swag_cross_app/features/community/club/club_search_detail_screen.dart';
import 'package:swag_cross_app/features/community/club/club_search_screen.dart';
import 'package:swag_cross_app/features/notice/club_notice_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/customer_service/customer_service_screen.dart';
import 'package:swag_cross_app/features/customer_service/qna/qna_detail_screen.dart';
import 'package:swag_cross_app/features/customer_service/qna/qna_edit_screen.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/notice/notice_edit_screen.dart';
import 'package:swag_cross_app/features/notice/notice_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_up_check_userData_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_up_id_pw_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_up_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignInScreen.routeName,
      path: SignInScreen.routeURL,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          path: SignUpCheckUserDataScreen.routeURL,
          name: SignUpCheckUserDataScreen.routeName,
          builder: (context, state) {
            final args = state.extra as SignUpCheckUserDataScreenArgs;
            return SignUpCheckUserDataScreen(
              name: args.name,
              email: args.email,
              gender: args.gender,
              birthday: args.birthday,
              profileImage: args.profileImage,
              mobile: args.mobile,
            );
          },
          routes: [
            GoRoute(
              name: SignUpIdPwScreen.routeName,
              path: SignUpIdPwScreen.routeURL,
              builder: (context, state) {
                final args = state.extra as SignUpIdPwScreenArgs;
                return SignUpIdPwScreen(
                  name: args.name,
                  email: args.email,
                  gender: args.gender,
                  birthday: args.birthday,
                  mobile: args.mobile,
                  profileImage: args.profileImage,
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: MainNavigation.routeName,
      path: MainNavigation.routeURL,
      builder: (context, state) {
        if (state.extra != null) {
          final args = state.extra as MainNavigationArgs;
          return MainNavigation(initSelectedIndex: args.initSelectedIndex);
        }
        return const MainNavigation();
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
        ]),
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
          path: ClubNoticeScreen.routeURL,
          name: ClubNoticeScreen.routeName,
          builder: (context, state) {
            return const ClubNoticeScreen();
          },
        )
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
          );
        }
        return const CustomerServiceScreen(
          initSelectedIndex: 0,
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
                images: args.images,
              );
            }
            return const QnAEditScreen();
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
              answerText: args.answerText,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: NoticeScreen.routeURL,
      name: NoticeScreen.routeName,
      builder: (context, state) {
        return const NoticeScreen();
      },
      routes: [
        GoRoute(
          path: NoticeEditScreen.routeURL,
          name: NoticeEditScreen.routeName,
          builder: (context, state) {
            if (state.extra != null) {
              final args = state.extra as NoticeEditScreenArgs;
              return NoticeEditScreen(
                id: args.id,
                title: args.title,
                content: args.content,
                images: args.images,
              );
            }
            return const NoticeEditScreen();
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
