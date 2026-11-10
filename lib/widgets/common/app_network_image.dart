import 'package:flutter/material.dart';

/// Network image (URL from the JSON) with a loading placeholder and a
/// local fallback, so the UI still looks right offline.
class AppNetworkImage extends StatelessWidget {
  final String url;
  final String? fallbackAsset;
  final Widget? fallback;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final Color placeholderColor;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.fallbackAsset,
    this.fallback,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.placeholderColor = const Color(0x14000000),
  });

  Widget _fallback() {
    if (fallback != null) return fallback!;
    if (fallbackAsset != null) {
      return Image.asset(
        fallbackAsset!,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      );
    }
    return Container(width: width, height: height, color: placeholderColor);
  }

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return _fallback();
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      frameBuilder: (context, child, frame, wasSyncLoaded) {
        if (wasSyncLoaded) return child;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: frame == null
              ? Container(
                  key: const ValueKey('placeholder'),
                  width: width,
                  height: height,
                  color: placeholderColor,
                )
              : child,
        );
      },
      errorBuilder: (context, error, stack) => _fallback(),
    );
  }
}
