import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme/app_theme.dart';
import 'widgets/animated_gradient_background.dart';
import 'widgets/sticky_navbar.dart';
import 'sections/hero_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hetvi Shah | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(4, (_) => GlobalKey());

  // Use ValueNotifier to avoid rebuilding the entire page on scroll
  final ValueNotifier<int> _activeSectionIndex = ValueNotifier<int>(-1);

  final List<String> _navItems = ["Experience", "Work", "Skills", "Contact"];
  bool _isScrollingManually = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isScrollingManually) return;

    int newIndex = -1;
    for (int i = 0; i < _sectionKeys.length; i++) {
      final keyContext = _sectionKeys[i].currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;
        if (position < 250) {
          newIndex = i;
        }
      }
    }

    if (newIndex != _activeSectionIndex.value) {
      _activeSectionIndex.value = newIndex;
    }
  }

  void _scrollToSection(int index) async {
    final key = _sectionKeys[index];
    if (key.currentContext != null) {
      _activeSectionIndex.value = index;
      _isScrollingManually = true;

      await Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutQuart,
      );

      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _isScrollingManually = false;
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _activeSectionIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedGradientBackground(
        child: Stack(
          children: [
            // Major performance: Use RepaintBoundary to avoid unnecessary repaints
            RepaintBoundary(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    HeroSection(onWorkTap: () => _scrollToSection(1)),
                    ExperienceSection(key: _sectionKeys[0]),
                    ProjectsSection(key: _sectionKeys[1]),
                    SkillsSection(key: _sectionKeys[2]),
                    ContactSection(key: _sectionKeys[3]),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ValueListenableBuilder<int>(
                valueListenable: _activeSectionIndex,
                builder: (context, activeIndex, _) {
                  return StickyNavbar(
                    navItems: _navItems,
                    activeIndex: activeIndex,
                    onNavItemTap: _scrollToSection,
                  );
                },
              ),
            ),
            // Social Links (Fixed Left)
            if (MediaQuery.of(context).size.width > 900)
              const Positioned(left: 40, bottom: 0, child: SocialVerticalBar()),
            // Email (Fixed Right)
            if (MediaQuery.of(context).size.width > 900)
              const Positioned(right: 40, bottom: 0, child: EmailVerticalBar()),
          ],
        ),
      ),
    );
  }
}

class SocialVerticalBar extends StatelessWidget {
  const SocialVerticalBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SocialIcon(
          icon: FontAwesomeIcons.github,
          url: "https://github.com/hetvi-shah",
        ),
        _SocialIcon(
          icon: FontAwesomeIcons.linkedinIn,
          url: "https://linkedin.com/in/hetvi-shah-3bb52b22b",
        ),
        _SocialIcon(
          icon: FontAwesomeIcons.facebook,
          url: "https://facebook.com",
        ),
        _SocialIcon(
          icon: FontAwesomeIcons.instagram,
          url: "https://instagram.com",
        ),
        const SizedBox(height: 20),
        Container(height: 100, width: 1, color: AppTheme.textSecondaryColor),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  const _SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: IconButton(
        onPressed: () => launchUrl(Uri.parse(url)),
        icon: FaIcon(icon, color: AppTheme.textSecondaryColor, size: 20),
        hoverColor: Colors.transparent,
      ),
    );
  }
}

class EmailVerticalBar extends StatelessWidget {
  const EmailVerticalBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RotatedBox(
          quarterTurns: 1,
          child: InkWell(
            onTap: () => launchUrl(Uri.parse("mailto:shahhetvi276@gmail.com")),
            child: Text(
              "shahhetvi276@gmail.com",
              style: GoogleFonts.firaCode(
                color: AppTheme.textSecondaryColor,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(height: 100, width: 1, color: AppTheme.textSecondaryColor),
      ],
    );
  }
}
