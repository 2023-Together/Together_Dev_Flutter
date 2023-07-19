import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/club/club_search_detail_screen.dart';

class ClubRequestCard extends StatelessWidget {
  const ClubRequestCard({
    super.key,
    required this.clubDef,
    required this.clubName,
    required this.clubMaster,
    required this.isRequest,
    required this.clubId,
    required this.clubNum,
  });

  final int clubId;
  final String clubDef;
  final String clubName;
  final String clubMaster;
  final int clubNum;
  final bool isRequest;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          ClubSearchDetailScreen.routeName,
          extra: ClubSearchDetailScreenArgs(
            clubId: clubId,
            clubDef: clubDef,
            clubName: clubName,
            clubMaster: clubMaster,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.size16,
        ),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(Sizes.size12),
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
        child: Column(
          children: [
            // Image.asset(
            //   'assets/images/club1.jpg',
            //   fit: BoxFit.cover,
            // ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size10,
                vertical: Sizes.size8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        clubName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      isRequest
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade300,
                                // border: Border.all(
                                //   width: 1,
                                // ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: const Text(
                                "신청 가능",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                // border: Border.all(
                                //   width: 1,
                                // ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: const Text(
                                "신청 불가능",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ],
                  ),
                  const Divider(),
                  Text(
                    clubDef,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Gaps.v10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("인원 : $clubNum명"),
                      Text("동아리장 : $clubMaster"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
