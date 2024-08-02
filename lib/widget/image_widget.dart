import 'dart:io';

import 'package:flutter/material.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/images.dart';
import 'package:store_pos/core/util/helper.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.imgPath = '',
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final String imgPath;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _validateImage(imgPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: width ?? double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: const AssetImage(no_photo),
                repeat: ImageRepeat.noRepeat,
                fit: fit,
              ),
              borderRadius:
              borderRadius ?? BorderRadius.circular(appSpace.scale),
            ),
          );
        }
        if (snapshot.data == null) {
          return Container(
            width: width ?? double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: const AssetImage(no_photo),
                repeat: ImageRepeat.noRepeat,
                fit: fit,
              ),
              borderRadius:
                  borderRadius ?? BorderRadius.circular(appSpace.scale),
            ),
          );
        }
        return Container(
          width: width ?? double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(appSpace.scale),
            image: DecorationImage(
              repeat: ImageRepeat.noRepeat,
              fit: fit,
              image: FileImage(
                snapshot.data!,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<File?> _validateImage(String path) async {
    final file = File(path);
    if (await file.exists()) {
      return file;
    }
    return null;
  }
}
