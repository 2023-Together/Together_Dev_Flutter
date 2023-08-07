import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/community/club/club_comunity_screen.dart';
import 'package:swag_cross_app/features/community/club/club_make_screen.dart';
import 'package:swag_cross_app/features/community/club/club_setting_screen.dart';
import 'package:swag_cross_app/features/community/club/request_club_apply.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_screen.dart';
import 'package:swag_cross_app/features/customer_service/faq/faq_edit_screen.dart';
import 'package:swag_cross_app/features/main_navigation/logo_loading_screen.dart';
import 'package:swag_cross_app/features/notice/club_notice_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/customer_service/customer_service_screen.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/notice/notice_edit_screen.dart';
import 'package:swag_cross_app/features/notice/notice_screen.dart';
import 'package:swag_cross_app/features/search_page/view/club_search_detail_screen.dart';
import 'package:swag_cross_app/features/search_page/view/club_search_screen.dart';
import 'package:swag_cross_app/features/search_page/view/org_detail_screen.dart';
import 'package:swag_cross_app/features/search_page/view/vol_detail_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_up_form_screen.dart';
import 'package:swag_cross_app/features/user_profile/view/change_phoneNum.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_setup.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_update.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignInScreen.routeName,
      path: SignInScreen.routeURL,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      name: SignUpFormScreen.routeName,
      path: SignUpFormScreen.routeURL,
      builder: (context, state) => const SignUpFormScreen(),
    ),
    GoRoute(
      path: LogoLoadingScreen.routeURL,
      name: LogoLoadingScreen.routeName,
      builder: (context, state) => const LogoLoadingScreen(),
    ),
    // GoRoute(
    //   name: MainNavigation.routeName,
    //   path: MainNavigation.routeURL,
    //   builder: (context, state) {
    //     if (state.extra != null) {
    //       final args = state.extra as MainNavigationArgs;
    //       return MainNavigation(initSelectedIndex: args.initSelectedIndex);
    //     }
    //     return const MainNavigation();
    //   },
    // ),
    GoRoute(
      name: MainNavigation.routeName,
      path: MainNavigation.routeURL,
      builder: (context, state) {
        return const MainNavigation();
      },
    ),
    GoRoute(
      name: PostDetailScreen.routeName,
      path: PostDetailScreen.routeURL,
      builder: (context, state) {
        final args = state.extra as PostDetailScreenArgs;
        return PostDetailScreen(
          postData: args.postData,
          tabBarSelected: args.tabBarSelected,
        );
      },
    ),
    GoRoute(
      name: PostEditScreen.routeName,
      path: PostEditScreen.routeURL,
      builder: (context, state) {
        final args = state.extra as PostEditScreenArgs;
        return PostEditScreen(
          pageTitle: args.pageTitle,
          editType: args.editType,
          maxImages: args.maxImages,
          postData: args.postData,
        );
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
              clubData: args.clubData,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: ClubCommunityScreen.routeURL,
      name: ClubCommunityScreen.routeName,
      builder: (context, state) {
        final args = state.extra as ClubCommunityScreenArgs;
        return ClubCommunityScreen(
          clubData: args.clubData,
        );
      },
      routes: [
        GoRoute(
          path: ClubNoticeScreen.routeURL,
          name: ClubNoticeScreen.routeName,
          builder: (context, state) {
            return const ClubNoticeScreen();
          },
        ),
        GoRoute(
          path: ClubSettingScreen.routeURL,
          name: ClubSettingScreen.routeName,
          builder: (context, state) {
            final args = state.extra as ClubSettingScreenArgs;
            return ClubSettingScreen(
              clubData: args.clubData,
            );
          },
        )
      ],
    ),
    GoRoute(
      path: ClubMakeScreen.routeURL,
      name: ClubMakeScreen.routeName,
      builder: (context, state) {
        return const ClubMakeScreen();
      },
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
          path: FaqEditScreen.routeURL,
          name: FaqEditScreen.routeName,
          builder: (context, state) {
            final args = state.extra as FaqEditScreenArgs;
            return FaqEditScreen(
              pageName: args.pageName,
              id: args.id,
              title: args.title,
              content: args.content,
            );
          },
        )
        // GoRoute(
        //   name: QnAEditScreen.routeName,
        //   path: QnAEditScreen.routeURL,
        //   builder: (context, state) {
        //     if (state.extra != null) {
        //       final args = state.extra as QnAEditScreenArgs;
        //       return QnAEditScreen(
        //         id: args.id,
        //         title: args.title,
        //         content: args.content,
        //         images: args.images,
        //       );
        //     }
        //     return const QnAEditScreen();
        //   },
        // ),
        // GoRoute(
        //   path: QnADetailScreen.routeURL,
        //   name: QnADetailScreen.routeName,
        //   builder: (context, state) {
        //     final args = state.extra as QnADetailScreenArgs;
        //     return QnADetailScreen(
        //       qnaId: args.qnaId,
        //       qnaUser: args.qnaUser,
        //       qnaContent: args.qnaContent,
        //       qnaDate: args.qnaDate,
        //       answerText: args.answerText,
        //     );
        //   },
        // ),
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
                noticeData: args.noticeData,
                pageName: args.pageName,
              );
            }
            return const NoticeEditScreen(
              pageName: "공지사항 등록",
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
    GoRoute(
      name: RequestClubApply.routeName,
      path: RequestClubApply.routeURL,
      builder: (context, state) {
        final args = state.extra as RequestClubApplyArgs;
        return RequestClubApply(
          clubData: args.clubData,
        );
      },
    ),
    GoRoute(
      name: VolDetailScreen.routeName,
      path: VolDetailScreen.routeURL,
      builder: (context, state) {
        final args = state.extra as VolDetailScreenArgs;
        return VolDetailScreen(
          id: args.id,
          title: args.title,
          contnet: args.contnet,
          host: args.host,
          locationStr: args.locationStr,
          actPlace: args.actPlace,
          teenager: args.teenager,
          listApiType: args.listApiType,
          tabBarSelected: args.tabBarSelected,
        );
      },
    ),
    GoRoute(
      name: OrgDetailScreen.routeName,
      path: OrgDetailScreen.routeURL,
      builder: (context, state) {
        final args = state.extra as OrgDetailScreenArgs;
        return OrgDetailScreen(
          id: args.id,
          host: args.host,
          locationStr: args.locationStr,
          location: args.location,
          volCount: args.volCount,
          pNum: args.pNum,
          bossName: args.bossName,
        );
      },
    ),
    // GoRoute(
    //   path: UserProfileScreen.routeURL,
    //   name: UserProfileScreen.routeName,
    //   builder: (context, state) {
    //     final args = state.extra as UserProfileScreenArgs;
    //     return UserProfileScreen(
    //       userId1: args.userId1,
    //     );
    //   },
    // ),
    GoRoute(
        path: UserInformUpdate.routeURL,
        name: UserInformUpdate.routeName,
        builder: (context, state) {
          return const UserInformUpdate();
        },
        routes: [
          GoRoute(
            path: "userPhoneNum",
            name: ChangePhoneNum.routeName,
            builder: (context, state) {
              final args = state.extra as ChangePhoneNumArgs;
              return ChangePhoneNum(
                userPhoneNumber: args.userPhoneNumber,
              );
            },
          ),
        ]),
    GoRoute(
      name: UserInformSetup.routeName,
      path: UserInformSetup.routeURL,
      builder: (context, state) => const UserInformSetup(),
      // routes: [
      //   GoRoute(
      //     path: UserInformUpdate.routeURL,
      //     name: UserInformUpdate.routeName,
      //     builder: (context, state) {
      //       final args = state.extra as UserInformArgs;
      //       return UserInformUpdate(
      //         userId: args.userId,
      //         userEmail: args.userEmail,
      //         userPw: args.userPw,
      //         userName: args.userName,
      //         userNickName: args.userNickName,
      //         userDef: args.userDef,
      //         userGender: args.userGender,
      //         userType: args.userType,
      //         userSnS: args.userSnS,
      //         userBirthDate: args.userBirthDate,
      //         userPhoneNumber: args.userPhoneNumber,
      //       );
      //     },
      //   ),
      // ],
    ),
  ],
);
