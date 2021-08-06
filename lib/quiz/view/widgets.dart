import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  const QuizButton({
    Key? key,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.onPressed,
  }) : super(key: key);

  final Widget label;
  final Widget? icon;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final style = TextButton.styleFrom(
      backgroundColor: backgroundColor,
      minimumSize: Size.zero,
      padding: const EdgeInsets.all(10),
    );
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        if (icon != null)
          TextButton.icon(
            onPressed: onPressed,
            label: label,
            icon: const Icon(Icons.poll),
            style: style,
          )
        else
          TextButton(
            onPressed: onPressed,
            style: style,
            child: label,
          )
      ],
    );
  }
}
