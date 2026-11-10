import 'package:flutter/material.dart';

/// "Course - Overview - 1" page (Figma, 375 x 812 frame).
/// All sizes/offsets below are measured from the design in points.
class CourseOverviewScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const CourseOverviewScreen({super.key, this.onBack});

  @override
  State<CourseOverviewScreen> createState() => _CourseOverviewScreenState();
}

class _Lesson {
  final String title;
  final String duration;
  const _Lesson(this.title, this.duration);
}

class _CourseOverviewScreenState extends State<CourseOverviewScreen> {
  static const _bg = Color(0xFFFAFBFF);
  static const _orange = Color(0xFFFF7300);
  static const _dark = Color(0xFF0B0B0D);
  static const _metaGrey = Color(0xFF76777B);
  static const _durationGrey = Color(0xFF9C9D9F);
  static const _tabGrey = Color(0xFFC5C6C8);

  // Content area: 35pt left margin, 21pt right margin (as in the frame).
  static const _padL = 35.0;
  static const _padR = 21.0;

  int _tab = 0;

  static const _lessons = [
    _Lesson('Introduction to React', '04:28 min'),
    _Lesson('Understanding React', '06:12 min'),
    _Lesson('Create first React project', '43:58 min'),
    _Lesson('Build React', '26:18 min'),
    _Lesson('React Components', '18:40 min'),
    _Lesson('Props and State', '22:05 min'),
    _Lesson('Deploy React App', '12:30 min'),
  ];

