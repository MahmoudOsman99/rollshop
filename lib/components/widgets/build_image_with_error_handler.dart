import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/core/theme/colors.dart';

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
        return CachedNetworkImage(
          fit: boxFit,
          imageUrl: path,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) {
            return errorImage();
          },
          // fit: BoxFit.cover,
        );
      // return Image.network(
      //   path.toString(),
      //   fit: boxFit,
      //   errorBuilder: (context, error, stackTrace) {
      //     return errorImage();
      //   },
      // );
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
  return Center(
    child: Image.asset(
      ImagesPath.errorImagePath,
      fit: BoxFit.cover,
    ),
  );
}
// Widget errorImage() {
//   return Image.network(
//     "https://i.imgur.com/lYTA2Kq.jpg",
//     fit: BoxFit.cover,
//   );
// }
// Widget errorImage() {
//   return Image.asset(
//     ImagesPath.topDriveSideImagePath,
//     fit: BoxFit.cover,
//   );
// }

enum ImageType {
  asset,
  network,
  file,
}
