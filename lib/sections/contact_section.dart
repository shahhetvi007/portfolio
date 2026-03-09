import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/reveal_on_scroll.dart';
import '../theme/app_theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 150,
      ),
      width: double.infinity,
      child: Column(
        children: [
          RevealOnScroll(
            child: Column(
              children: [
                Text(
                  "04. What's Next?",
                  style: GoogleFonts.firaCode(
                    color: AppTheme.primaryColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Get In Touch",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: isDesktop ? 60 : 40,
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 600,
                  child: Text(
                    "I'm currently looking for new opportunities, my inbox is always open. Whether you have a question or just want to say hi, I’ll try my best to get back to you!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 50),
                OutlinedButton(
                  onPressed: () => _showContactDialog(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryColor,
                    side: const BorderSide(
                      color: AppTheme.primaryColor,
                      width: 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    "Say Hello",
                    style: GoogleFonts.firaCode(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 150),
          Text(
            "Designed & Built by Hetvi Shah",
            style: GoogleFonts.firaCode(
              color: AppTheme.textSecondaryColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Built with Flutter Web",
            style: GoogleFonts.firaCode(
              color: AppTheme.textSecondaryColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final subjectController = TextEditingController();
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF112240),
        title: Text(
          "Send a Message",
          style: GoogleFonts.firaCode(
            color: AppTheme.primaryColor,
            fontSize: 20,
          ),
        ),
        content: SizedBox(
          width: 500,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(nameController, "Name", "Enter your name"),
                  const SizedBox(height: 15),
                  _buildTextField(emailController, "Email", "Enter your email"),
                  const SizedBox(height: 15),
                  _buildTextField(
                    subjectController,
                    "Subject",
                    "Enter subject",
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    messageController,
                    "Message",
                    "Enter your message",
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: AppTheme.textSecondaryColor),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: 'shahhetvi276@gmail.com',
                  query: _encodeQueryParameters({
                    'subject':
                        'Message from ${nameController.text}: ${subjectController.text}',
                    'body':
                        'Name: ${nameController.text}\nEmail: ${emailController.text}\n\nMessage:\n${messageController.text}',
                  }),
                );

                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri);
                } else {
                  // Fallback for some browsers
                  await launchUrl(
                    emailUri,
                    mode: LaunchMode.externalApplication,
                  );
                }
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: const Color(0xFF0A192F),
            ),
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppTheme.textSecondaryColor),
        hintText: hint,
        hintStyle: TextStyle(
          color: AppTheme.textSecondaryColor.withOpacity(0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.textSecondaryColor.withOpacity(0.5),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor),
        ),
        filled: true,
        fillColor: const Color(0xFF0A192F),
      ),
      validator: (value) => value == null || value.isEmpty ? "Required" : null,
    );
  }
}
