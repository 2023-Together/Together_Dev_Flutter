import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class SWAGCommunityImages extends StatelessWidget {
  const SWAGCommunityImages({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size10,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (images[index].contains("http://") ||
              images[index].contains("https://")) {
            return SizedBox(
              width: images.length == 1
                  ? null
                  : images.length == 2
                      ? 200
                      : 125,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  Sizes.size14,
                ), // 원하는 둥글기 정도를 설정
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return images.length > 5 && index == 4
                ? Stack(
                    children: [
                      SizedBox(
                        width: (size.width - 32) / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Sizes.size14,
                          ), // 원하는 둥글기 정도를 설정
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                          ), // 둥글게 처리할 이미지
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: images.length == 1
                        ? (size.width - 20)
                        : images.length == 2
                            ? (size.width - 26) / 2
                            : (size.width - 32) / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        Sizes.size14,
                      ), // 원하는 둥글기 정도를 설정
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                      ), // 둥글게 처리할 이미지
                    ),
                  );
          }
        },
        separatorBuilder: (context, index) => Gaps.h6,
        itemCount: images.length > 5 ? 5 : images.length,
      ),
    );
  }
}
