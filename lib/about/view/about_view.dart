import 'package:flutter/material.dart';
import 'package:quizapp/l10n/l10n.dart';
import 'package:ui_toolkit/ui_toolkit.dart';

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
