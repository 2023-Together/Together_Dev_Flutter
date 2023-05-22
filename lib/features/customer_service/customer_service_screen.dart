import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/breakpoints.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/customer_service/QnA/QnA_screen.dart';
import 'package:swag_cross_app/features/customer_service/notice/notice_screen.dart';

final tabs = [
  "공지사항",
  "QnA",
];

class CustomerServiceArgs {
  final int initSelectedIndex;

  CustomerServiceArgs({required this.initSelectedIndex});
}

class CustomerServiceScreen extends StatefulWidget {
  static const routeName = "customer_services";
  static const routeURL = "/customer_services";

  const CustomerServiceScreen({
    super.key,
    required this.initSelectedIndex,
  });

  final int initSelectedIndex;

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");

  late bool _isThereSearchValue = _textEditingController.text.isNotEmpty;

  void _onSearchChanged(String value) {
    print("Searching form $value");
    setState(() {
      _isThereSearchValue = value.isNotEmpty;
    });
  }

  void _onSearchSubmitted(String value) {
    print("Submitted $value");
  }

  void _onTabBar(int value) {
    FocusScope.of(context).unfocus();
  }

  void _onCloseIcon() {
    setState(() {
      _textEditingController.text = '';
      _isThereSearchValue = false;
    });
  }

  void _moveBack() {
    context.pop();
  }

  void _alertIconTap() {
    context.pushNamed(AlertScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        // 키보드를 열었을때 사이즈가 조정되는 현상을 해결
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // 자동 뒤로가기 생성 여부
          automaticallyImplyLeading: false,
          // 맨아래 구분선
          elevation: 1,
          // ConstrainedBox : 최대 크기, 최소 크기를 지정할수 있음
          // 만약 Container를 사용하고 있다면 ConstrainedBox를 사용할 필요 X
          // Container가 constraints속성을 가지고 있기때문
          title: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            // 커스텀 검색 구현
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _moveBack,
                  child: Container(
                    child: const FaIcon(FontAwesomeIcons.chevronLeft),
                  ),
                ),
                // 검색 바
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size18),
                    height: Sizes.size44,
                    child: TextField(
                      controller: _textEditingController,
                      onChanged: _onSearchChanged,
                      onSubmitted: _onSearchSubmitted,
                      cursorColor: Colors.purple,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.size5),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size12),
                        prefixIcon: Container(
                          width: Sizes.size20,
                          alignment: Alignment.center,
                          child: const FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: Colors.black,
                            size: Sizes.size18,
                          ),
                        ),
                        suffixIcon: Container(
                          width: Sizes.size20,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(
                            left: Sizes.size10,
                            right: Sizes.size8,
                          ),
                          child: AnimatedOpacity(
                            opacity: _isThereSearchValue ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: GestureDetector(
                              onTap: _onCloseIcon,
                              child: FaIcon(
                                FontAwesomeIcons.solidCircleXmark,
                                color: Colors.grey.shade600,
                                size: Sizes.size18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // 알림 아이콘
                GestureDetector(
                  onTap: _alertIconTap,
                  child: Container(
                    child: const FaIcon(
                      FontAwesomeIcons.bell,
                      size: 40,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            onTap: (value) => _onTabBar(value),
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.purple,
            labelColor: Colors.black,
            // 탭의 양이 많으면 옆으로 스크롤 하는 기능 부여 가능
            // isScrollable: true,
            // 선택할때의 애니메이션 지정 ex) NoSplash.splashFactory : 스플래쉬를 없앤다.
            splashFactory: NoSplash.splashFactory,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NoticeScreen(),
            QnaScreen(),
          ],
        ),
      ),
    );
  }
}
