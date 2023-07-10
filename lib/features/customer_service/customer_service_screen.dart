import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/customer_service/notice/notice_screen.dart';
import 'package:swag_cross_app/features/customer_service/qna/qna_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

final tabs = [
  "공지사항",
  "QnA",
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
  // 포커스 검사
  final FocusNode _focusNode = FocusNode();

  bool _isFocused = false;

  late bool _isThereSearchValue = _textSearchController.text.isNotEmpty;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_handleFocusChange);

    _selectedIndex = widget.initSelectedIndex;
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      _isThereSearchValue = value.isNotEmpty;
    });
  }

  void _onSearchSubmitted() {
    print(_textSearchController.text);
  }

  void _onTabBar(int value) {
    _focusNode.unfocus();
    _selectedIndex = value;
    setState(() {});
  }

  void _onCloseIcon() {
    setState(() {
      _textSearchController.text = '';
      _isThereSearchValue = false;
    });
  }

  void _alertIconTap() {
    context.pushNamed(AlertScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initSelectedIndex,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          // 자동 뒤로가기 생성 여부
          automaticallyImplyLeading: true,
          // 맨아래 구분선
          elevation: 1,
          leadingWidth: 30,
          // ConstrainedBox : 최대 크기, 최소 크기를 지정할수 있음
          // 만약 Container를 사용하고 있다면 ConstrainedBox를 사용할 필요 X
          // Container가 constraints속성을 가지고 있기때문
          title: SWAGTextField(
            hintText: "검색어를 입력하세요.",
            maxLine: 1,
            controller: _textSearchController,
            isLogined: widget.isLogined,
            buttonText: "검색",
            onSubmitted: _onSearchSubmitted,
            focusNode: _focusNode,
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
        body: Stack(
          children: [
            TabBarView(
              children: [
                NoticeScreen(isLogined: widget.isLogined),
                QnAScreen(
                  isFocused: _isFocused,
                  isLogined: widget.isLogined,
                ),
              ],
            ),
            if (_isFocused)
              ModalBarrier(
                // color: _barrierAnimation,
                color: Colors.transparent,
                // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
                dismissible: true,
                // 자신을 클릭하면 실행되는 함수
                onDismiss: () => _focusNode.unfocus(),
              ),
          ],
        ),
      ),
    );
  }
}
