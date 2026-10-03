import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class PreviewCardImage extends StatelessWidget {
  final String url;
  final AssetImage errorImage;
  const PreviewCardImage({
    Key? key,
    required this.url,
    required this.errorImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: CachedNetworkImageProvider(url),
      errorBuilder: OctoError.icon(),
      fit: BoxFit.cover,
    );
  }
}
