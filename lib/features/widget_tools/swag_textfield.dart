import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class SWAGTextField extends StatefulWidget {
  const SWAGTextField({
    super.key,
    required this.hintText,
    required this.maxLine,
    required this.controller,
    required this.onChange,
    required this.onSubmitted,
    required this.buttonText,
  });

  final String hintText; // 힌트
  final int maxLine; // 최대 줄 개수
  final TextEditingController controller; // text 컨트롤러
  final Function onChange; // 값이 변경될때 실행될 함수
  final Function onSubmitted; // 확인 버튼 누를때 실행될 함수
  final String buttonText; // 버튼의 텍스트

  @override
  State<SWAGTextField> createState() => _SWAGTextFieldState();
}

class _SWAGTextFieldState extends State<SWAGTextField> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextField(
            onSubmitted: (value) => widget.onSubmitted,
            onChanged: (value) {
              _isEditing = value.isEmpty ? false : true;
              widget.onChange();
              setState(() {});
            },
            maxLines: widget.maxLine,
            controller: widget.controller,
            cursorColor: const Color(0xFf6524FF),
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hintText,
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: const Color(0xFF767676).withOpacity(0.7),
                fontSize: 18,
              ),
              // border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFDBDBDB),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFF6524FF),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
            ),
            style: const TextStyle(
              color: Color(0xFF191919),
              fontSize: 18,
            ),
          ),
        ),
        Gaps.h6,
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              if (_isEditing) {
                widget.onSubmitted();
              }
            },
            // AnimatedContainer : 해당 컨테이너에 대한 모든 변화를 애니메이션화 한다.
            // 본인만 애니메이션만 적용시키고 자식은 적용 시키지 않는다.
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
              decoration: BoxDecoration(
                color:
                    _isEditing ? const Color(0xFF6524FF) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(Sizes.size5),
              ),
              // AnimatedDefaultTextStyle : 해당 텍스트에 대한 모든 변화를 애니메이션화 한다.
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: _isEditing ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: Sizes.size16,
                ),
                child: Text(
                  widget.buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
