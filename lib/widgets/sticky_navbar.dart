import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class StickyNavbar extends StatelessWidget {
  final List<String> navItems;
  final Function(int) onNavItemTap;
  final int activeIndex;

  const StickyNavbar({
    super.key,
    required this.navItems,
    required this.onNavItemTap,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 50 : 20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor.withOpacity(0.85),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Text(
            "H",
            style: GoogleFonts.firaCode(
              color: AppTheme.primaryColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ).widgetContainer(
            padding: 8,
            border: Border.all(color: AppTheme.primaryColor, width: 2),
          ),

          if (isDesktop)
            Row(
              children: [
                ...navItems.asMap().entries.map((entry) {
                  return _NavItem(
                    number: "0${entry.key + 1}.",
                    label: entry.value,
                    isActive: activeIndex == entry.key,
                    onTap: () => onNavItemTap(entry.key),
                  );
                }).toList(),
                const SizedBox(width: 20),
                _ResumeButton(),
              ],
            )
          else
            IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(
                Icons.menu,
                color: AppTheme.primaryColor,
                size: 30,
              ),
            ),
        ],
      ),
    );
  }
}

extension on Widget {
  Widget widgetContainer({required double padding, Border? border}) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: border,
        borderRadius: BorderRadius.circular(4),
      ),
      child: this,
    );
  }
}

class _NavItem extends StatefulWidget {
  final String number;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.number,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: widget.onTap,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    widget.number,
                    style: GoogleFonts.firaCode(
                      color: AppTheme.primaryColor,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.label,
                    style: GoogleFonts.firaCode(
                      color: _isHovered || widget.isActive
                          ? AppTheme.primaryColor
                          : AppTheme.textColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered || widget.isActive ? 40 : 0,
                color: AppTheme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // Correct path for Flutter Web assets
        launchUrl(Uri.parse("assets/assets/Hetvi_Shah_Flutter(4+ Years).pdf"));
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.primaryColor,
        side: const BorderSide(color: AppTheme.primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text("Resume", style: GoogleFonts.firaCode(fontSize: 13)),
    );
  }
}
