import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_pos/core/util/helper.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.imgPath,
    required this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final double? width;
  final double height;
  final String? imgPath;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final path = imgPath;

    if (path == null) {
      return Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius:
          borderRadius ?? BorderRadius.circular(appSpace.scale),
        ),
      );
    }

    if (path.isEmpty) {
      return Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius:
              borderRadius ?? BorderRadius.circular(appSpace.scale),
        ),
      );
    }

    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius:
            borderRadius ?? BorderRadius.circular(appSpace.scale),
        image: DecorationImage(
          repeat: ImageRepeat.noRepeat,
          fit: fit,
          image: FileImage(
            File(path),
          ),
        ),
      ),
    );
  }
}
