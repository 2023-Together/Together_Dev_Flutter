import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class SWAGCommunityImages extends StatefulWidget {
  const SWAGCommunityImages({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<SWAGCommunityImages> createState() => _SWAGCommunityImagesState();
}

class _SWAGCommunityImagesState extends State<SWAGCommunityImages> {
  final ScrollController _scrollController = ScrollController();
  bool _showLeftArrow = false;
  bool _showRightArrow = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        _showLeftArrow = _scrollController.position.pixels > 0;
        _showRightArrow = _scrollController.position.pixels <
            _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size10,
          ),
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (widget.images[index].contains("http://") ||
                  widget.images[index].contains("https://")) {
                return SizedBox(
                  width: widget.images.length == 1
                      ? null
                      : widget.images.length == 2
                          ? 200
                          : 125,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Sizes.size14,
                    ), // 원하는 둥글기 정도를 설정
                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return widget.images.length > 5 && index == 4
                    ? Stack(
                        children: [
                          SizedBox(
                            width: (size.width - 32) / 3,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Sizes.size14,
                              ), // 원하는 둥글기 정도를 설정
                              child: Image.asset(
                                widget.images[index],
                                fit: BoxFit.cover,
                              ), // 둥글게 처리할 이미지
                            ),
                          ),
                          Container(
                            width: (size.width - 32) / 3,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(
                                Sizes.size14,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "+${widget.images.length - 5}장",
                                style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : SizedBox(
                        width: widget.images.length == 1
                            ? (size.width - 20)
                            : widget.images.length == 2
                                ? (size.width - 26) / 2
                                : (size.width - 32) / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Sizes.size14,
                          ), // 원하는 둥글기 정도를 설정
                          child: Image.asset(
                            widget.images[index],
                            fit: BoxFit.cover,
                          ), // 둥글게 처리할 이미지
                        ),
                      );
              }
            },
            separatorBuilder: (context, index) => Gaps.h6,
            itemCount: widget.images.length > 5 ? 5 : widget.images.length,
          ),
        ),
        Positioned(
          left: 15,
          height: 200,
          child: AnimatedOpacity(
            opacity: widget.images.length > 3 && _showLeftArrow ? 1 : 0,
            duration: const Duration(milliseconds: 200),
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
        Positioned(
          right: 15,
          height: 200,
          child: AnimatedOpacity(
            opacity: widget.images.length > 3 && _showRightArrow ? 1 : 0,
            duration: const Duration(milliseconds: 200),
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
      ],
    );
  }
}
