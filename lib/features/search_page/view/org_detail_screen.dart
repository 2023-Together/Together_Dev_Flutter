import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';

class OrgDetailScreenArgs {
  final String id;
  // 기관 이름
  final String host;
  // 기관 위치
  final String locationStr;

  final String volCount;
  final String location;
  final String pNum;
  final String bossName;

  OrgDetailScreenArgs({
    required this.id,
    required this.host,
    required this.locationStr,
    required this.volCount,
    required this.location,
    required this.pNum,
    required this.bossName,
  });
}

class OrgDetailScreen extends StatefulWidget {
  static const routeName = "org_detail";
  static const routeURL = "/org_detail";

  final String id;
  final String host;
  final String locationStr;
  final String volCount;
  final String location;
  final String pNum;
  final String bossName;

  const OrgDetailScreen({
    super.key,
    required this.id,
    required this.host,
    required this.locationStr,
    required this.volCount,
    required this.location,
    required this.pNum,
    required this.bossName,
  });

  @override
  State<OrgDetailScreen> createState() => _OrgDetailScreenState();
}

class _OrgDetailScreenState extends State<OrgDetailScreen> {
  late GoogleMapController _controller;

  static final LatLng schoolLatlng = LatLng(
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

  static final CameraPosition initialPosition = CameraPosition(
    target: schoolLatlng, // 카메라 위치
    zoom: 15, // 확대 정도
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("기관 정보"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
            Container(
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
                      DataCell(Text('주소')),
                      DataCell(Text(widget.location)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('전화번호')),
                      DataCell(Text(widget.pNum)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('모집 중인 봉사')),
                      DataCell(Text(widget.volCount + "건")),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('사업자명')),
                      DataCell(Text(widget.bossName)),
                    ]),
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
