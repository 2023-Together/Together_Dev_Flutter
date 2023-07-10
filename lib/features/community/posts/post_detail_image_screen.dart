import 'package:flutter/material.dart';

class PostDetailImageScreen extends StatelessWidget {
  const PostDetailImageScreen({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: "detail_img",
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
