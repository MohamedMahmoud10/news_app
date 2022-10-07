import 'package:flutter/material.dart';

class CustomTag extends StatelessWidget {
  final Color backGrounColor;
  final List<Widget> children;

  const CustomTag(
      {Key? key, required this.backGrounColor, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backGrounColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
