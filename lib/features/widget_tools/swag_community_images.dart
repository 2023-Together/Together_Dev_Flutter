import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class SWAGCommunityImages extends StatelessWidget {
  SWAGCommunityImages({
    super.key,
    required this.images,
  });

  final List<String> images;

  final List<List<String>> _filterImages = [];

  void _filterImagesCheck() {
    final imgLength = images.length;
    final List<String> checkImages = [];
    if (imgLength > 6) {
      checkImages.addAll(images.sublist(0, 7));
    } else {
      checkImages.addAll(images);
    }

    if (imgLength == 1) {
      _filterImages.add(images);
    } else if (imgLength == 2) {
      _filterImages.add(images);
    } else if (imgLength == 3) {
      List<String> subList1 = checkImages.sublist(0, 2);
      List<String> subList2 = checkImages.sublist(2, imgLength);
      _filterImages.addAll([subList1, subList2]);
    } else if (imgLength == 4) {
      List<String> subList1 = checkImages.sublist(0, 2);
      List<String> subList2 = checkImages.sublist(2, imgLength);
      _filterImages.addAll([subList1, subList2]);
    } else if (imgLength == 5) {
      List<String> subList1 = checkImages.sublist(0, 3);
      List<String> subList2 = checkImages.sublist(3, imgLength);
      _filterImages.addAll([subList1, subList2]);
    } else if (imgLength >= 6) {
      List<String> subList1 = checkImages.sublist(0, 3);
      List<String> subList2 = checkImages.sublist(3, 6);
      _filterImages.addAll([subList1, subList2]);
    }
  }

  @override
  Widget build(BuildContext context) {
    _filterImagesCheck();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size10,
      ),
      child: StaggeredGrid.count(
        crossAxisCount: images.length >= 5 ? 3 : 2,
        mainAxisSpacing: Sizes.size4,
        crossAxisSpacing: Sizes.size4,
        children: [
          for (var i = 0; i < _filterImages.length; i++)
            for (var j = 0; j < _filterImages[i].length; j++)
              StaggeredGridTile.count(
                crossAxisCellCount:
                    _filterImages.length == 1 && _filterImages[i].length == 1
                        ? 2
                        : 1,
                mainAxisCellCount:
                    _filterImages.length.isOdd && _filterImages[i].length.isOdd
                        ? 2
                        : (images.length == 3 || images.length == 5) &&
                                (i == 0 && j == 0)
                            ? 2
                            : 1,
                child: images.length > 6
                    ? (i == 1 && j == 2)
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Sizes.size10,
                                ), // 원하는 둥글기 정도를 설정
                                child: Image.asset(
                                  _filterImages[i][j],
                                  fit: BoxFit.fitWidth,
                                ), // 둥글게 처리할 이미지
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size10,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "+${images.length - 6}장",
                                    style: const TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(
                              Sizes.size10,
                            ), // 원하는 둥글기 정도를 설정
                            child: Image.asset(
                              _filterImages[i][j],
                              fit: BoxFit.fitWidth,
                            ), // 둥글게 처리할 이미지
                          )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Sizes.size10,
                        ), // 원하는 둥글기 정도를 설정
                        child: Image.asset(
                          _filterImages[i][j],
                          fit: BoxFit.fitWidth,
                        ), // 둥글게 처리할 이미지
                      ),
              ),
        ],
      ),
    );
  }
}

