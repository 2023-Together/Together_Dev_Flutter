import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class MainComunityBox extends StatefulWidget {
  const MainComunityBox({
    super.key,
    required this.title,
    required this.img,
    required this.initCheckGood,
  });

  final String title;
  final ImageProvider img;
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

  @override
  Widget build(BuildContext context) {
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
              Container(
                height: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Sizes.size16),
                    topRight: Radius.circular(Sizes.size16),
                  ),
                  image: DecorationImage(
                    image: widget.img,
                    fit: BoxFit.fill,
                  ),
                ),
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
                      onPressed: () {},
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
