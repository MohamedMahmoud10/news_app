import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final ImageProvider imageProvide;
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? child;

  const ImageContainer(
      {Key? key,
      required this.imageProvide,
      required this.width,
      this.height = 120,
      this.borderRadius = 20,
      this.padding,
      this.margin,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: imageProvide, fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
