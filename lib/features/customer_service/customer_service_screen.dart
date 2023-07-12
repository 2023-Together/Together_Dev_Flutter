import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/customer_service/faq/faq_screen.dart';
import 'package:swag_cross_app/features/customer_service/inquiry/inquiry_screen.dart';
import 'package:swag_cross_app/features/customer_service/suggestion/suggestion_screen.dart';

final tabs = [
  "FAQ",
  "문의하기",
  "건의하기",
];

class CustomerServiceScreenArgs {
  final int initSelectedIndex;
  final bool isLogined;

  CustomerServiceScreenArgs({
    required this.initSelectedIndex,
    required this.isLogined,
  });
}

class CustomerServiceScreen extends StatefulWidget {
  static const routeName = "customer_services";
  static const routeURL = "/customer_services";

  const CustomerServiceScreen({
    super.key,
    required this.initSelectedIndex,
    required this.isLogined,
  });

  final int initSelectedIndex;
  final bool isLogined;

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  final TextEditingController _textSearchController = TextEditingController();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initSelectedIndex;
  }

  void _onSearchSubmitted() {
    print(_textSearchController.text);
  }

  void _onTabBar(int value) {
    FocusScope.of(context).unfocus();
    _selectedIndex = value;
    setState(() {});
  }

  void _onCloseIcon() {
    setState(() {
      _textSearchController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        initialIndex: widget.initSelectedIndex,
        length: tabs.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            // 자동 뒤로가기 생성 여부
            automaticallyImplyLeading: true,
            // 맨아래 구분선
            elevation: 1,
            leadingWidth: 30,
            // ConstrainedBox : 최대 크기, 최소 크기를 지정할수 있음
            // 만약 Container를 사용하고 있다면 ConstrainedBox를 사용할 필요 X
            // Container가 constraints속성을 가지고 있기때문
            title: const Text("고객센터"),
            bottom: TabBar(
              onTap: (value) => _onTabBar(value),
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              // 선택한 탭의 밑줄 색
              indicatorColor: Colors.purple.shade300,
              labelPadding: const EdgeInsets.symmetric(
                vertical: Sizes.size10,
              ),
              indicatorSize: TabBarIndicatorSize.label,
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
          body: TabBarView(
            children: [
              Offstage(
                offstage: false,
                child: FAQScreen(
                  isLogined: widget.isLogined,
                ),
              ),
              Offstage(
                offstage: false,
                child: InquiryScreen(
                  isLogined: widget.isLogined,
                ),
              ),
              Offstage(
                offstage: false,
                child: SuggestionScreen(
                  isLogined: widget.isLogined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
