import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/comunity/widgets/comunity_comment.dart';

class ComunityItemBox extends StatefulWidget {
  const ComunityItemBox({
    super.key,
    required this.title,
    required this.img,
    required this.initCheckGood,
    required this.content,
    required this.date,
    required this.user,
  });

  final String title;
  final String content;
  final String img;
  final bool initCheckGood;
  final String date;
  final String user;

  @override
  State<ComunityItemBox> createState() => _ComunityItemBox();
}

class _ComunityItemBox extends State<ComunityItemBox> {
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
      builder: (context) => const ComunityComment(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        clipBehavior: Clip.hardEdge,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.img.isEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size12,
                      vertical: Sizes.size16,
                    ),
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
                    height: 300,
                    decoration: BoxDecoration(
                      // borderRadius: const BorderRadius.only(
                      //   topLeft: Radius.circular(Sizes.size16),
                      //   topRight: Radius.circular(Sizes.size16),
                      // ),
                      image: DecorationImage(
                        image: AssetImage(widget.img),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
            // const Divider(
            //   height: Sizes.size1,
            //   color: Colors.black,
            //   thickness: Sizes.size1,
            // ),
            ListTile(
              leading: CircleAvatar(
                radius: 20,
                child: Text(widget.user),
              ),
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                widget.date,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
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
    );
  }
}