//   GridView.builder(
      //   physics: const NeverScrollableScrollPhysics(),
      //   shrinkWrap: true,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisSpacing: Sizes.size4,
      //     mainAxisSpacing: Sizes.size4,
      //     crossAxisCount: widget.images.length >= 5 ? 3 : 2,
      //   ),
      //   itemCount:
      //       widget.images.length >= 6 ? 6 : widget.images.length, // 총 이미지 개수
      //   itemBuilder: (BuildContext context, int index) {
      //     if (widget.images.length >= 5) {
      //       // 첫 번째 줄에 3개의 이미지, 두 번째 줄에 2개의 이미지 출력
      //       if (index < 3) {
      //         return SizedBox(
      //           width: double.infinity,
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.circular(
      //               Sizes.size14,
      //             ), // 원하는 둥글기 정도를 설정
      //             child: Image.asset(
      //               widget.images[index],
      //               fit: BoxFit.cover,
      //             ), // 둥글게 처리할 이미지
      //           ),
      //         );
      //       } else if (index < 6) {
      //         // 두 번째 줄
      //         return widget.images.length >= 7 && index == 5
      //             ? Stack(
      //                 children: [
      //                   SizedBox(
      //                     width: double.infinity,
      //                     height: 200,
      //                     child: ClipRRect(
      //                       borderRadius: BorderRadius.circular(
      //                         Sizes.size14,
      //                       ), // 원하는 둥글기 정도를 설정
      //                       child: Image.asset(
      //                         widget.images[index],
      //                         fit: BoxFit.cover,
      //                       ), // 둥글게 처리할 이미지
      //                     ),
      //                   ),
      //                   Container(
      //                     width: double.infinity,
      //                     height: 200,
      //                     decoration: BoxDecoration(
      //                       color: Colors.black26,
      //                       borderRadius: BorderRadius.circular(
      //                         Sizes.size14,
      //                       ),
      //                     ),
      //                     child: Center(
      //                       child: Text(
      //                         "+${widget.images.length - 6}장",
      //                         style: const TextStyle(
      //                           fontSize: 26,
      //                           color: Colors.white,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               )
      //             : SizedBox(
      //                 width: double.infinity,
      //                 child: ClipRRect(
      //                   borderRadius: BorderRadius.circular(
      //                     Sizes.size14,
      //                   ), // 원하는 둥글기 정도를 설정
      //                   child: Image.asset(
      //                     widget.images[index],
      //                     fit: BoxFit.cover,
      //                   ), // 둥글게 처리할 이미지
      //                 ),
      //               );
      //       }
      //     } else {
      //       return SizedBox(
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(
      //             Sizes.size14,
      //           ), // 원하는 둥글기 정도를 설정
      //           child: Image.asset(
      //             widget.images[index],
      //             fit: BoxFit.cover,
      //           ), // 둥글게 처리할 이미지
      //         ),
      //       );
      //     }
      //     return null;
      //   },
      // ),




//        GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisSpacing: Sizes.size4,
//           mainAxisSpacing: Sizes.size4,
//           crossAxisCount: widget.images.length >= 5
//               ? 3
//               : widget.images.length == 1
//                   ? 1
//                   : 2, // 한 줄에 표시할 항목 수
//         ),
//         itemCount:
//             widget.images.length >= 5 ? 5 : widget.images.length, // 총 이미지 개수
//         itemBuilder: (BuildContext context, int index) {
//           if (widget.images.length >= 5) {
//             // 첫 번째 줄에 3개의 이미지, 두 번째 줄에 2개의 이미지 출력
//             if (index < 3) {
//               return SizedBox(
//                 width: _firstLineWidth,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(
//                     Sizes.size14,
//                   ), // 원하는 둥글기 정도를 설정
//                   child: Image.asset(
//                     widget.images[index],
//                     fit: BoxFit.cover,
//                   ), // 둥글게 처리할 이미지
//                 ),
//               );
//             } else if (index < 5) {
//               // 두 번째 줄
//               return widget.images.length >= 6 && index == 4
//                   ? Stack(
//                       children: [
//                         SizedBox(
//                           width: double.infinity,
//                           height: 200,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(
//                               Sizes.size14,
//                             ), // 원하는 둥글기 정도를 설정
//                             child: Image.asset(
//                               widget.images[index],
//                               fit: BoxFit.cover,
//                             ), // 둥글게 처리할 이미지
//                           ),
//                         ),
//                         Container(
//                           width: double.infinity,
//                           height: 200,
//                           decoration: BoxDecoration(
//                             color: Colors.black26,
//                             borderRadius: BorderRadius.circular(
//                               Sizes.size14,
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "+${widget.images.length - 5}장",
//                               style: const TextStyle(
//                                 fontSize: 26,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   : SizedBox(
//                       width: double.infinity,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(
//                           Sizes.size14,
//                         ), // 원하는 둥글기 정도를 설정
//                         child: Image.asset(
//                           widget.images[index],
//                           fit: BoxFit.cover,
//                         ), // 둥글게 처리할 이미지
//                       ),
//                     );
//             }
//           } else {
//             return SizedBox(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(
//                   Sizes.size14,
//                 ), // 원하는 둥글기 정도를 설정
//                 child: Image.asset(
//                   widget.images[index],
//                   fit: BoxFit.cover,
//                 ), // 둥글게 처리할 이미지
//               ),
//             );
//           }
//           return null;
//         },
//       ),



              // widget.images.length > 5 && index == 4
              // ? Stack(
              //     children: [
              //       SizedBox(
              //         width: (size.width - 32) / 3,
              //         height: 200,
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(
              //             Sizes.size14,
              //           ), // 원하는 둥글기 정도를 설정
              //           child: Image.asset(
              //             widget.images[index],
              //             fit: BoxFit.cover,
              //           ), // 둥글게 처리할 이미지
              //         ),
              //       ),
              //       Container(
              //         width: (size.width - 32) / 3,
              //         height: 200,
              //         decoration: BoxDecoration(
              //           color: Colors.black26,
              //           borderRadius: BorderRadius.circular(
              //             Sizes.size14,
              //           ),
              //         ),
              //         child: Center(
              //           child: Text(
              //             "+${widget.images.length - 5}장",
              //             style: const TextStyle(
              //               fontSize: 26,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   )
              // : SizedBox(
              //     width: widget.images.length == 1
              //         ? (size.width - 20)
              //         : widget.images.length == 2
              //             ? (size.width - 26) / 2
              //             : (size.width - 32) / 3,
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(
              //         Sizes.size14,
              //       ), // 원하는 둥글기 정도를 설정
              //       child: Image.asset(
              //         widget.images[index],
              //         fit: BoxFit.cover,
              //       ), // 둥글게 처리할 이미지
              //     ),
              //   );