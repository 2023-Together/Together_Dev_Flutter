import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/search_page/view/org_detail_screen.dart';

class OrgPostCard extends StatefulWidget {
  final String id;
  final String host;
  final String locationStr;
  final String volCount;
  final String location;
  final String pNum;
  final String bossName;

  const OrgPostCard({
    super.key,
    required this.id,
    required this.host,
    required this.locationStr,
    required this.volCount,
    required this.location,
    required this.pNum,
    required this.bossName,
  });

  @override
  State<OrgPostCard> createState() => _OrgPostCardState();
}

class _OrgPostCardState extends State<OrgPostCard> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.size5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              Sizes.size6,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(3, 3), // 그림자의 위치 조정
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              context.pushNamed(
                OrgDetailScreen.routeName,
                extra: OrgDetailScreenArgs(
                  id: widget.id,
                  host: widget.host,
                  locationStr: widget.locationStr,
                  volCount: widget.volCount,
                  location: widget.location,
                  pNum: widget.pNum,
                  bossName: widget.bossName,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/yonam.jpg",
                  width: constraints.maxWidth,
                  fit: BoxFit.fill,
                ),
                Gaps.v4,
                Row(
                  children: [
                    Gaps.h8,
                    Text(
                      widget.host,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Gaps.v3,
                 Row(
                  children: [
                    Gaps.h8,
                    Text("주소 : "),
                    Text(
                      widget.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Gaps.h8,
                    const Text("모집 중인 봉사 : "),
                    Text(
                      widget.volCount + "건",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
