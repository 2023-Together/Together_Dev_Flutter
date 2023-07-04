import 'dart:io';

import 'package:flutter/material.dart';

class SWAGImgFile extends StatefulWidget {
  const SWAGImgFile({
    super.key,
    required this.img,
  });

  final String img;

  @override
  State<SWAGImgFile> createState() => _SWAGImgFileState();
}

class _SWAGImgFileState extends State<SWAGImgFile> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: AnimatedOpacity(
        opacity: _isSelected ? 0.7 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(widget.img),
              fit: BoxFit.cover,
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Icon(
                _isSelected
                    ? Icons.check_circle_rounded
                    : Icons.circle_outlined,
                color: _isSelected ? Colors.lightGreen.shade400 : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
