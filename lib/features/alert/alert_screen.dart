import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final List<Map<String, dynamic>> alertData = [
    {
      "id": 1,
      "title": "알림1",
      "content": "내용1",
    },
    {
      "id": 2,
      "title": "알림2",
      "content": "내용2",
    },
    {
      "id": 3,
      "title": "알림3",
      "content": "내용3",
    },
    {
      "id": 4,
      "title": "알림4",
      "content": "내용4",
    },
    {
      "id": 5,
      "title": "알림5",
      "content": "내용5",
    },
    {
      "id": 6,
      "title": "알림6",
      "content": "내용6",
    },
    {
      "id": 7,
      "title": "알림7",
      "content": "내용7",
    },
    {
      "id": 8,
      "title": "알림8",
      "content": "내용8",
    },
    {
      "id": 9,
      "title": "알림9",
      "content": "내용9",
    },
    {
      "id": 10,
      "title": "알림10",
      "content": "내용10",
    },
  ];

  void _onDismissed(Map<String, dynamic> alertItem) {
    alertData.remove(alertItem);
    setState(() {});
  }

  void _onTrashTap() {
    alertData.clear();
    setState(() {});
  }

  Future _alertRefresh() async {
    print(alertData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("알림창"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
              horizontal: Sizes.size10,
            ),
            child: GestureDetector(
              onTap: _onTrashTap,
              child: const FaIcon(
                FontAwesomeIcons.trashCan,
                size: Sizes.size32,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _alertRefresh,
        child: Container(
          padding: const EdgeInsets.symmetric(
            // vertical: Sizes.size18,
            horizontal: Sizes.size10,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "없애 려면 왼쪽이나 오른쪽으로 스크롤 해주세요",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
              Gaps.v18,
              const Divider(thickness: 1, height: 1, color: Colors.black),
              Gaps.v10,
              Expanded(
                child: ListView.separated(
                  itemCount: alertData.length,
                  // Dismissible : child로 설정된 위젯을 좌우로 스크롤 할수 있음
                  // 스크롤로 없애도 위젯을 여전히 남아있기 때문에 없애주는 작업이 따로 필요함
                  itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) => _onDismissed(alertData[index]),
                    // 오른쪽으로 스크롤
                    background: Container(
                      // container 안에 있는 아이템들의 정렬 방식을 정함
                      alignment: Alignment.centerLeft,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.only(left: Sizes.size10),
                        child: FaIcon(
                          FontAwesomeIcons.trashCan,
                          color: Colors.white,
                          size: Sizes.size32,
                        ),
                      ),
                    ),
                    // 왼쪽으로 스크롤
                    secondaryBackground: Container(
                      // container 안에 있는 아이템들의 정렬 방식을 정함
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.only(right: Sizes.size10),
                        child: FaIcon(
                          FontAwesomeIcons.trashCan,
                          color: Colors.white,
                          size: Sizes.size32,
                        ),
                      ),
                    ),
                    child: ListTile(
                      minVerticalPadding: Sizes.size16,
                      leading: Container(
                        width: Sizes.size52,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: Sizes.size1,
                            )),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.bell,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${alertData[index]["title"]}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: Sizes.size16,
                            ),
                          ),
                          Text(
                            "${alertData[index]["content"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500,
                              fontSize: Sizes.size14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        size: Sizes.size16,
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => Gaps.v10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
