import 'package:flutter/material.dart';
import 'package:quizapp/shared/shared.dart';
import 'package:shared/shared.dart';

class TopicCover extends StatelessWidget {
  const TopicCover(this.imageName, {Key? key}) : super(key: key);

  final String imageName;

  @override
  Widget build(BuildContext context) {
    final _imageName = imageName.isEmpty ? kDefaultImageName : imageName;
    return Image.asset('$kCoversPath/$_imageName');
  }
}
