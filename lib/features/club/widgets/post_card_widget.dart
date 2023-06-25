import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/club/club_post_detail_screen.dart';
import 'package:swag_cross_app/features/comunity/widgets/comunity_comment.dart';

class ClubPostCardItem extends StatefulWidget {
  const ClubPostCardItem({
    super.key,
    required this.title,
    required this.img,
    required this.initCheckGood,
    required this.content,
    required this.date,
    required this.user,
    required this.isLogined,
    required this.index,
  });

  final String title;
  final String content;
  final String img;
  final bool initCheckGood;
  final String date;
  final String user;
  final bool isLogined;
  final int index;

  @override
  State<ClubPostCardItem> createState() => _ClubPostCardItem();
}

class _ClubPostCardItem extends State<ClubPostCardItem> {
  late bool _checkGood;
  final imgHeight = 175.0;

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
          color: Colors.white,
          // border: const Border(
          //   bottom: BorderSide(
          //     width: 0.5,
          //     color: Colors.black12,
          //   ),
          // ),
          borderRadius: widget.index == 0
              ? const BorderRadius.only(
                  topLeft: Radius.circular(Sizes.size20),
                  topRight: Radius.circular(Sizes.size20),
                )
              : BorderRadius.zero,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
              ),
              leading: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/77985708?v=4",
                ),
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                widget.user,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: const Text(
                "2개월전",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: PopupMenuButton<String>(
                offset: const Offset(0, 25),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        print("게시글 수정");
                      },
                      child: const Text("수정"),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        print("게시글 삭제");
                      },
                      child: const Text("삭제"),
                    ),
                  ];
                },
                child: const Icon(Icons.more_vert),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ClubPostDetailScreen()));
              },
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.only(
                      left: Sizes.size12,
                      right: Sizes.size12,
                      bottom: Sizes.size20,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                        height: 1.5,
                      ),
                    ),
                  ),
                  if (widget.img.isNotEmpty)
                    widget.img.contains("https") || widget.img.contains("http")
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size10,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: imgHeight,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size14,
                                      ), // 원하는 둥글기 정도를 설정
                                      child: Image.network(
                                        widget.img,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: imgHeight,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size14,
                                      ), // 원하는 둥글기 정도를 설정
                                      child: Image.network(
                                        widget.img,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: imgHeight,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size14,
                                      ), // 원하는 둥글기 정도를 설정
                                      child: Image.network(
                                        widget.img,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size10,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: imgHeight,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size14,
                                      ), // 원하는 둥글기 정도를 설정
                                      child: Image.asset(
                                        widget.img,
                                        fit: BoxFit.fitHeight,
                                      ), // 둥글게 처리할 이미지
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: imgHeight,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size14,
                                      ), // 원하는 둥글기 정도를 설정
                                      child: Image.asset(
                                        widget.img,
                                        fit: BoxFit.fitHeight,
                                      ), // 둥글게 처리할 이미지
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: imgHeight,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size8,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size14,
                                      ), // 원하는 둥글기 정도를 설정
                                      child: Image.asset(
                                        widget.img,
                                        fit: BoxFit.fitHeight,
                                      ), // 둥글게 처리할 이미지
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: _onGoodTap,
                    icon: FaIcon(
                      widget.isLogined
                          ? _checkGood
                              ? FontAwesomeIcons.solidThumbsUp
                              : FontAwesomeIcons.thumbsUp
                          : FontAwesomeIcons.thumbsUp,
                      color: widget.isLogined
                          ? _checkGood
                              ? Colors.blue.shade600
                              : Colors.black
                          : Colors.black,
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
