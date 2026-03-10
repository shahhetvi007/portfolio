import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class MobileDrawer extends StatelessWidget {
  final List<String> navItems;
  final Function(int) onNavItemTap;
  final int activeIndex;

  const MobileDrawer({
    super.key,
    required this.navItems,
    required this.onNavItemTap,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            ...navItems.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    onNavItemTap(entry.key);
                  },
                  child: Column(
                    children: [
                      Text(
                        "0${entry.key + 1}.",
                        style: GoogleFonts.firaCode(
                          color: AppTheme.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        entry.value,
                        style: GoogleFonts.firaCode(
                          color: activeIndex == entry.key
                              ? AppTheme.primaryColor
                              : AppTheme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(40),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  launchUrl(
                    Uri.parse("assets/assets/Hetvi_Shah_Flutter(4+ Years).pdf"),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                  side: const BorderSide(color: AppTheme.primaryColor),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  "Resume",
                  style: GoogleFonts.firaCode(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
