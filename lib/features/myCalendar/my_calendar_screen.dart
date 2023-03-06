import 'package:flutter/material.dart';

class MyCalendarScreen extends StatelessWidget {
  const MyCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내일정"),
      ),
    );
  }
}
