import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/entrance_fader.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onWorkTap;
  const HeroSection({super.key, required this.onWorkTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Container(
      height: size.height,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EntranceFader(
            delay: const Duration(milliseconds: 200),
            child: Text(
              "Hi, my name is",
              style: GoogleFonts.firaCode(
                color: AppTheme.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          EntranceFader(
            delay: const Duration(milliseconds: 400),
            child: Text(
              "Hetvi Shah.",
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(fontSize: isDesktop ? 80 : 40),
            ),
          ),
          EntranceFader(
            delay: const Duration(milliseconds: 600),
            child: Text(
              "I build scalable cross-platform apps.",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isDesktop ? 70 : 35,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ),
          const SizedBox(height: 25),
          EntranceFader(
            delay: const Duration(milliseconds: 800),
            child: SizedBox(
              width: 600,
              child: Text(
                "I'm a Flutter Developer specializing in building (and occasionally designing) exceptional digital experiences. Currently, I'm focused on building accessible, human-centered products at Openxcell Technolabs.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 50),
          EntranceFader(
            delay: const Duration(milliseconds: 1000),
            child: OutlinedButton(
              onPressed: onWorkTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primaryColor,
                side: const BorderSide(color: AppTheme.primaryColor, width: 2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                "Check out my work!",
                style: GoogleFonts.firaCode(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
