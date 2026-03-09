import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../widgets/entrance_fader.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String number;
  final String title;

  const SectionHeader({super.key, required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$number.",
          style: GoogleFonts.firaCode(
            color: AppTheme.primaryColor,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(width: 20),
        const Expanded(child: Divider(color: Color(0xFF233554), thickness: 1)),
      ],
    );
  }
}

class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Offset offset;
  final Duration delay;
  final String? sectionId;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.offset = const Offset(0, 0.05),
    this.delay = Duration.zero,
    this.sectionId,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _isVisible = false;
  late final Key _visibilityKey;

  @override
  void initState() {
    super.initState();
    _visibilityKey = Key(
      widget.sectionId ?? 'reveal_${identityHashCode(this)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          if (mounted) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      },
      child: _isVisible
          ? EntranceFader(
              offset: widget.offset,
              delay: widget.delay,
              child: widget.child,
            )
          : Opacity(opacity: 0, child: widget.child),
    );
  }
}
