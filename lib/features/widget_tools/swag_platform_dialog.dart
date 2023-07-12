import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void swagPlatformDialog({
  required BuildContext context,
  required String title,
  required String message,
  required List<Widget> actions,
}) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: actions,
      ),
    );
  } else if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: actions,
      ),
    );
  }
}