  TextStyle _t(double size, Color color, [FontWeight w = FontWeight.w400]) =>
      TextStyle(
        fontFamily: 'Roboto',
        fontSize: size,
        color: color,
        fontWeight: w,
        letterSpacing: 0,
        height: 1.17,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _header(),
            Expanded(
              child: Stack(children: [_scrollContent(), _bottomBar(context)]),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- header --
  Widget _header() {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onBack ?? () => Navigator.maybePop(context),
            child: const SizedBox(
              width: 53,
              height: 46,
              child: Padding(
                padding: EdgeInsets.only(left: 24.4, top: 13.2, bottom: 13.8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomPaint(
                    size: Size(10.5, 19),
                    painter: _ChevronPainter(
                      color: Colors.black,
                      strokeWidth: 2.6,
                      pointsLeft: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text('Course Overview', style: _t(18.5, _dark, FontWeight.w500)),
        ],
      ),
    );
  }

  // --------------------------------------------------------------- content --
  Widget _scrollContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: _padL, right: _padR, bottom: 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 37.6),
          _banner(),
          const SizedBox(height: 32),
          Text('React Front To back', style: _t(19, _dark, FontWeight.w500)),
          const SizedBox(height: 9),
          _metaRow(),
          const SizedBox(height: 21),
          _tabs(),
          const SizedBox(height: 25.8),
          if (_tab == 0)
            ..._lessons.map(_lessonRow)
          else
            Text(
              'Learn React from the ground up: components, props, state, '
              'hooks and how to build and deploy a complete front-end '
              'application.',
              style: _t(14, _metaGrey).copyWith(height: 1.5),
            ),
        ],
      ),
    );
  }

  Widget _banner() {
    return AspectRatio(
      aspectRatio: 319.2 / 197.9,
      child: LayoutBuilder(
        builder: (context, c) {
          final k = c.maxWidth / 319.2; // scale relative to the design
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8C9BC8).withAlpha(28),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/course_overview_banner.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                  // Play button
                  Positioned(
                    left: (158.6 - 25.5) * k,
                    top: (98.6 - 25.5) * k,
                    width: 51 * k,
                    height: 51 * k,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.only(left: 3 * k),
                      alignment: Alignment.center,
                      child: CustomPaint(
                        size: Size(17.4 * k, 22.3 * k),
                        painter: const _PlayPainter(color: _orange),
                      ),
                    ),
                  ),
                  // Info badges
                  Positioned(
                    left: 67.5 * k,
                    top: 165 * k,
                    width: 92 * k,
                    height: 26.5 * k,
                    child: _badge(
                      k,
                      Icons.account_balance_rounded,
                      const Color(0xFF3FA2E6),
                      '75 Videos',
                    ),
                  ),
                  Positioned(
                    left: 164.5 * k,
                    top: 165 * k,
                    width: 86 * k,
                    height: 26.5 * k,
                    child: _badge(
                      k,
                      Icons.co_present_rounded,
                      const Color(0xFF3FA2E6),
                      '35 Class',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _badge(double k, IconData icon, Color iconColor, String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3 * k),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11 * k, color: iconColor),
          SizedBox(width: 4 * k),
          Text(
            text,
            style: _t(11 * k, const Color(0xFF2B2B2B), FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _metaRow() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              const Icon(Icons.schedule_rounded, size: 13.5, color: _metaGrey),
              const SizedBox(width: 6),
              Text('6h 30min', style: _t(13, _metaGrey)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text('·', style: _t(13, _metaGrey, FontWeight.w700)),
              ),
              Text('7 lessons', style: _t(13, _metaGrey)),
            ],
          ),
        ),
        const Spacer(),
        Container(
          width: 50.2,
          height: 23,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3F9),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                size: 17,
                color: Color(0xFFFFC62D),
              ),
              const SizedBox(width: 2),
              Text('4.9', style: _t(13, _orange, FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabs() {
    Widget tab(int i, String label) {
      final selected = _tab == i;
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _tab = i),
        child: SizedBox(
          width: 96.2,
          child: Column(
            children: [
              Text(
                label,
                style: _t(17, selected ? _orange : _tabGrey, FontWeight.w500),
              ),
              const SizedBox(height: 3.6),
              Container(
                height: 1.5,
                color: selected ? _orange : Colors.transparent,
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        tab(0, 'Lessons'),
        const SizedBox(width: 14.6),
        tab(1, 'Description'),
      ],
    );
  }

  Widget _lessonRow(_Lesson lesson) {
    final first = identical(lesson, _lessons.first);
    return SizedBox(
      height: 66.2,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 39,
          child: OverflowBox(
            maxHeight: 60,
            child: Row(
              children: [
                Container(
                  width: 39,
                  height: 39,
                  decoration: BoxDecoration(
                    color: first ? _orange : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: first
                        ? null
                        : [
                            BoxShadow(
                              color: const Color(0xFF6E7AA0).withAlpha(28),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                  ),
                  padding: const EdgeInsets.only(left: 2),
                  alignment: Alignment.center,
                  child: CustomPaint(
                    size: const Size(11, 14),
                    painter: _PlayPainter(
                      color: first ? Colors.white : _orange,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(lesson.title, style: _t(15, _dark, FontWeight.w500)),
                      const SizedBox(height: 3),
                      Text(lesson.duration, style: _t(15, _durationGrey)),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 9),
                  child: CustomPaint(
                    size: Size(7.6, 14.6),
                    painter: _ChevronPainter(
                      color: _orange,
                      strokeWidth: 2,
                      pointsLeft: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------ bottom bar --
  Widget _bottomBar(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: IgnorePointer(
        ignoring: false,
        child: Container(
          padding: EdgeInsets.only(
            left: _padL,
            right: _padR,
            top: 75,
            bottom: 13.4 + bottomInset,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_bg.withAlpha(0), _bg.withAlpha(235), _bg],
              stops: const [0.0, 0.3, 0.5],
            ),
          ),
          child: SizedBox(
            height: 44.6,
            child: Row(
              children: [
                Container(
                  width: 65.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFF0F0F2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(8),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text('Free', style: _t(15, _orange, FontWeight.w500)),
                ),
                const SizedBox(width: 14.6),
                Expanded(
                  child: Material(
                    color: _orange,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {},
                      child: Center(
                        child: Text(
                          'Enroll Now',
                          style: _t(15, Colors.white, FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Thin rounded chevron ("<" or ">").
class _ChevronPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final bool pointsLeft;

  const _ChevronPainter({
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
    final path = Path();
    if (pointsLeft) {
      path
        ..moveTo(size.width - h, h)
        ..lineTo(h, size.height / 2)
        ..lineTo(size.width - h, size.height - h);
    } else {
      path
        ..moveTo(h, h)
        ..lineTo(size.width - h, size.height / 2)
        ..lineTo(h, size.height - h);
    }
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant _ChevronPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}

/// Play triangle with rounded corners.
class _PlayPainter extends CustomPainter {
  final Color color;
  const _PlayPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width * 0.18;
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 2
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(r, r)
      ..lineTo(size.width - r, size.height / 2)
      ..lineTo(r, size.height - r)
      ..close();
    canvas.drawPath(path, stroke);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant _PlayPainter old) => old.color != color;
}
