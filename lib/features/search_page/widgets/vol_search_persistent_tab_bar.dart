import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class VolSearchPersistentTabBar extends SliverPersistentHeaderDelegate {
    // 유저들이 보게 될 위젯을 리턴할 method
    @override
    Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent
    ) {
      return Container(
        decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        // 선택한 탭의 밑줄 색
        indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
        labelPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
        labelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        tabs: const [
          Tab(text: '상세 정보'),
          Tab(text: '활동 위치'),
        ],
      ),
      );
    }

    // 최대 높이
  @override
  double get maxExtent => 50;

  // 최소 높이
  @override
  double get minExtent => 50;

  // persistent header가 보여져야 되는지 알려주는 method
  // maxExtent와 minExtent의 값을 변경하고 싶다면 true를 리턴해야함
  // 만약 build에서 완전히 다른 widget tree를 리턴한다면 false를 리턴해야함
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}