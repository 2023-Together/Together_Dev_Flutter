// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:swag_cross_app/constants/gaps.dart';
// import 'package:swag_cross_app/features/search_page/view/vol_detail_screen.dart';

// class SearchVolScreen extends StatefulWidget {
//   // 데이터 요청 테스트 (1365)
//   // static final baseUrl = "http://openapi.1365.go.kr/openapi/service/rest/VolunteerPartcptnService";
//   // static final volList = "getVltrSearchWordList";

//   const SearchVolScreen({super.key});

//   @override
//   State<SearchVolScreen> createState() => _SearchVolScreenState();
// }

// // 봉사 유형
// class _SearchVolScreenState extends State<SearchVolScreen> {
//   final List<String> _typeList = [
//     "유형",
//     "생활편의지원",
//     "주거환경",
//     "상담",
//     "교육",
//     "보건의료",
//     "농어촌 봉사",
//     "문화행사",
//     "환경보호",
//     "행정보조",
//     "안전,예방",
//     "공익,인권",
//     "재해,재난",
//     "국제협력,해외봉사",
//     "멘토링",
//     "자원봉사교육",
//     "국제행사",
//     "기타",
//   ];

//   String _selectedValue = "유형";

//   // 지역
//   final List<String> _areaList = [
//     "지역",
//     "가좌동",
//     "강남동",
//     "계동",
//     "귀곡동",
//     "금곡면",
//     "금산면",
//     "남성동",
//     "내동면",
//     "대곡면",
//     "대안동",
//     "대평면",
//     "동성동",
//     "망경동",
//     "명석면",
//     "문산읍",
//     "미천면",
//     "본성동",
//     "봉곡동",
//     "봉래동",
//     "사봉면",
//     "상대동",
//     "상봉동",
//     "상평동",
//     "수곡면",
//     "수정동",
//     "신안동",
//     "옥봉동",
//     "유곡동",
//     "이반성면",
//     "이현동",
//     "인사동",
//     "일반성면",
//     "장대동",
//     "장재동",
//     "정촌면",
//     "주약동",
//     "중안동",
//     "지수면",
//     "진성면",
//     "집현면",
//     "초전동",
//     "충무공동",
//     "칠암동",
//     "판문동",
//     "평거동",
//     "평안동",
//     "하대동",
//     "하촌동",
//     "호탄동",
//   ];

//   String _selectedValueArea = "지역";

//   // 인증 구분
//   final List<String> _certificationList = [
//     "인증구분",
//     "시간인증",
//     "활동인증",
//   ];

//   String _selectedValueCertification = "인증구분";

//   Future<void> _showAlertDialog() async {
//     // 봉사 신청여부 모달창
//     return showDialog<void>(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('봉사 신청'),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: const <Widget>[
//                   Text('해당 봉사를 신청하시겠습니까?'),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 // 취소 버튼
//                 onPressed: () {
//                   context.pop();
//                 },
//                 child: const Text('아니오'),
//               ),
//               TextButton(
//                 // 신청 버튼
//                 onPressed: () {},

//                 child: const Text('예'),
//               ),
//             ],
//           );
//         });
//   }

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _selectedValue = _typeList[0];
//       _selectedValueArea = _areaList[0];
//       _selectedValueCertification = _certificationList[0];
//     });
//     // setState(() {
//     //   _selectedValueArea = _areaList[0];
//     // });
//     // setState(() {
//     //   _selectedValueCertification = _certificationList[0];
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("봉사 검색"),
//         centerTitle: true,
//         elevation: 0.5,
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               // 상세 검색 -> bottom sheet 모달 창 구현
//               showModalBottomSheet<void>(
//                 context: context,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 builder: (BuildContext context) {
//                   return SizedBox(
//                     height: 450.0,
//                     child: Column(
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             IconButton(
//                               onPressed: () => context.pop(),
//                               icon: const Icon(
//                                 Icons.close_rounded,
//                                 color: Colors.lightBlue,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0, vertical: 16.0),
//                           child: Row(
//                             children: [
//                               DropdownButton(
//                                 hint: const Text("봉사 유형"),
//                                 value: _selectedValue,
//                                 items: _typeList.map(
//                                   (value) {
//                                     return DropdownMenuItem(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   },
//                                 ).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _selectedValue = value!;
//                                   });
//                                 },
//                               ),
//                               DropdownButton(
//                                 hint: const Text("지역"),
//                                 value: _selectedValueArea,
//                                 items: _areaList.map(
//                                   (value) {
//                                     return DropdownMenuItem(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   },
//                                 ).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _selectedValueArea = value!;
//                                   });
//                                 },
//                               ),
//                               DropdownButton(
//                                 hint: const Text("인증구분"),
//                                 value: _selectedValueCertification,
//                                 items: _certificationList.map(
//                                   (value) {
//                                     return DropdownMenuItem(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   },
//                                 ).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _selectedValueCertification = value!;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                           child: TextFormField(
//                             decoration: const InputDecoration(
//                                 prefixIcon: Icon(Icons.search),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                   width: 1,
//                                   color: Colors.grey,
//                                 )),
//                                 hintText: "기관명 또는 봉사제목"),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ).then((value) => setState(
//                     () {},
//                   ));
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications_outlined),
//             onPressed: () {
//               print("알림함");
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 10,
//           horizontal: 12,
//         ),
//         child: ListView.separated(
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const VolDetailScreen(),
//                   ),
//                 );
//               },
//               child: Container(
//                 color: Colors.white,
//                 padding: const EdgeInsets.only(
//                   top: 10,
//                   bottom: 10,
//                   right: 10,
//                   left: 10,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "전시 안내 및 데스크 보조 모집합니다.",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 10),
//                     const SizedBox(
//                       height: 26,
//                       child: Text(
//                         "전시 안내 및 안내 데스크 보조 자원봉사자 구합니다!",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12.0,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Expanded(
//                           child: Text(
//                             "진주시  |  가좌동",
//                             style: TextStyle(
//                               fontSize: 16,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Gaps.h10,
//                             ElevatedButton(
//                               // 신청하기 버튼
//                               onPressed: () {
//                                 _showAlertDialog();
//                               },
//                               child: const Text("신청하기"),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//           separatorBuilder: (context, index) {
//             return Gaps.v10;
//           },
//           itemCount: 15, // 게시글 갯수
//         ),
//       ),
//       backgroundColor: Colors.grey.shade200,
//     );
//   }
// }
