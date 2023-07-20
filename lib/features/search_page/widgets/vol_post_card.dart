import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/search_page/view/vol_detail_screen.dart';

class VolPostCard extends StatefulWidget {
  // 봉사활동 아이디
  final String id;
  // 봉사활동 제목
  final String title;
  // 봉사활동 설명
  final String contnet;
  // 봉사활동 주체단체 (기관)
  final String host;
  // 봉사활동 위치
  final String locationStr;
  // 봉사활동 모집 마감일
  final String startTime;
  final String endTime;

  const VolPostCard({
    super.key,
    required this.id,
    required this.title,
    // required this.tabBarSelected,
    required this.contnet,
    required this.host,
    required this.locationStr,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<VolPostCard> createState() => _VolPostCardState();
}

class _VolPostCardState extends State<VolPostCard> {
  final bool _isLogined = false;

  @override
  void initState() {
    super.initState();

    // checkLoginType();
  }

  // // 로그인 타입을 가져와서 로그인 상태를 적용하는 함수
  // void checkLoginType() async {
  //   var loginType = await SecureStorageLogin.getLoginType();
  //   print(loginType);
  //   if (loginType == "naver" || loginType == "kakao") {
  //     _isLogined = true;
  //   } else {
  //     _isLogined = false;
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onTap: () {
          context.pushNamed(
            VolDetailScreen.routeName,
            extra: VolDetailScreenArgs(
              id: widget.id,
              title: widget.title,
              contnet: widget.contnet,
              host: widget.host,
              locationStr: widget.locationStr,
              startTime: widget.startTime,
              endTime: widget.endTime,
              tabBarSelected: 0,
            ),
          );
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          width: constraints.maxWidth,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.size12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Text(
                widget.contnet,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0, height: 2.0),
              ),
              Text(
                "모집기간 : ${widget.startTime} ~ ${widget.endTime}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color.fromARGB(255, 124, 123, 123),
                  fontSize: 12.0,
                  height: 2.8,
                ),
              ),
              const Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.host,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 124, 123, 123),
                      fontSize: 12.0,
                      height: 2.5,
                    ),
                  ),
                  Text(
                    widget.locationStr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 124, 123, 123),
                      fontSize: 12.0,
                      height: 2.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
