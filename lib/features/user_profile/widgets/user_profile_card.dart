import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_update.dart';
import 'package:swag_cross_app/models/DBModels/user_model.dart';

class UserProfileCard extends StatelessWidget {
  final UserModel? userData;

  const UserProfileCard({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(
          UserInformUpdate.routeName,
        );
      },
      leading: CircleAvatar(
        radius: 40,
        child: Text(userData!.userName),
        // backgroundImage: NetworkImage(
        //   "https://avatars.githubusercontent.com/u/77985708?v=4",
        // ),
      ),
      title: Text(
        userData!.userName,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Sizes.size18,
        ),
      ),
      subtitle: const Text(
        "SWAG 동아리",
        style: TextStyle(
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
