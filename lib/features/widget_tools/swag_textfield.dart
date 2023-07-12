import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';

class SWAGTextField extends StatefulWidget {
  const SWAGTextField({
    super.key,
    required this.hintText,
    required this.maxLine,
    required this.controller,
    required this.isLogined,
    this.onChanged,
    this.onSubmitted,
    this.buttonText,
    this.focusNode,
    this.errorText,
    this.isPassword = false,
  });

  final String hintText; // 힌트
  final int maxLine; // 최대 줄 개수
  final TextEditingController controller; // text 컨트롤러
  final Function(String?)? onChanged; // 값이 변경될때 실행될 함수
  final Function? onSubmitted; // 확인 버튼 누를때 실행될 함수
  final String? buttonText; // 버튼의 텍스트
  final FocusNode? focusNode;
  final bool isLogined;
  final String? errorText;
  final bool isPassword;

  @override
  State<SWAGTextField> createState() => _SWAGTextFieldState();
}

class _SWAGTextFieldState extends State<SWAGTextField> {
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextField(
            focusNode: widget.focusNode,
            onSubmitted: (value) {
              if (widget.onSubmitted != null) {
                widget.onSubmitted!();
              }
            },
            // onChanged: widget.onChanged,
            onChanged: (value) {
              _isEditing = value.trim().isEmpty ? false : true;
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
              setState(() {});
            },
            maxLines: widget.maxLine,
            controller: widget.controller,
            enabled: widget.isLogined,
            obscureText: widget.isPassword,
            cursorColor: const Color(0xFf6524FF),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hintText,
              errorText: widget.errorText,
              errorMaxLines: 2,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 18,
                fontWeight: FontWeight.normal,
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
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),
        ),
        Gaps.h6,
        if (widget.buttonText != null)
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: _isEditing && widget.onSubmitted != null
                  ? () {
                      widget.onSubmitted!();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 18,
                ),
                backgroundColor: Colors.purple.shade300,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(widget.buttonText ?? "버튼"),
            ),
          ),
      ],
    );
  }
}
