import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ui_toolkit/src/colors.dart';
import 'package:ui_toolkit/src/constants.dart';
import 'package:ui_toolkit/src/extensions.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    this.dotSize = 30.0,
  });

  final double dotSize;

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      size: dotSize,
      color: context.theme.colorScheme.primary,
    );
  }
}

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 0, height: 0);
  }
}

class FailureText extends StatelessWidget {
  const FailureText(String message, {super.key})
      : _message = message;

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: kInsets,
      child: Text(
        _message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: QuizColors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NoContent extends StatelessWidget {
  const NoContent(String message, {super.key})
      : _message = message;

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: kInsets,
      child: Text(
        _message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: QuizColors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    super.key,
    required this.value,
  })  : height = 12.0;

  const AnimatedProgressBar.mini({
    super.key,
    required this.value,
  })  : height = 8.0;

  final double value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;
        return Container(
          padding: kInsets / 3,
          width: maxWidth,
          child: Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: context.theme.backgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                height: height,
                width: maxWidth * value.clamp(0, value.abs()),
                decoration: BoxDecoration(
                  color: value.toRandomColor(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

extension _NumExtensions on num {
  Color toRandomColor() {
    final rbg = (this * 255).toInt();
    return Colors.deepOrange.withGreen(rbg).withRed(255 - rbg);
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    this.backgroundColor,
    this.onPressed,
  })  : _icon = null;

  const ActionButton.icon({
    super.key,
    required this.label,
    required Widget icon,
    this.backgroundColor,
    this.onPressed,
  })  : _icon = icon;

  final Widget label;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  final Widget? _icon;

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
        if (_icon != null)
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
