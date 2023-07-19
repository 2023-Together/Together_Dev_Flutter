import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/widget_tools/swag_custom_indicator.dart';

class PostDetailIntroScreen extends StatefulWidget {
  const PostDetailIntroScreen({
    super.key,
    this.title,
    this.content,
    this.images,
  });

  final String? title;
  final String? content;
  final List<String>? images;

  @override
  State<PostDetailIntroScreen> createState() => _PostDetailIntroScreenState();
}

class _PostDetailIntroScreenState extends State<PostDetailIntroScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 페이지 상태 유지를 위해 true 반환

  final PageController _imagesPageController = PageController();

  int _currentIndicatorPage = 0;
  bool _showRightArrow = true;
  bool _showLeftArrow = false;

  @override
  void initState() {
    super.initState();

    if (widget.images != null) {
      if (widget.images!.length == 1) {
        _showRightArrow = false;
      }
    }
  }

  @override
  void dispose() {
    _imagesPageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 반드시 super.build(context) 호출해야 함
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          if (widget.images != null)
            if (widget.images!.isNotEmpty)
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: 350,
                        child: PageView.builder(
                          onPageChanged: (value) => setState(() {
                            _currentIndicatorPage = value;
                            if (widget.images!.length > 1) {
                              if (value == 0) {
                                _showRightArrow = true;
                                _showLeftArrow = false;
                              } else if (value == widget.images!.length - 1) {
                                _showRightArrow = false;
                                _showLeftArrow = true;
                              } else {
                                _showRightArrow = true;
                                _showLeftArrow = true;
                              }
                            }
                          }),
                          controller: _imagesPageController,
                          itemCount: widget.images!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              // onTap: () => context.push,
                              child: Image.asset(
                                widget.images![index],
                                width: size.width,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        left: 10,
                        height: 350,
                        child: AnimatedOpacity(
                          opacity: _showLeftArrow ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _imagesPageController.previousPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease);
                                _currentIndicatorPage =
                                    _currentIndicatorPage - 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.9),
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_left_rounded,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        height: 350,
                        child: AnimatedOpacity(
                          opacity: _showRightArrow ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _imagesPageController.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease);
                                _currentIndicatorPage =
                                    _currentIndicatorPage + 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.9),
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gaps.v10,
                  SWAGCustomIndicator(
                    currentIndex: _currentIndicatorPage,
                    itemLength: widget.images!.length,
                  ),
                ],
              ),
          Gaps.v10,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            width: size.width,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.title != null)
                  Text(
                    widget.title!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                Gaps.v10,
                if (widget.content != null)
                  Text(
                    widget.content!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
