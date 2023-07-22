import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class PostDetailTapBar extends SliverPersistentHeaderDelegate {
  // 유저들이 보게 될 위젯을 리턴할 method
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        // 선택한 탭의 밑줄 색
        indicatorColor: Colors.purple.shade300,
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: const [
          Text("내용"),
          Text("댓글"),
        ],
      ),
    );
  }

  // 최대 높이
  @override
  double get maxExtent => 74;

  // 최소 높이
  @override
  double get minExtent => 74;

  // persistent header가 보여져야 되는지 알려주는 method
  // maxExtent와 minExtent의 값을 변경하고 싶다면 true를 리턴해야함
  // 만약 build에서 완전히 다른 widget tree를 리턴한다면 false를 리턴해야함
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
      ),
      child: Column(
        children: [
          FaIcon(
            icon,
            color: Colors.black,
          ),
          Gaps.v6,
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
