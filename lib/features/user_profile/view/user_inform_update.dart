import 'package:flutter/material.dart';

// 마이페이지 정보수정 페이지
class UserInformUpdate extends StatelessWidget {
  const UserInformUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원 정보 수정"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: GestureDetector(
                  child: const CircleAvatar(
                    radius: 38.0,
                    foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/77985708?v=4",
                    ),
                    child: Text("재현"),
                  ),
                ),
              ),
            ),
      
            // 회원 정보 관련 요소들 column으로 정렬
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Column(
                // sns 로그인을 통해 정보를 자동으로 가져온다.
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        //   style: TextStyle(
                        //   fontSize: 14.0,
                        // ),
                        labelText: '이메일',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: '이름을 입력하세요.',
                        labelText: '이름',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: '성별',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: '전화번호 (휴대폰 번호)',
                        hintText: '전화번호를 입력하세요.',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: '생년월일을 입력하세요.',
                        labelText: '생년월일',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
