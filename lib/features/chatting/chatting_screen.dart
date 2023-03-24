import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({super.key});

  void _alertIconTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AlertScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("단톡방"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
              horizontal: Sizes.size10,
            ),
            child: GestureDetector(
              onTap: () => _alertIconTap(context),
              child: const FaIcon(
                FontAwesomeIcons.bell,
                size: 34,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
