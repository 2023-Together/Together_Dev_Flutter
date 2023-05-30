import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/page_test/widgets/persistent_tab_bar.dart';

class UserProfileTestScreen extends StatelessWidget {
  const UserProfileTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // CustomScrollView : 스크롤 가능한 구역
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          // NestedScrollView : SliverAppBar와 TabBar를 같이 쓰는 경우 처럼 여러개의 스크롤 함께쓸때 유용한 위젯
          child: NestedScrollView(
            // CustomScrollView 안에 들어갈 element들
            // 원하는걸 아무거나 넣을수는 없고 지정된 아이템만 넣을수 있음
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: const Text("내정보"),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.gear,
                        size: Sizes.size20,
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/77985708?v=4",
                          ),
                        ),
                        title: const Text(
                          "이재현",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        subtitle: const Text(
                          "SWAG 동아리",
                          style: TextStyle(
                            fontSize: Sizes.size14,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            size: Sizes.size40,
                          ),
                        ),
                      ),
                      Gaps.v10,
                      Row(
                        children: [
                          const Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("봉사 신청"), Text("2건")],
                            ),
                          ),
                          Container(height: 50, width: 2, color: Colors.grey),
                          const Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("봉사 완료"), Text("6건")],
                            ),
                          ),
                        ],
                      ),
                      Gaps.v20,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gaps.h20,
                          Text(
                            "내가 올린 게시글",
                            style: TextStyle(
                              fontSize: Sizes.size20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v10,
                    ],
                  ),
                ),
                // SliverPersistentHeader는 SliverToBoxAdapter안에서 선언할수 없음
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  // 나와있는 키보드에서 스크롤하면 키보드를 없애는 기능
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 20,
                  padding: EdgeInsets.zero,
                  // controller는 아니지만 비슷한 도우미
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // 한 줄당 몇개를 넣을건지 지정
                    crossAxisCount: 3,
                    // 좌우 간격
                    crossAxisSpacing: Sizes.size2,
                    // 위아래 간격
                    mainAxisSpacing: Sizes.size2,
                    // 한 블럭당 비율 지정 (가로 / 세로)
                    childAspectRatio: 9 / 12,
                  ),
                  // FadeInImage : 실제 사진이 로드 되기 전까지 지정한 이미지를 보여줌
                  itemBuilder: (context, index) => LayoutBuilder(
                    builder: (context, constraints) => Container(
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 9 / 12,
                            child: index % 2 == 0
                                ? index % 3 == 0
                                    ? const FadeInImage(
                                        fit: BoxFit.cover,
                                        placeholder:
                                            AssetImage("assets/images/dog.jpg"),
                                        image:
                                            AssetImage("assets/images/dog.jpg"),
                                      )
                                    : FadeInImage.assetNetwork(
                                        // 부모 요소에 맞춰서 크기 조절
                                        fit: BoxFit.cover,
                                        // 로딩 되기전에 보여줄 이미지 지정
                                        placeholder: "assets/images/dog.jpg",
                                        // 로딩 이미지 지정
                                        image:
                                            "https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                      )
                                : const FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder:
                                        AssetImage("assets/images/dog.jpg"),
                                    image: AssetImage(
                                        "assets/images/70836_50981_2758.jpg"),
                                  ),
                          ),
                          const Positioned(
                            bottom: Sizes.size10,
                            left: Sizes.size10,
                            child: Column(
                              children: [
                                Text(
                                  "제목",
                                  style: TextStyle(
                                    fontSize: Sizes.size16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text("동아리에 올린 게시글"),
                ),
                const Center(
                  child: Text("좋아요한 게시글"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
