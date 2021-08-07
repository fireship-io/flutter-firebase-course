import 'package:flutter/material.dart';
import 'package:quizapp/shared/shared.dart';
import 'package:quizapp/l10n/l10n.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.aboutLabel),
        backgroundColor: kBlue,
      ),
      body: const Center(
        child: Text('About this app...'),
      ),
    );
  }
}
