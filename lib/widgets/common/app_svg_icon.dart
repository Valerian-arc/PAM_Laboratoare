import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

/// Downloads SVG icons once and keeps them in memory. Failures are caught
/// and cached as `null`, so an offline device just shows the fallback icon.
class SvgCache {
  SvgCache._();

  static final Map<String, Future<String?>> _cache = {};

  /// Set to `false` in tests to skip network calls entirely.
  static bool networkEnabled = true;

  static Future<String?> load(String url) {
    if (!networkEnabled) return Future.value(null);
    return _cache.putIfAbsent(url, () async {
      try {
        final res = await http
            .get(Uri.parse(url))
            .timeout(const Duration(seconds: 10));
        if (res.statusCode == 200 && res.body.contains('<svg')) return res.body;
      } catch (_) {
        // offline / timeout -> fallback icon
      }
      _cache.remove(url); // allow a retry next time
      return null;
    });
  }
}

/// Icon loaded from an SVG URL in the JSON (iconify.design), with a Material
/// icon shown while loading or when the download fails.
class AppSvgIcon extends StatelessWidget {
  final String url;
  final IconData fallbackIcon;
  final Color fallbackColor;
  final double size;

  const AppSvgIcon({
    super.key,
    required this.url,
    required this.fallbackIcon,
    required this.fallbackColor,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = Icon(fallbackIcon, size: size, color: fallbackColor);
    if (url.isEmpty) return fallback;
    return FutureBuilder<String?>(
      future: SvgCache.load(url),
      builder: (context, snapshot) {
        final svg = snapshot.data;
        if (svg == null) return fallback;
        return SvgPicture.string(svg, width: size, height: size);
      },
    );
  }
}
