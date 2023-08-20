import 'dart:math';

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
  final String actPlace;
  final String teenager;
  final String listApiType;
  final int tabBarSelected;

  VolDetailScreenArgs({
    required this.id,
    required this.title,
    required this.contnet,
    required this.host,
    required this.locationStr,
    required this.actPlace,
    required this.teenager,
    required this.listApiType,
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
  final String actPlace;
  final String teenager;
  final String listApiType;
  final int tabBarSelected;

  const VolDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.contnet,
    required this.host,
    required this.locationStr,
    required this.teenager,
    required this.listApiType,
    required this.actPlace,
    required this.tabBarSelected,
  });

  @override
  State<VolDetailScreen> createState() => _VolDetailScreenState();
}

class _VolDetailScreenState extends State<VolDetailScreen>
    with TickerProviderStateMixin {
  late GoogleMapController _controller;

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
          color: Color.fromARGB(255, 152, 152, 152),
          fontSize: 15,
          fontWeight: FontWeight.w700,
          height: 3),
    );
  }

  static const LatLng schoolLatlng = LatLng(
    // 위도와 경도 값 지정
    35.165992,
    128.096785,
  );

  final List<Marker> markers = [];

  addMarker(cordinate) {
    int id = Random().nextInt(100);

    setState(() {
      markers
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  static CameraPosition initialPosition = const CameraPosition(
    target: schoolLatlng, // 카메라 위치
    zoom: 15, // 확대 정도
  );
  //late TabController _tabController; // tabbar와 tabview를 제어하는데 필요

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
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 187,
                    height: 80,
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.place),
                        title: const Text(
                          "위치",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        subtitle: Text(
                          widget.locationStr,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 187,
                    height: 80,
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.perm_identity),
                        title: Text(
                          "모집 인원",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        subtitle: Text(
                          "3명",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 187,
              //       height: 80,
              //       child: Card(
              //         child: ListTile(
              //           leading: const Icon(Icons.start),
              //           title: const Text(
              //             "모집 시작",
              //             style: TextStyle(
              //               fontSize: 14.0,
              //             ),
              //           ),
              //           subtitle: Text(
              //             widget.startTime,
              //             style: const TextStyle(
              //               fontSize: 14.0,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 187,
              //       height: 80,
              //       child: Card(
              //         child: ListTile(
              //           leading: const Icon(Icons.done),
              //           title: const Text(
              //             "모집 마감",
              //             style: TextStyle(
              //               fontSize: 14.0,
              //             ),
              //           ),
              //           subtitle: Text(
              //             widget.endTime,
              //             style: const TextStyle(
              //               fontSize: 14.0,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              _title(title: "상세"),
              Container(
                child: Text(
                  widget.contnet,
                ),
              ),
              _title(title: "활동 위치"),
              SizedBox(
                width: 450,
                height: 320,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  child: GoogleMap(
                    initialCameraPosition: initialPosition,
                    mapType: MapType.hybrid,
                    onMapCreated: (controller) {
                      setState(() {
                        _controller = controller;
                      });
                    },
                    markers: markers.toSet(),
                    onTap: (cordinate) {
                      _controller
                          .animateCamera(CameraUpdate.newLatLng(cordinate));
                      addMarker(cordinate);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Row(
      //   children: [
      //     Card(
      //       elevation: 1,
      //       child: ListTile(
      //         leading: Icon(Icons.location_city),
      //         title: Text("기관명"),
      //         subtitle: Text(widget.host),
      //       ),
      //     ),
      //   ],
      // ),
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
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
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
        title: const Text(
          "상세 정보",
        ),
        centerTitle: true,
        elevation: 0.5,
        actions: <Widget>[
          // IconButton(
          //     icon: const Icon(Icons.search),
          //     // 아이콘 클릭 시 bottom sheet 모달 창 생성 (검색 창)
          //     onPressed: () {}),
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
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            widget.title,
                            style: const TextStyle(
                              height: 3,
                            ),
                          ),
                          subtitle: Text(
                            widget.contnet,
                            style: const TextStyle(
                              height: 1.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 30.0),
                          child: Container(
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 20,
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
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // SliverPersistentHeader(
              //   delegate: VolSearchPersistentTabBar(),
              //   pinned: true,
              // ),
            ],

            // TabBarView(
            //   physics: const NeverScrollableScrollPhysics(),
            //   children: [
            //     Offstage(
            //       offstage: false,
            //       child: introScreen(),
            //     ),
            //     Offstage(
            //       offstage: false,
            //       child: hostMapScreen(),
            //     ),
            //   ],
            // ),
            body: introScreen(),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  width: 375.0,
                  height: 40.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: _showAlertDialog,
                    child: const Text("신청하기"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
