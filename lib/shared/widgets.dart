import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'extensions.dart';

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
