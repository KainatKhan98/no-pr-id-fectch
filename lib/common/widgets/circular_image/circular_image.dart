import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../shimmer/shimmer_effect.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.width = 50,
    this.height = 50,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = 10,
    this.isNetworkImage = false,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        //image: DecorationImage(image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,  fit: BoxFit.cover,),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage ? CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: image,
            progressIndicatorBuilder: (context, url, downloadProgress) => const ShimmerEffect(width: 55, height: 55),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
          : Image(image: AssetImage(image), fit: BoxFit.fill,)
        ),
      ),
    );
  }
}
