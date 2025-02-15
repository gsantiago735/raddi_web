import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GenericNetworkImage extends StatelessWidget {
  final String? path;
  final BoxFit fit;
  final IconData? defaultIcon;
  final double sizeDefaultIcon;
  final Color? iconDefaultColor;

  final double? size;
  final double? height;
  final double? width;
  final double border;

  final double opacity;

  final double? heightLoading;

  final bool needsFullScreen;

  const GenericNetworkImage({
    this.fit = BoxFit.cover,
    super.key,
    this.path,
    this.size,
    this.width,
    this.height,
    this.border = 20,
    this.opacity = 1.0,
    this.defaultIcon,
    this.heightLoading,
    this.sizeDefaultIcon = 50,
    this.iconDefaultColor,
    this.needsFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    if (path?.isNotEmpty ?? false) {
      return CachedNetworkImage(
        imageUrl: path!,
        width: width ?? size,
        height: height ?? size,
        fit: fit,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(border)),
            image: DecorationImage(
              image: imageProvider,
              opacity: opacity,
              fit: fit,
            ),
          ),
        ),
        progressIndicatorBuilder: (_, url, progress) => SizedBox(
            height: heightLoading,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
                strokeWidth: 2,
              ),
            )),
        errorWidget: (context, url, error) => _errorWidget(),
      );
    }
    return _errorWidget();
  }

  Widget _errorWidget() {
    if (defaultIcon != null) {
      return Icon(
        defaultIcon ?? Icons.add_photo_alternate_rounded,
        size: size ?? sizeDefaultIcon,
        color: iconDefaultColor ?? const Color(0xFF257CFF),
      );
    }
    return Icon(
      Icons.error_rounded,
      color: iconDefaultColor ?? const Color(0xFF257CFF),
      size: size ?? sizeDefaultIcon,
    );
  }
}
