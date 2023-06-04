import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/l10n/l10n.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.aboutLabel),
        backgroundColor: QuizColors.blue,
      ),
      body: const Center(
        child: Text('About this app...'),
      ),
    );
  }
}
