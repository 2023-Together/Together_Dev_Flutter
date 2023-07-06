import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/community/club/club_comunity_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_state_dropDown_button.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class ClubSearchTestScreen extends StatefulWidget {
  // 필드

  // 생성자
  const ClubSearchTestScreen({super.key});

  @override
  State<ClubSearchTestScreen> createState() => _ClubSearchTestScreenState();
}

class _ClubSearchTestScreenState extends State<ClubSearchTestScreen>
    with SingleTickerProviderStateMixin {
  // 검색 애니메이션 컨트롤러 선언
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final Animation<Offset> _panelSlideAnimation = Tween(
    begin: const Offset(0, -1),
    end: const Offset(0, 0),
  ).animate(_animationController);

  late final Animation<double> _panelOpacityAnimation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(_animationController);

  // 검색 제어를 위한 컨트롤러
  final TextEditingController _searchController = TextEditingController();
  // 포커스 검사
  final FocusNode _focusNode = FocusNode();

  String _option1 = "";
  final List<String> _optionList1 = ["", "옵션 1", "옵션 2", "옵션 3", "옵션 4"];

  String _option2 = "";
  final List<String> _optionList2 = ["", "옵션 1", "옵션 2", "옵션 3", "옵션 4"];

  String _option3 = "";
  final List<String> _optionList3 = ["", "옵션 1", "옵션 2", "옵션 3", "옵션 4"];

  // 카테고리의 공통 스타일
  final double _optionsFontSize = 16;
  final _optionsPadding =
      const EdgeInsets.symmetric(vertical: 6, horizontal: 8);

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  // 애니메이션 동작
  void _toggleAnimations() {
    // 이미 애니메이션이 실행되었다면
    if (_animationController.isCompleted) {
      // 애니메이션을 원래상태로 되돌림
      // 슬라이드가 다올라갈때까지 배리어를 없애면 안됨
      _animationController.reverse();
      // _toggleBarrier();
      _focusNode.unfocus();
    } else {
      // 애니메이션을 실행
      _animationController.forward();
    }

    setState(() {});
  }

  void _alertIconTap(BuildContext context) {
    context.pushNamed(AlertScreen.routeName);
  }

  void _onChangeOption1(String option) {
    setState(() {
      _option1 = option;
    });
  }

  void _onChangeOption2(String option) {
    setState(() {
      _option2 = option;
    });
  }

  void _onChangeOption3(String option) {
    setState(() {
      _option3 = option;
    });
  }

  // void onChangeOption1(String? value) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6524FF),
        child: const Icon(FontAwesomeIcons.pen),
        onPressed: () {},
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("동아리"),
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size14,
              vertical: Sizes.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _toggleAnimations,
                  child: const Icon(Icons.search),
                ),
                Gaps.h2,
                GestureDetector(
                  onTap: () => _alertIconTap(context),
                  child: const Icon(Icons.notifications_none),
                ),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            height: 60,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            // margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SWAGStateDropDownButton(
                  initOption: _option1,
                  onChangeOption: _onChangeOption1,
                  title: "카테고리1",
                  options: _optionList1,
                  fontSize: _optionsFontSize,
                  padding: _optionsPadding,
                ),
                Gaps.h8,
                SWAGStateDropDownButton(
                  initOption: _option2,
                  onChangeOption: _onChangeOption2,
                  title: "카테고리2",
                  options: _optionList2,
                  fontSize: _optionsFontSize,
                  padding: _optionsPadding,
                ),
                Gaps.h8,
                SWAGStateDropDownButton(
                  initOption: _option3,
                  onChangeOption: _onChangeOption3,
                  title: "카테고리3",
                  options: _optionList3,
                  fontSize: _optionsFontSize,
                  padding: _optionsPadding,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            //color: Colors.grey .shade200,
            color: Colors.white,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClubComunityScreen(),
                    ),
                  ),
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
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/club1.jpg',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size10,
                              vertical: Sizes.size8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "제목 ${index + 1}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Divider(),
                                Text(
                                  "동아리${index + 1}에서 부원을 모집합니다. 많은 관심 부탁드립니다 :)",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Gaps.v10,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("SWAG 동아리"),
                                    Text("조회수 ${index * 3}"),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Gaps.v14;
              },
              itemCount: 10,
            ),
          ),
          if (_isFocused)
            // 슬라이드 화면 뒤쪽의 검은 화면 구현
            ModalBarrier(
              // color: _barrierAnimation,
              color: Colors.transparent,
              // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
              dismissible: true,
              // 자신을 클릭하면 실행되는 함수
              onDismiss: () => _focusNode.unfocus(),
            ),
          // 검색 화면
          FadeTransition(
            opacity: _panelOpacityAnimation,
            child: SlideTransition(
              position: _panelSlideAnimation,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(6),
                child: SWAGTextField(
                  hintText: "검색할 제목을 입력해 주세요..",
                  maxLine: 1,
                  controller: _searchController,
                  onSubmitted: () {
                    _searchController.text = "";
                    _focusNode.unfocus();
                    _toggleAnimations();
                  },
                  onChange: () {
                    print(_searchController.text);
                  },
                  buttonText: "검색",
                  focusNode: _focusNode,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
