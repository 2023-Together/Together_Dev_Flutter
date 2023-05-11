import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/comunity/widgets/main_comment.dart';

class MainComunityBox extends StatefulWidget {
  const MainComunityBox({
    super.key,
    required this.title,
    required this.img,
    required this.initCheckGood,
    required this.content,
  });

  final String title;
  final String content;
  final String img;
  final bool initCheckGood;

  @override
  State<MainComunityBox> createState() => _MainComunityBoxState();
}

class _MainComunityBoxState extends State<MainComunityBox> {
  late bool _checkGood;

  @override
  void initState() {
    super.initState();

    _checkGood = widget.initCheckGood;
  }

  void _onGoodTap() {
    if (_checkGood) {
      _checkGood = !_checkGood;
    } else {
      _checkGood = !_checkGood;
    }
    setState(() {});
  }

  // 댓글 상세페이지
  void _comunityComment() {
    showModalBottomSheet(
      context: context,
      // bottom sheet의 사이즈를 바꿀수 있게 해준다.
      isScrollControlled: true,
      builder: (context) => const MainComment(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
        vertical: Sizes.size6,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(
              Sizes.size16,
            ),
          ),
          child: Column(
            children: [
              widget.img.isEmpty
                  ? Container(
                      padding: const EdgeInsets.all(Sizes.size10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.content,
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Container(
                      height: 150,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(Sizes.size16),
                          topRight: Radius.circular(Sizes.size16),
                        ),
                        image: DecorationImage(
                          image: AssetImage(widget.img),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              const Divider(
                height: Sizes.size1,
                color: Colors.black,
                thickness: Sizes.size1,
              ),
              ListTile(
                title: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const FaIcon(
                    //     FontAwesomeIcons.heart,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    IconButton(
                      onPressed: _onGoodTap,
                      icon: FaIcon(
                        _checkGood
                            ? FontAwesomeIcons.solidThumbsUp
                            : FontAwesomeIcons.thumbsUp,
                        color: _checkGood ? Colors.blue.shade600 : Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: _comunityComment,
                      icon: const FaIcon(
                        FontAwesomeIcons.comment,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
