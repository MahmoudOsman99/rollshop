import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rollshop/core/helpers/images_path.dart';

class BuildImageWithErrorHandler extends StatelessWidget {
  BuildImageWithErrorHandler({
    super.key,
    required this.imageType,
    required this.path,
    this.boxFit = BoxFit.cover,
  });
  ImageType imageType;
  dynamic path;
  BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    if (path == null || path == "") return errorImage();
    switch (imageType) {
      case ImageType.asset:
        return Image.asset(
          path.toString(),
          fit: boxFit,
          errorBuilder: (context, error, stackTrace) {
            return errorImage();
          },
        );
      case ImageType.network:
        return Image.network(
          path.toString(),
          fit: boxFit,
          errorBuilder: (context, error, stackTrace) {
            return errorImage();
          },
        );
      case ImageType.file:
        return Image.file(
          File(path.path),
          fit: boxFit,
          errorBuilder: (context, error, stackTrace) {
            return errorImage();
          },
        );
    }
  }
}

Widget errorImage() {
  return Image.asset(
    ImagesPath.topDriveSideImagePath,
    fit: BoxFit.cover,
  );
}

enum ImageType {
  asset,
  network,
  file,
}
