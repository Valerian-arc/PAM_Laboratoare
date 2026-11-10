import 'package:flutter/material.dart';

/// Thin rounded chevron ("<" or ">") matching the design's stroke.
class ChevronPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final bool pointsLeft;

  const ChevronPainter({
    required this.color,
    required this.strokeWidth,
    required this.pointsLeft,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final h = strokeWidth / 2;
    final x0 = pointsLeft ? size.width - h : h;
    final x1 = pointsLeft ? h : size.width - h;
    final path = Path()
      ..moveTo(x0, h)
      ..lineTo(x1, size.height / 2)
      ..lineTo(x0, size.height - h);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant ChevronPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.pointsLeft != pointsLeft;
}

/// Play triangle with rounded corners.
class PlayPainter extends CustomPainter {
  final Color color;

  const PlayPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width * 0.18;
    final path = Path()
      ..moveTo(r, r)
      ..lineTo(size.width - r, size.height / 2)
      ..lineTo(r, size.height - r)
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 2
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant PlayPainter old) => old.color != color;
}
