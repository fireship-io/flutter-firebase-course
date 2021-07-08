import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cubit/app_cubit.dart';

class AppPages {
  static List<Page> onGenerateAppPages(
    AppStatus status,
    List<Page<dynamic>> pages,
  ) {
    if (status.isUnauthenticated) {
      return [
        MaterialPage(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
          ),
        )
      ]; //LoginPage.page()
    }
    if (status.isNewlyAuthenticated) {
      return [
        MaterialPage(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Topics'),
            ),
          ),
        )
      ]; //TopicsPage.page()
    }
    return pages;
  }
}
