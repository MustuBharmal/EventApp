import 'package:flutter/material.dart';

import '../main.dart';

class TopContainer extends StatelessWidget {
  final double? height;
  final double width;
  final Widget child;
  final EdgeInsets? padding;
  TopContainer(
      {super.key, this.height, required this.width, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding != null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
      decoration:  BoxDecoration(
          color: buildMaterialColor(const Color(0xFF9EB384)),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
// Color(0xFFF9BE7C),