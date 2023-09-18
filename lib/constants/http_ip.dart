import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';

class HttpIp {
  static const communityUrl = "http://61.39.251.228:80";
  static const userUrl = "http://61.39.251.208:80";

  static void errorPrint({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    swagPlatformDialog(
      context: context,
      title: title,
      message: message,
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("알겠습니다"),
        ),
      ],
    );
  }
}
