import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quizapp/shared/shared.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
    this.dotSize = 30.0,
  }) : super(key: key);

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
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 0, height: 0);
  }
}

class Failure extends StatelessWidget {
  const Failure(String message, {Key? key})
      : _message = message,
        super(key: key);

  final String _message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: kInsets,
      child: Text(
        _message,
        style: const TextStyle(
          color: kRed,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NoContent extends StatelessWidget {
  const NoContent(String message, {Key? key})
      : _message = message,
        super(key: key);

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
          color: kGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    Key? key,
    required this.value,
  })  : height = 12.0,
        super(key: key);

  const AnimatedProgressBar.mini({
    Key? key,
    required this.value,
  })  : height = 8.0,
        super(key: key);

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
    Key? key,
    required this.label,
    this.backgroundColor,
    this.onPressed,
  })  : _icon = null,
        super(key: key);

  const ActionButton.icon({
    Key? key,
    required this.label,
    required Widget icon,
    this.backgroundColor,
    this.onPressed,
  })  : _icon = icon,
        super(key: key);

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
