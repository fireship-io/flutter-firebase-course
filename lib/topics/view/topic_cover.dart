import 'package:flutter/material.dart';
import 'package:ui_toolkit/ui_toolkit.dart';

class TopicCover extends StatelessWidget {
  const TopicCover(this.imageName, {super.key});

  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Assets.covers.imageByName(imageName);
  }
}
