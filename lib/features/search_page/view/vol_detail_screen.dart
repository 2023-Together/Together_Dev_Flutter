import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/search_page/widgets/vol_search_persistent_tab_bar.dart';

class VolDetailScreenArgs {
  final String id;
  final String title;
  final String contnet;
  final String host;
  final String locationStr;
  final String startTime;
  final String endTime;
  final int tabBarSelected;

  VolDetailScreenArgs({
    required this.id,
    required this.title,
    required this.contnet,
    required this.host,
    required this.locationStr,
    required this.startTime,
    required this.endTime,
    required this.tabBarSelected,
  });
}

class VolDetailScreen extends StatefulWidget {
  static const routeName = "vol_detail";
  static const routeURL = "/vol_detail";

  final String id;
  final String title;
  final String contnet;
  final String host;
  final String locationStr;
  final String startTime;
  final String endTime;
  final int tabBarSelected;

  const VolDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.contnet,
    required this.host,
    required this.locationStr,
    required this.startTime,
    required this.endTime,
    required this.tabBarSelected,
  });

  @override
  State<VolDetailScreen> createState() => _VolDetailScreenState();
}

class _VolDetailScreenState extends State<VolDetailScreen>
    with TickerProviderStateMixin {
  static final LatLng schoolLatlng = LatLng(
    // 위도와 경도 값 지정
    35.165992,
    128.096785,
  );

  static final CameraPosition initialPosition = CameraPosition(
    target: schoolLatlng, // 카메라 위치
    zoom: 15, // 확대 정도
  );
  late TabController _tabController; // tabbar와 tabview를 제어하는데 필요

// initState에서 tabController를 초기설정
  @override
  void initState() {
    // _tabController = TabController(
    //   length: 3,
    //   vsync: this,
    // );
    super.initState();
  }

  Widget introScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              height: 80,
              child: Text(
                widget.contnet,
                style: TextStyle(
                  height: 2,
                ),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: DataTable(
                // columns : 표의 첫 행에 들어가는 데이터 리스트이자 각 열의 이름
                columns: [
                  DataColumn(
                      label: Text(
                    "상세 정보",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                  DataColumn(
                    label: Container(),
                  ),
                ],
                // rows : 표 각 행의 셀에 들어가는 데이터 리스트
                rows: [
                  DataRow(cells: [
                    DataCell(Text('기관명')),
                    DataCell(Text(widget.host)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('위치')),
                    DataCell(Text(widget.locationStr)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('모집 인원')),
                    DataCell(Text("3명")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('봉사 모집 시작일')),
                    DataCell(Text(widget.startTime)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('봉사 모집 마감일')),
                    DataCell(Text(widget.endTime)),
                  ]),
                ],
              ),
            )
          ])
        ],
      ),
    );
  }

  Widget hostMapScreen() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: GoogleMap(
          initialCameraPosition: initialPosition,
          mapType: MapType.hybrid,
        ),
      ),
    );
  }

  Future<void> _showAlertDialog() async {
    // 봉사 신청여부 모달창
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('봉사 신청'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('해당 봉사를 신청하시겠습니까?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                // 취소 버튼
                onPressed: () {
                  context.pop();
                },
                child: const Text('아니오'),
              ),
              TextButton(
                // 신청 버튼
                onPressed: () {},
                child: const Text('예'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("상세 정보"),
        centerTitle: true,
        elevation: 0.5,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              // 아이콘 클릭 시 bottom sheet 모달 창 생성 (검색 창)
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                print("알림함");
              }),
        ],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 14.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          widget.title,
                          style: TextStyle(
                            height: 3,
                          ),
                        ),
                        subtitle: Text(
                          widget.contnet,
                          style: TextStyle(
                            height: 1.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 30.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 22,
                              backgroundImage: AssetImage(
                                "assets/images/yonam.jpg",
                              ),
                            ),
                            Gaps.h10,
                            Column(
                              children: [
                                Text(
                                  widget.host,
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: VolSearchPersistentTabBar(),
                pinned: true,
              ),
            ],
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Offstage(
                  offstage: false,
                  child: introScreen(),
                ),
                Offstage(
                  offstage: false,
                  child: hostMapScreen(),
                ),
              ],
            ),
          ),
        ),
        // body: Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10),
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         height: 250.0,
        //         child: Padding(
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               const Padding(
        //                 padding: EdgeInsets.symmetric(horizontal: 10),
        //                 child: Text(
        //                   " [ 전시 안내 및 데스크 보조 모집 ]",
        //                   style: TextStyle(
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.w500,
        //                   ),
        //                 ),
        //               ),
        //               //const SizedBox(height: 10),
        //               // const Padding(
        //               //   padding: EdgeInsets.symmetric(horizontal: 10),
        //               //   child: Text(
        //               //     "전시 안내 및 안내 데스크 보조 자원봉사자 구합니다!",
        //               //     style: TextStyle(
        //               //       color: Colors.grey,
        //               //       fontSize: 12.0,
        //               //     ),
        //               //   ),
        //               // ),
        //               const SizedBox(height: 10),
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(horizontal: 10),
        //                 child: Column(
        //                   children: const [
        //                     Text(" 모집기관: 진주 박물관 "),
        //                     Text(" 봉사기간: 2023.7.6 ~ 2023.8.30 "),
        //                     Text(" 봉사시간: 13:00 ~ 16:00 "),
        //                     Text(" 모집인원: 1명 "),
        //                   ],
        //                 ),
        //               ),
        //               // const SizedBox(height: 00),
        //               Column(
        //                 children: [
        //                   Container(
        //                     child: TabBar(
        //                       tabs: [
        //                         Container(
        //                           height: 60.0,
        //                           alignment: Alignment.center,
        //                           child: const Text(
        //                             "봉사 정보",
        //                             style: TextStyle(
        //                               color: Colors.grey,
        //                             ),
        //                           ),
        //                         ),
        //                         Container(
        //                           height: 60.0,
        //                           alignment: Alignment.center,
        //                           child: const Text(
        //                             "기관 정보",
        //                             style: TextStyle(
        //                               color: Colors.grey,
        //                             ),
        //                           ),
        //                         ),
        //                         Container(
        //                           height: 60.0,
        //                           alignment: Alignment.center,
        //                           child: const Text(
        //                             "기관 위치",
        //                             style: TextStyle(
        //                               color: Colors.grey,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                       labelColor: Colors.white, // 선택된 tab의 label 색상
        //                       unselectedLabelColor:
        //                           Colors.black, // 선택되지 않은 tab의 label 생상
        //                       controller: _tabController,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               Expanded(
        //                 child: TabBarView(
        //                   controller: _tabController,
        //                   children: <Widget>[
        //                     Container(
        //                       color: Colors.lightBlue[200],
        //                       // height: 300,
        //                       alignment: Alignment.center,
        //                       child: const Text(
        //                         '봉사 상세 정보',
        //                         style: TextStyle(
        //                           fontSize: 30,
        //                         ),
        //                       ),
        //                     ),
        //                     Container(
        //                       color: Colors.lightGreen,
        //                       alignment: Alignment.center,
        //                       child: const Text(
        //                         '기관 정보',
        //                         style: TextStyle(
        //                           fontSize: 30,
        //                         ),
        //                       ),
        //                     ),
        //                     Container(
        //                       color: const Color.fromARGB(255, 239, 132, 167),
        //                       alignment: Alignment.center,
        //                       child: const Text(
        //                         '지도 삽입',
        //                         style: TextStyle(
        //                           fontSize: 30,
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border_outlined),
                onPressed: () {},
              ),
              SizedBox(
                width: 300.0,
                height: 40.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    _showAlertDialog();
                  },
                  child: const Text("신청하기"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
