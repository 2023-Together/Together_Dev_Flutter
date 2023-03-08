import 'package:flutter/material.dart';

class UserCalendarScreen extends StatelessWidget {
  const UserCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내일정"),
      ),
    );
  }
}
