import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_update.dart';
import 'package:swag_cross_app/models/DBModels/user_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/providers/user_provider.dart';

class UserProfileCard extends StatefulWidget {
  final UserModel? userData;

  const UserProfileCard({
    super.key,
    required this.userData,
  });

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  late UserModel? userData;

  final TextEditingController _DefController = TextEditingController();

  void _onUpdateDef(int userId, String userDef) async {
    final url = Uri.parse("${HttpIp.userUrl}/together/updateUserDef");

    final data = {
      "userId": userId,
      "userDef": userDef,
    };
    // final headers = {'Content-Type': 'application/json'};
    // final body = jsonEncode(data);

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // final UserModel updateData = UserModel(
      //   userId: userId,
      //   userDef: userDef,
      // );
      // if (!mounted) return;
      // context.read<UserProvider>().updateUserData(updateData);
      // context.pop();
      final result = int.parse(response.body);
      if (result == 0) {
        setState(() {
          context.read<UserProvider>().userData?.userDef = userDef;
        });
        print("통신 성공");
      } else {
        print("통신 실패!");
        print(response.statusCode);
        print(response.body);
      }
    } else {
      print("수정 에러!");
      print(response.statusCode);
      print(response.body);
    }
  }

  // void _showEditDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext dialogContext) {
  //       String editedUserDef = widget.userData?.userDef ?? '';

  //       return AlertDialog(
  //         title: Text("상태 메시지"),
  //         content: TextField(
  //           onChanged: (newValue) {
  //             editedUserDef = newValue;
  //           },
  //           controller: TextEditingController(text: editedUserDef),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(dialogContext);
  //             },
  //             child: Text("취소"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               _onUpdateDef(userData!.userId, _DefController.text);
  //             },
  //             child: Text("저장"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();

    userData = context.read<UserProvider>().userData;

    _DefController.text = userData!.userDef ?? '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(
          UserInformUpdate.routeName,
        );
      },
      leading: const CircleAvatar(
        radius: 40,
        child: FaIcon(
          FontAwesomeIcons.solidCircleUser,
          size: 45,
        ),
        // backgroundImage: NetworkImage(
        //   "https://avatars.githubusercontent.com/u/77985708?v=4",
        // ),
      ),
      title: Text(
        userData!.userNickname,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Sizes.size18,
        ),
      ),
      subtitle:
          // GestureDetector(
          //   onTap: () {
          //     // _showEditDialog(context);
          //   },
          //   child: Text(
          //     widget.userData!.userDef ?? '',
          //     style: TextStyle(
          //       fontSize: Sizes.size14,
          //     ),
          //   ),
          // ),
          Text(
        userData!.userEmail,
        style: const TextStyle(
          fontSize: Sizes.size14,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        size: Sizes.size40,
      ),
    );
  }
}