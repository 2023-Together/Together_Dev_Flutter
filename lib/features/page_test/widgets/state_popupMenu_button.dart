import 'package:flutter/material.dart';

class StatePopupMenuButton extends StatelessWidget {
  const StatePopupMenuButton({
    super.key,
    required this.initOption,
    required this.onChangeOption,
  });

  final String initOption;
  final Function(String) onChangeOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(initOption),
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: '옵션1',
                child: Text('옵션1'),
              ),
              const PopupMenuItem<String>(
                value: '옵션2',
                child: Text('옵션2'),
              ),
              const PopupMenuItem<String>(
                value: '옵션3',
                child: Text('옵션3'),
              ),
            ],
            onSelected: onChangeOption,
            initialValue: '옵션1',
            icon: const Icon(Icons.arrow_downward_rounded),
          ),
        ],
      ),
    );
  }
}
