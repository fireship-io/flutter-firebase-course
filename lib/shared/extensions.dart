import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  void popUntil(RoutePredicate predicate) =>
      Navigator.of(this).popUntil(predicate);

  void showSnackBar(String text) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Future<T?> showScrollControlledBottomSheet<T>({
    required WidgetBuilder builder,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      builder: builder,
      isScrollControlled: true,
    );
  }
}
