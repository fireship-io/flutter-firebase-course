import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class TopicCover extends StatelessWidget {
  const TopicCover(this.imageName, {super.key});

  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Assets.covers.imageByName(imageName);
  }
}
