import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/utils/time_parse.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({
    super.key,
    required this.username,
    required this.date,
    required this.comment,
    required this.id,
  });

  final String username;
  final String date;
  final String comment;
  final int id;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _isExpanded = false;
  bool _isTextOverflowed = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkTextOverflow();
    });
  }

  void _checkTextOverflow() {
    TextSpan text = TextSpan(
      text: widget.comment,
      style: Theme.of(context).textTheme.bodyMedium,
    );
    TextPainter textPainter = TextPainter(
      text: text,
      maxLines: 4,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 32);

    setState(() {
      _isTextOverflowed = textPainter.didExceedMaxLines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: Sizes.size16,
            right: Sizes.size16,
            bottom: Sizes.size6,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: widget.username,
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text:
                                    ' ㆍ ${TimeParse.getTimeAgo(DateTime.parse(widget.date))}',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text(
                                "삭제",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      widget.comment,
                      maxLines: _isExpanded ? null : 4,
                      overflow: _isExpanded ? null : TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (_isTextOverflowed)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(
                          _isExpanded ? "간략히 보기" : "더 보기",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
