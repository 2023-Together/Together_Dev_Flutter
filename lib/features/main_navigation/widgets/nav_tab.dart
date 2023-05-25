import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.selectedIcon,
    required this.onTap,
    required this.selectedIndex,
    required this.imgURI,
    required this.logined,
  });

  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;
  final int selectedIndex;
  final String imgURI;
  final bool logined;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size7,
            horizontal: Sizes.size16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size56),
            color: Colors.grey.shade50,
            // color: Colors.blue,
          ),
          // color: Colors.blue,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.6,
            // Column은 세로축으로 최대한 확장 하려고 한다.
            child: Column(
              // 사이즈 조절
              mainAxisSize: MainAxisSize.min,
              children: [
                imgURI.isEmpty
                    ? FaIcon(
                        isSelected ? selectedIcon : icon,
                        size: Sizes.size24 + Sizes.size2,
                      )
                    : logined
                        ? CircleAvatar(
                            radius: Sizes.size12,
                            foregroundImage: NetworkImage(
                              imgURI,
                            ),
                            child: const Text("재현"),
                          )
                        : const FaIcon(
                            FontAwesomeIcons.circleUser,
                            size: 24,
                          ),
                Gaps.v5,
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: Sizes.size10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
