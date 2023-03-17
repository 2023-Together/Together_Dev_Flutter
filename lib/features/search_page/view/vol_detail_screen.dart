import 'package:flutter/material.dart';

class VolDetailScreen extends StatelessWidget {
  const VolDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("상세 정보"),
        centerTitle: true,
        elevation: 0.5,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                print("알림함");
              }),
        ],
      ),
      body: Container(
        height: 200.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Column(
          children: const [
            
          ],
        ),
      ),
    );
  }
}
