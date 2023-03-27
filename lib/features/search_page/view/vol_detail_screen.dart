import 'package:flutter/material.dart';

class VolDetailScreen extends StatefulWidget {

  const VolDetailScreen({super.key});

  @override
  State<VolDetailScreen> createState() => _VolDetailScreenState();

}

class _VolDetailScreenState extends State<VolDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController; // tabbar와 tabview를 제어하는데 필요

// initState에서 tabController를 초기설정
  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  // void Future<List> async {
    
  // }

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
                  Navigator.of(context).pop();
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
              onPressed: () {
                
              }),
          IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                print("알림함");
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 250.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        " [ 전시 안내 및 데스크 보조 모집 ]",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    //const SizedBox(height: 10),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   child: Text(
                    //     "전시 안내 및 안내 데스크 보조 자원봉사자 구합니다!",
                    //     style: TextStyle(
                    //       color: Colors.grey,
                    //       fontSize: 12.0,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: const [
                          Text(" 모집기관: 진주 박물관 "),
                          Text(" 봉사기간: 2023.7.6 ~ 2023.8.30 "),
                          Text(" 봉사시간: 13:00 ~ 16:00 "),
                          Text(" 모집인원: 1명 "),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 00),
                    Column(
                      children: [
                        Container(
                          child: TabBar(
                            tabs: [
                              Container(
                                height: 60.0,
                                alignment: Alignment.center,
                                child: const Text(
                                  "봉사 정보",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Container(
                                height: 60.0,
                                alignment: Alignment.center,
                                child: const Text(
                                  "기관 정보",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Container(
                                height: 60.0,
                                alignment: Alignment.center,
                                child: const Text(
                                  "기관 위치",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                            labelColor: Colors.white, // 선택된 tab의 label 색상
                            unselectedLabelColor:
                                Colors.black, // 선택되지 않은 tab의 label 생상
                            controller: _tabController,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          Container(
                            color: Colors.lightBlue[200],
                            // height: 300,
                            alignment: Alignment.center,
                            child: const Text(
                              '봉사 상세 정보',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.lightGreen,
                            alignment: Alignment.center,
                            child: const Text(
                              '기관 정보',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Container(
                            color: Color.fromARGB(255, 239, 132, 167),
                            alignment: Alignment.center,
                            child: const Text(
                              '지도 삽입',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border_outlined),
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
                  child: Text("신청하기"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
